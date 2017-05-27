xquery version "3.0";

(:
: Module Name: taxon-detail
: Module Version: 
: Date: 
: License: GNU-LGPL
: 
: XQuery Specification : XQuery v3.0
: Module Overview: Functions supporting taxon view rendering
:)

(:~ Functions supporting taxon view rendering
:)

module namespace taxon-detail="http://exist-db.org/xquery/taxon-detail";

import module namespace templates="http://exist-db.org/xquery/templates" at "templates.xql";
import module namespace config="http://exist-db.org/xquery/apps/blume/config" at "config.xqm";
import module namespace taxon-view="http://exist-db.org/xquery/taxon-view" at "taxon-view.xqm";
import module namespace functx="http://www.functx.com" at "functx.xqm";
import module namespace util="http://exist-db.org/xquery/util";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare 
    %templates:wrap
function taxon-detail:get-taxon($node as node(), $model as map(*), $id as xs:string, $status as xs:string?) {
    let $taxons := 
       if ($status = 'staged') then
        collection($config:orbeon-publish)/tei:TEI
       else
        collection($config:werke-collection)/tei:TEI
    for $taxon in $taxons
    where $taxon/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='taxon'] = $id
    return
        map { "taxon" := $taxon }
};

declare function taxon-detail:taxon-view($node as node(), $model as map(*)) {
    for $div in $model("taxon")  
    return
        <div xmlns="http://www.w3.org/1999/xhtml">
        { taxon-view:render($div) }
        </div>       
};

declare 
    %templates:wrap
function taxon-detail:outline($node as node(), $model as map(*), $details as xs:string, $id as xs:string?) {
    let $details := $details = "yes"
    let $taxon := $model("taxon")
    let $path := substring-before(request:get-uri(), '/view-taxon.html')
    let $worklist := concat($node/@href, $path, '/werke.html')
    let $file := util:document-name($taxon)
    let $restxq := concat('/restxq/werke/', $id)
    let $tei-path := concat($config:werke-collection, '/', $file)
    return
        if ($taxon)
        then
            <table xmlns="http://www.w3.org/1999/xhtml" class="table table-condensed table-bordered">
                    <tr>
                        <td>
                            <span>Edit: </span>
                        </td>
                        <td>                                
                            <span>{taxon-detail:xml-link($node, $model, $file, $tei-path)}</span>                     
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>Form:</span>
                        </td>
                        <td>                                
                            <span>{taxon-detail:orbeon-link($node, $model, $file)}</span>                     
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
               </table>
        else ()
};

declare function taxon-detail:navigation($node as node(), $model as map(*), $id as xs:string) {
    let $taxon := $model("taxon")
    (:
    let $seq := substring-before(data($taxon/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='cat']/tei:idno/@n), '.00')
    :)
    let $seq := $id
    let $next := number($seq) + number(1)
    let $prev := number($seq) - number(1)
    let $path := request:get-uri()
    let $href := $path || "?id="
    let $prevWork := $href || functx:pad-integer-to-length($prev, 4)
    let $nextWork := $href || functx:pad-integer-to-length($next, 4)
    return
        element { node-name($node) } {
            $node/@*,
            if ($prevWork) then
                <a xmlns="http://www.w3.org/1999/xhtml" href="{$prevWork}" class="previous">
                    <i class="glyphicon glyphicon-chevron-left"/> Previous Taxon</a>
            else
                (),
            if ($nextWork) then
                <a xmlns="http://www.w3.org/1999/xhtml" href="{$nextWork}" class="next">
                    Next Taxon<i class="glyphicon glyphicon-chevron-right"/></a>
            else
                (),
            <br/>     
        }
};

declare function taxon-detail:xml-link($node as node(), $model as map(*), $file as xs:string, $tei-path as xs:string) {
    let $doc-path := document-uri(root($model("taxon")))    
    let $eXide-link := templates:link-to-app("http://exist-db.org/apps/eXide", "index.html?open=" || $tei-path)
    let $rest-link := '/exist/rest' || $doc-path
    return
        if (xmldb:collection-available('/db/apps/eXide'))
        then <a xmlns="http://www.w3.org/1999/xhtml" href="{$eXide-link}" target="_blank">{ $file }</a>
        else <a xmlns="http://www.w3.org/1999/xhtml" href="{$rest-link}" target="_blank">{ $node/node() }</a>
};

declare function taxon-detail:orbeon-link($node as node(), $model as map(*), $file as xs:string) {
    let $doc-path := document-uri(root($model("taxon")))
    let $id := substring-before(functx:substring-after-last($file, '_'),'.xml')    
    let $href := $config:orbeon-bb || '/taxon/edit?id=' || $id
    return
        <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}" target="_blank">{ $file }</a>
};

declare function taxon-detail:api-link($repo as xs:string?, $idno as xs:string?, $color as xs:string?, $icon as xs:string?) {
    if ($repo = "SUB Göttingen") then
    let $opaclink := concat('https://opac.sub.uni-goettingen.de/DB=1/SET=3/TTL=1/CMD?ACT=SRCHA&amp;IKT=5025&amp;SRT=YOP&amp;TRM=', $idno)    
    let $link := <a class="phui-tag-view phui-tag-type-object phui-tag-shade phui-tag-shade-{$color} phui-tag-icon-view" target="_blank" href="{$opaclink}"><span class="phui-tag-core"><span class="visual-only phui-icon-view phui-font-fa fa-{$icon}" aria-hidden="true"></span>{$idno}</span></a>
    return $link
    else
    ()
};

declare function taxon-detail:render-token($href as xs:string?, $idno as xs:string?, $color as xs:string?, $icon as xs:string?) {
    let $token := <a class="phui-tag-view phui-tag-type-object phui-tag-shade phui-tag-shade-{$color} phui-tag-icon-view" target="_blank" href="{$href}"><span class="phui-tag-core"><span class="visual-only phui-icon-view phui-font-fa fa-{$icon}" aria-hidden="true"></span>{$idno}</span></a>
    return $token
};
