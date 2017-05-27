xquery version "3.0";

(:
: Module Name: detail
: Module Version: 
: Date: 
: License: GNU-LGPL
: 
: XQuery Specification : XQuery v3.0
: Module Overview: Functions supporting view rendering
:)

(:~ This module contains functions that support the rendering of a view
:)

module namespace detail="http://exist-db.org/xquery/detail";
declare namespace request="http://exist-db.org/xquery/request";
import module namespace templates="http://exist-db.org/xquery/templates" at "templates.xql";
import module namespace config="http://exist-db.org/xquery/apps/blume/config" at "config.xqm";
import module namespace werk-view="http://exist-db.org/xquery/werk-view" at "werk-view.xqm";
import module namespace brief-view="http://exist-db.org/xquery/brief-view" at "brief-view.xqm";
import module namespace kwic="http://exist-db.org/xquery/kwic" at "resource:org/exist/xquery/lib/kwic.xql";
import module namespace functx="http://www.functx.com" at "functx.xqm";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare 
    %templates:wrap
function detail:get-brief($node as node(), $model as map(*), $id as xs:string, $status as xs:string?) {
    let $briefs := 
        if ($status = 'staged') then
        collection($config:orbeon-publish)/tei:TEI
        else
        collection($config:brief-collection)/tei:TEI
    for $brief in $briefs
    where $brief/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/tei:idno = $id
    return
        map { "brief" := $brief }
};

declare 
    %templates:wrap
function detail:get-briefs-for-work($id as xs:string) {
     let $briefs := collection($config:brief-collection)//tei:TEI
    for $brief in $briefs
    for $rs in $brief//tei:rs[@type='html']
    let $bid := $brief/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/tei:idno
    let $rstrim := functx:substring-before-if-contains($rs, ' ')
    let $href := 
        if ($bid) then
        concat('./view-brief.html?id=', $bid)
        else ()
    where $rstrim = $id
    order by $bid ascending
    return
            detail:render-token($href, $bid, 'grey', 'envelope') 
};

declare 
    %templates:wrap
function detail:outline($node as node(), $model as map(*), $details as xs:string, $id as xs:string?) {
    let $details := $details = "yes"
    let $brief := $model("brief")
    let $path := substring-before(request:get-uri(), '/view-brief.html')
    let $brieflist := concat($node/@href, $path, '/briefs.html')    
    let $file := concat('jfb_br_' , $brief/ancestor-or-self::tei:TEI/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/tei:idno, '.xml')
    let $restxq := concat('/exist/restxq/briefe/', $id)
    let $docname := util:document-name($brief)
let $tei-path := concat($config:brief-collection, '/', $docname)
    return
        if ($brief)
        then
            <table xmlns="http://www.w3.org/1999/xhtml" class="table table-condensed table-bordered">
                    <tr>
                        <td>
                            <span>Edit: </span>
                        </td>
                        <td>                                
                            <span>{detail:xml-link($node, $model, $file, $tei-path)}</span>                     
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>RESTXQ: </span>
                        </td>
                        <td>                                
                            {detail:render-token($restxq, $id, 'indigo', 'globe')}                    
                        </td>
                    </tr>                      
                    <tr>
                        <td>
                            <span>Lists: </span>
                        </td>
                        <td>                                
                            <a xmlns="http://www.w3.org/1999/xhtml" href="{$brieflist}">Briefregesten</a>                     
                        </td>
                    </tr>                    
               </table>
        else ''
};

