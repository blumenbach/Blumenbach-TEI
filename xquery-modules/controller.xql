xquery version "3.0";

declare namespace json="http://www.json.org";
import module namespace theme="http://exist-db.org/xquery/theme" at "modules/theme.xqm";
import module namespace login-helper="http://exist-db.org/apps/blumenbach/login-helper" at "modules/login-helper.xql";
import module namespace config="http://exist-db.org/apps/blume/config" at "modules/config.xqm";
declare namespace atom="http://www.w3.org/2005/Atom";

declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;
declare variable $exist:root external;
declare variable $exist:prefix external;

declare variable $login := login-helper:get-login-method();

declare function local:extract-feed($path as xs:string) {
    for $cmp in analyze-string($path, '^/?(.*)/([^/]*)$')//fn:group/string()
    return
        xmldb:decode-uri($cmp)
};

declare function local:user-allowed() {
    (
        request:get-attribute("org.exist.login.user") and
        request:get-attribute("org.exist.login.user") != "guest"
    ) or config:get-configuration()/restrictions/@guest = "yes"
};

declare function local:query-execution-allowed() {
    (
    config:get-configuration()/restrictions/@execute-query = "yes"
        and
    local:user-allowed()
    )
        or
    xmldb:is-admin-user((request:get-attribute("org.exist.login.user"),request:get-attribute("xquery.user"), 'nobody')[1])
};

declare function local:dispatch-login() {
        <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
            <forward url="{$exist:controller}/pages/forms/login.html"/>
            <view>
                <forward url="{$exist:controller}/modules/view.xql">
                    <set-attribute name="$exist:prefix" value="{$exist:prefix}"/>
                    <set-attribute name="$exist:controller" value="{$exist:controller}"/>
                    <set-header name="Cache-Control" value="no-cache"/>
                </forward>
            </view>
        </dispatch>  
};

declare function local:doc-view($template, $relPath) {
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="{theme:resolve('docs', $exist:root, $template)}">
            <set-header name="Cache-Control" value="no-cache"/>
        </forward>
        <view>
            <forward url="{$exist:controller}/modules/view.xql" absolute="no">
                <set-attribute name="exist.path" value="{$exist:path}"/>
                <add-parameter name="wiki-id" value="{$relPath[2]}"/>
            </forward>
        </view>
    </dispatch>
};

if ($exist:path eq "/") then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="index.html"/>
    </dispatch>

else if ($exist:resource = "login") then (
    try {
        let $loggedIn := $login("org.exist.login", (), true())
        return
            if (xmldb:get-current-user() != "guest") then
               <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                   <redirect url="index.html"/>
               </dispatch>
            else (
                <response>
                    <fail>Wrong user or password</fail>
                </response>
            )
    } catch * {
        <response>
            <fail>{$err:description}</fail>
        </response>
    }
)

else if (contains($exist:path, "/$shared/")) then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="/shared-resources/{substring-after($exist:path, '/$shared/')}">
            <!--set-header name="Cache-Control" value="max-age=3600, must-revalidate"/-->
        </forward>
    </dispatch>

(: Requests for javascript libraries are resolved to the file system :)
else if (contains($exist:path, "/resources/")) then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="{$exist:controller}/resources/{substring-after($exist:path, '/resources/')}"/>
    </dispatch>
    
else if (contains($exist:path, "/forms")) then (
    $login("org.exist.login", (), false()),
    if (request:get-attribute("org.exist.demo.login.user")) then
        <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
            <redirect url="{$exist:prefix}/{$exist:controller}/pages/forms/tei-notes.html?restxq={request:get-context-path()}/restxq/"/>
        </dispatch>
    else
        local:dispatch-login()
)

else if (contains($exist:path, "/edit")) then (
    $login("org.exist.login", (), false()),
    if (request:get-attribute("org.exist.demo.login.user")) then
        <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
            <redirect url="{$exist:prefix}/{$exist:controller}/edit/edit.xq"/>
        </dispatch>
    else
        local:dispatch-login()
)

else if (contains($exist:path, "/docs")) then (
        let $template:= "docs.html"
        let $relPath := local:extract-feed($exist:path)
        let $feed := 
            if ($relPath[1] = 'docs') then
                 xmldb:xcollection($config:wiki-root)/atom:feed
            else if ($relPath[1]) then
                config:resolve-feed($relPath[1])
            else
            ()
        (: let $feed := xmldb:xcollection($path)/atom:feed :)
            (: The feed XML will be saved to a request attribute :)
        let $setAttr := request:set-attribute("feed", $feed)
        return
        local:doc-view($template, $relPath)
)
 