declare function detail:brief-view($node as node(), $model as map(*), $query as xs:string?) {
    for $div in $model("brief")
    let $div :=
        if ($query) then
            util:expand(($div[.//tei:sp[ft:query(., $query)]], $div[.//tei:lg[ft:query(., $query)]]), "add-exist-id=all")
        else
            $div
    return
        <div xmlns="http://www.w3.org/1999/xhtml">
        { brief-view:render($div) }
        </div>
};

declare function detail:navigation($node as node(), $model as map(*), $id as xs:string) {
    let $brief := $model("brief")
    let $next := number($id) + number(1)
    let $prev := number($id) - number(1)
    let $path := request:get-uri()
    let $href := $path || "?id=" 
    let $prevBrief := $href || functx:pad-integer-to-length($prev, 4)
    let $nextBrief := $href || functx:pad-integer-to-length($next, 4)
    let $date := $brief/ancestor-or-self::tei:TEI/tei:teiHeader/tei:profileDesc/tei:creation/tei:origDate/tei:note/tei:listEvent/tei:event[@type="origin"]/tei:note/tei:date
    return
        element { node-name($node) } {
            $node/@*,
            if ($prevBrief) then
                <a xmlns="http://www.w3.org/1999/xhtml" href="{$prevBrief}" class="previous">
                    <i class="glyphicon glyphicon-chevron-left"/> Previous Brief</a>
            else
                (),
            if ($nextBrief) then
                <a xmlns="http://www.w3.org/1999/xhtml" href="{$nextBrief}" class="next">
                    Next Brief<i class="glyphicon glyphicon-chevron-right"/></a>
            else
                (),
            <h5 xmlns="http://www.w3.org/1999/xhtml">{$date}</h5>
        }
};

declare 
    %templates:wrap
function detail:get-work($node as node(), $model as map(*), $id as xs:string, $status as xs:string?) {
    let $works := 
        if ($status = 'staged') then
            collection($config:orbeon-publish)/tei:TEI
        else
            collection($config:werke-collection)/tei:TEI
    for $work in $works
    where $work/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='BiblNr'] = $id
    return
        map { "work" := $work }
};

declare 
    %templates:wrap
function detail:work-outline($node as node(), $model as map(*), $details as xs:string, $id as xs:string?) {
    let $details := $details = "yes"
    let $work := $model("work")
    let $path := substring-before(request:get-uri(), '/view-work.html')
    let $worklist := concat($node/@href, $path, '/werke.html')
    let $file := $work/ancestor-or-self::tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno
    let $repo := $work/ancestor-or-self::tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:repository
    let $idno := $work/ancestor-or-self::tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:idno
    let $restxq := concat('/exist/restxq/werke/', $id)
    let $docname := util:document-name($work)
    let $tei-path := concat($config:werke-collection, '/', $docname)
    return
        if ($work)
        then
            <table xmlns="http://www.w3.org/1999/xhtml" class="table table-condensed table-bordered">
                    <tr>
                        <td>
                            <span>Edit: </span>
                        </td>
                        <td>                                
                            <span>{detail:xml-link($node, $model, $file, $tei-path)}</span>                     
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>RESTXQ: </span>
                        </td>
                        <td>                                
                            {detail:render-token($restxq, $id, 'indigo', 'globe')}                    
                        </td>
                    </tr>                    
                     <tr>
                        <td>
                            <span>Lists: </span>
                        </td>
                        <td>                                
                            <a xmlns="http://www.w3.org/1999/xhtml" href="{$worklist}">Werke</a>                     
                        </td>
                    </tr>
                     {let $briefs := detail:get-briefs-for-work($id)
                        return
                            if ($briefs) then
                            <tr>
                              <td>
                                  <span>Vgl. Briefe:</span>
                              </td>
                              <td>                                
                                  {for $brief in $briefs
                                  return
                                  <ul>
                                    <li>{$brief}</li>
                                  </ul>  
                                  }                     
                              </td>
                            </tr>  
                            else ()
                      }  
                   
               </table>
        else ()
};

declare function detail:work-view($node as node(), $model as map(*)) {
    for $div in $model("work")  
    return
        <div xmlns="http://www.w3.org/1999/xhtml">
        { werk-view:render($div) }
        </div>       
};

declare function detail:work-navigation($node as node(), $model as map(*), $id as xs:string) {
    let $work := $model("work")
    let $next := number($id) + number(1)
    let $prev := number($id) - number(1)
    let $path := request:get-uri()
    let $href := $path || "?id="
    let $prevWork := $href || functx:pad-integer-to-length($prev, 5)
    let $nextWork := $href || functx:pad-integer-to-length($next, 5)
    let $date := $work/ancestor-or-self::tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date[@type="publication"]/text()
    return
        element { node-name($node) } {
            $node/@*,
            if ($prevWork) then
                <a xmlns="http://www.w3.org/1999/xhtml" href="{$prevWork}" class="previous">
                    <i class="glyphicon glyphicon-chevron-left"/> Previous Work</a>
            else
                (),
            if ($nextWork) then
                <a xmlns="http://www.w3.org/1999/xhtml" href="{$nextWork}" class="next">
                    Next Work<i class="glyphicon glyphicon-chevron-right"/></a>
            else
                (),
            <h5 xmlns="http://www.w3.org/1999/xhtml">{$date}</h5>
        }
};

declare function detail:xml-link($node as node(), $model as map(*), $file as xs:string, $tei-path as xs:string) {
    let $doc-path := document-uri(root($model("brief")))    
    let $eXide-link := templates:link-to-app("http://exist-db.org/apps/eXide", "index.html?open=" || $tei-path)
    let $rest-link := '/exist/rest' || $doc-path
    return
        if (xmldb:collection-available('/db/apps/eXide'))
        then <a xmlns="http://www.w3.org/1999/xhtml" href="{$eXide-link}" target="_blank">{ $file }</a>
        else <a xmlns="http://www.w3.org/1999/xhtml" href="{$rest-link}" target="_blank">{ $node/node() }</a>
};

declare function detail:search-link($node as node(), $model as map(*), $field as xs:string?) {
    let $query := 
            if ($field = "Absender")
            then
            $model("brief")/ancestor-or-self::tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName[1]/tei:surname
            else if ($field = "Empfanger")
            then
            $model("brief")/ancestor-or-self::tei:TEI/tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"][1]/tei:surname
            else 
            $field
    let $jhr := ''
    let $path := substring-before(request:get-uri(), 'view-brief.html')
    let $qparam :=  "query=" || $query
    let $jparam :=  "jhr=" || $jhr
    let $params := string-join(($qparam, $jparam), "&amp;")
    let $href := $path || "brief-list.html?" || $params
    return
       <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}" target="_blank">{$field}</a>
};

declare function detail:api-link($repo as xs:string?, $idno as xs:string?, $color as xs:string?, $icon as xs:string?) {
    if ($repo = "SUB Göttingen") then
    let $opaclink := concat('https://opac.sub.uni-goettingen.de/DB=1/SET=3/TTL=1/CMD?ACT=SRCHA&amp;IKT=5025&amp;SRT=YOP&amp;TRM=', $idno)    
    let $link := <a class="phui-tag-view phui-tag-type-object phui-tag-shade phui-tag-shade-{$color} phui-tag-icon-view" target="_blank" href="{$opaclink}"><span class="phui-tag-core"><span class="visual-only phui-icon-view phui-font-fa fa-{$icon}" aria-hidden="true"></span>{$idno}</span></a>
    return $link
    else
    ()
};

declare function detail:render-token($href as xs:string?, $idno as xs:string?, $color as xs:string?, $icon as xs:string?) {
    let $token := <a class="phui-tag-view phui-tag-type-object phui-tag-shade phui-tag-shade-{$color} phui-tag-icon-view" target="_blank" href="{$href}"><span class="phui-tag-core"><span class="visual-only phui-icon-view phui-font-fa fa-{$icon}" aria-hidden="true"></span>{$idno}</span></a>
    return $token
};