else if (starts-with($exist:path, "/")) then
    let $id := request:get-parameter("id", ())
    let $method := request:get-parameter("method", ())
    return
        if (ends-with($exist:resource, ".epub")) then
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{$exist:controller}/modules/get-epub.xql">
                    <add-parameter name="id" value="{$id}"/>
                </forward>
                <error-handler>
                    <forward url="{$exist:controller}/error-page.html" method="get"/>
                    <forward url="{$exist:controller}/modules/view.xql"/>
                </error-handler>
            </dispatch>
        else if (ends-with($exist:resource, ".tei")) then
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
            	<view>
            		<forward servlet="XSLTServlet">
            			<set-attribute name="xslt.stylesheet" 
            				value="xmldb:exist:///db/styles/styles/html/html.xsl"/>
            		    <set-attribute name="xslt.output.media-type"
                            value="text/html"/>
                        <set-attribute name="xslt.output.doctype-public"
                            value="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
                        <set-attribute name="xslt.output.doctype-system"
                            value="resources/xhtml1-transitional.dtd"/>
            		</forward>
            	</view>
                <cache-control cache="no"/>
            </dispatch>        
        else if (ends-with($exist:resource, ".pdf")) then
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{$exist:controller}/modules/tei2fo.xql">
                    <add-parameter name="id" value="{$id}"/>
                </forward>
                <error-handler>
                    <forward url="{$exist:controller}/error-page.html" method="get"/>
                    <forward url="{$exist:controller}/modules/view.xql"/>
                </error-handler>
            </dispatch>
        else if ($exist:resource = "jfb_br_corpus.xml") then
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{$exist:controller}/modules/export.xql">
                    <add-parameter name="type" value="br-corpus"/>                
                </forward>     	
                <cache-control cache="no"/>
            </dispatch>
        else if ($exist:resource = "jfb_briefregesten.xml") then
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{$exist:controller}/modules/export.xql">
                    <add-parameter name="type" value="br"/>                 
                </forward>     	
                <cache-control cache="no"/>
            </dispatch>
        else if ($exist:resource = "jfb_bibliographie.xml") then
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{$exist:controller}/modules/export.xql">
                    <add-parameter name="type" value="werke-corpus"/>                 
                </forward>     	
                <cache-control cache="no"/>
            </dispatch>
        else if ($exist:resource = "jfb_bibliographie-taxons.xml") then
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{$exist:controller}/modules/export.xql">
                    <add-parameter name="type" value="taxon"/>                 
                </forward>     	
                <cache-control cache="no"/>
            </dispatch> 
        else if ($exist:resource = "transform.xml" and $method = "save") then (
            $login("org.exist.login", (), false()),
            if (request:get-attribute("org.exist.login.user")) then        
                <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                    <forward url="{$exist:controller}/modules/xtransform.xqm">
                    </forward>
                    <view>
                        <redirect url="{$exist:prefix}/{$exist:controller}/admin/view-form-data.html">                     
                        </redirect>
                    </view>
                </dispatch>
            else
                local:dispatch-login() 
        )        
        else if ($exist:resource = "transform.xml" and $method = "download") then
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{$exist:controller}/modules/xtransform.xqm">
                </forward>     	
                <cache-control cache="no"/>
            </dispatch>
        else if ($exist:resource = "publish.xml") then (
            $login("org.exist.login", (), false()),
            if (request:get-attribute("org.exist.login.user")) then        
                <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                    <forward url="{$exist:controller}/modules/publish.xqm">
                    </forward>
                     <view>
                        <redirect url="{$exist:prefix}/{$exist:controller}/admin/view-xform-tei.html">                    
                        </redirect>
                    </view>
                </dispatch>
            else
                local:dispatch-login()
        ) 
 
        else if (contains($exist:path, "/admin/")) then (
             $login("org.exist.login", (), false()),
             if (request:get-attribute("org.exist.login.user")) then
                <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{theme:resolve('admin', $exist:root, $exist:resource)}"/>
                    <view>
                        <forward url="{$exist:controller}/modules/view.xql">
                        </forward>
                    </view>
                </dispatch>
            else
                local:dispatch-login()
        )
 
        else if (ends-with($exist:path, ".html")) then
           <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{theme:resolve($exist:prefix, $exist:root, $exist:resource)}"/>
                <view>
                    <forward url="{$exist:controller}/modules/view.xql">
                    </forward>
                </view>
                <error-handler>
                    <forward url="{$exist:controller}/error-page.html" method="get"/>
                    <forward url="{$exist:controller}/modules/view.xql"/>
                </error-handler>
            </dispatch>
       else
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{$exist:controller}/{$exist:resource}">
                </forward>
                <view>
                    <forward url="{$exist:controller}/modules/view.xql">
                        <add-parameter name="id" value="{$id}"/>
                    </forward>
                </view>
                <error-handler>
                    <forward url="{$exist:controller}/error-page.html" method="get"/>
                    <forward url="{$exist:controller}/modules/view.xql"/>
                </error-handler>
            </dispatch>
    
else
    (: everything else is passed through :)
    <ignore xmlns="http://exist.sourceforge.net/NS/exist">
        <cache-control cache="yes"/>
    </ignore>