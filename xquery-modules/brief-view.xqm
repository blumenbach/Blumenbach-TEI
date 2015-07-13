xquery version "3.0";

(:
: Module Name: brief-view
: Module Version: 
: Date: 
: License: GNU-LGPL
: 
: Module Overview: Functions for Single Brief View
:)

(:~ This module renders an HTML view for a single TEI Brief
:)

module namespace brief-view="http://exist-db.org/brief-view/";

import module namespace functx="http://www.functx.com" at "functx.xqm";
import module namespace filesize="filesize" at "filesize.xql";
import module namespace detail="http://exist-db.org/xquery/detail" at "detail.xql";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace so="http://standoff.proposal";
declare namespace xi="http://www.w3.org/2001/XInclude";
declare namespace util="http://exist-db.org/xquery/util";

declare function brief-view:render($nodes as node()*) {
    for $node in $nodes
    return
        typeswitch ($node)
            case text() return
                $node
            case element(tei:TEI) return
                brief-view:render($node/*)
            case element(tei:teiHeader) return
                brief-view:render-header($node)
            case element(tei:text) return
                <div xmlns="http://www.w3.org/1999/xhtml" class="body">{ brief-view:render($node//tei:body) }</div>
            default return
                $node/string()
};

declare function brief-view:render-header($header as element(tei:teiHeader)) {
    let $profileDesc := $header/tei:profileDesc
    let $notesStmt := $header/tei:fileDesc/tei:notesStmt    
    let $titleStmt := $header/tei:fileDesc/tei:titleStmt
    let $pubStmt := $header/tei:fileDesc/tei:publicationStmt
    let $sourceDesc := $header/tei:fileDesc/tei:sourceDesc
    let $space := '&#32;'
    return
    <div xmlns="http://www.w3.org/1999/xhtml" class="work-header">
        <div xmlns="http://www.w3.org/1999/xhtml" class="meta-table">
            {for $note in $notesStmt
                return
                <table class="table table-condensed table-bordered">
                    <thead>
                        <tr>
                            <th>Meta Element</th>
                            <th>Value</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="col-md-2">
                            <span>Titel: </span>
                            </td>
                              {for $title in $sourceDesc/tei:biblFull/tei:titleStmt/tei:title[@type="source"]
                                let $tit :=   
                                        brief-view:convert-ref($title, $header)
                                return
                                  <td>
                                    {$tit} 
                                  </td>          
                              }
                        </tr>                    
                        <tr>
                            <td class="col-md-2">
                            <span>Abfassungsdatum: </span>
                            </td>
                            <td>                                
                            <span>{data($profileDesc/tei:creation/tei:origDate/tei:note/tei:listEvent/tei:event[@type="origin"]/tei:note/tei:date/@when)}</span>                               
                            </td>
                        </tr>
                        <tr>
                            <td class="col-md-2">
                            <span>Abfassungsort: </span>
                            </td>
                            <td>                                
                            <span>{$profileDesc/tei:creation/tei:placeName}</span>                               
                            </td>
                        </tr>                        
                        {for $abs in $titleStmt/tei:author/tei:persName
                        return
                        <tr>
                            <td class="col-md-2">
                            <span>Absender: </span>
                            </td>
                            <td>                                
                                {if ($abs/tei:forename) then
                                <span>{$abs/tei:forename/text()}{$space}{$abs/tei:surname/text()}</span>
                                else
                                <span>{$abs/text()}</span>
                                }                                
                            </td>
                        </tr>
                        }
                        {for $emph in $profileDesc/tei:creation/tei:persName
                        return
                        <tr>
                            <td class="col-md-2">
                            <span>Empfanger: </span>
                            </td>
                            <td>
                            {if ($emph/tei:forename) then 
                            <span>{$emph/tei:forename/text()}{$space}{$emph/tei:surname/text()}</span>
                            else
                            <span>{$emph/text()}</span>
                            }
                            </td>
                        </tr>
                        }
                        {for $uber in $note/tei:note[@type="Überlieferung"]
                        return
                        if ($uber) then
                            let $ub := brief-view:convert-ref($uber, $header)
                            return
                            <tr>
                                <td class="col-md-2">
                                    <span>Überlieferung: </span>
                                </td>
                                <td>
                                {$ub} 
                                </td>
                             </tr>
                         else ()    
                         }
                         {for $drucke in $note/tei:note[@type="Drucke"]/tei:bibl
                          return
                          if ($drucke) then
                               let $dr := brief-view:convert-ref($drucke, $header)
                               return
                               <tr>
                                    <td class="col-md-2" >
                                     <span>Drucke: </span>
                                    </td>
                                    <td>
                                    {$dr} 
                                    </td> 
                               </tr>
                            else ()   
                          }
                          {for $edition in $note/tei:note[@type="Edition"]/tei:bibl/tei:edition
                          return
                              if ($edition) then
                                    let $ed := brief-view:convert-ref($edition, $header)
                                    return
                                    <tr>
                                        <td class="col-md-2">
                                            <span>Edition: </span>
                                        </td>
                                        <td>
                                        {$ed} 
                                        </td>
                                    </tr>
                               else ()     
                           }                            
                           {for $werke in $note/tei:note[@type="Werke"]/tei:bibl/tei:relatedItem/tei:bibl
                            return
                                if ($werke) then
                                       let $werk := brief-view:convert-ref($werke, $header)
                                       return
                                        <tr>
                                            <td class="col-md-2" >
                                                <span>Werke: </span>
                                            </td>
                                            <td>
                                            {$werk} 
                                            </td>
                                        </tr>
                                 else ()       
                            }             
                            {for $objekte in $note/tei:note[@type="Objekte"]/tei:rs
                            return
                                if ($objekte) then
                                      let $obj := brief-view:convert-ref($objekte, $header)
                                      return
                                      <tr>
                                            <td class="col-md-2">
                                            <span>Objekte: </span>
                                            </td>
                                            <td>
                                            {$obj} 
                                            </td>
                                      </tr>
                                else ()      
                            }                            
                            {for $anmerk in $note/tei:note[@type="Anmerkung"]/tei:note
                            return
                            if ($anmerk) then
                                let $anm := brief-view:convert-ref($anmerk, $header)
                                return
                                <tr>
                                    <td class="col-md-2">
                                        <span>Anmerkung: </span>
                                    </td>
                                    <td>
                                    {$anm}
                                    </td>
                                </tr>
                            else ()    
                            }
                </tbody>
                </table>
            }
            </div>
         {brief-view:render-brief-refs($header)}   
        <div xmlns="http://www.w3.org/1999/xhtml" class="brief-body">    
        </div>
    </div>      
};

declare function brief-view:render-brief-refs($header as element(tei:teiHeader)) {
    let $notesStmt := $header/tei:fileDesc/tei:notesStmt 
    return
    if ($notesStmt/tei:note[@type="ref"]) then
    <div xmlns="http://www.w3.org/1999/xhtml" class="meta-table">
     <table class="table table-condensed table-bordered">
        <thead>
            <tr>
                <th>References</th>
            </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <table class="table table-condensed table-bordered">   
                    {for $ref at $i in $notesStmt/tei:note[@type="ref"]
                    return
                        if ($ref) then
                        let $id := request:get-parameter('id', '00001')
                        let $uri := request:get-uri() || '?id=' || $id || '#cite_ptr-' || data($ref/tei:ref/@n)
                        return
                        <tr>
                            <td class="col-md-2">
                            <li id="cite_note-{data($ref/tei:ref/@n)}">{data($ref/tei:ref/@n)} <a href="{$uri}">  ^</a></li>
                            </td>
                            <td>
                            <table>
                            {let $output := 
                                if ($ref/tei:ref[@type="pdf"]) then        
                                    for $pdfref in $ref/tei:ref[@type="pdf"]
                                        let $uri := $pdfref
                                        let $filename := 
                                            if ($pdfref/following-sibling::tei:rs/text()) then
                                                $pdfref/following-sibling::tei:rs/text()
                                                else 
                                                tokenize($uri, "/")[last()]                                
                                        return
                                        <tr>
                                            <td>
                                             <dl class="dl-horizontal">
                                                <dt id="pdficon"></dt>
                                                <dd><a href="{$uri}">{$filename}</a> [{filesize:get-size($uri)}]</dd>
                                             </dl>   
                                            </td>
                                        </tr>
                                else if ($ref/tei:ref[@type="html"]) then
                                    for $htmlref in $ref/tei:ref[@type="html"]
                                       let $uri := $htmlref
                                       let $filename := 
                                         if ($htmlref/following-sibling::tei:rs/text()) then
                                          $htmlref/following-sibling::tei:rs/text()
                                         else 
                                           tokenize($uri, "/")[last()]                                   
                                       return
                                       <tr>
                                           <td>
                                           <a href="{$htmlref}">{$filename}</a>
                                           </td>
                                       </tr>
                                else if ($ref/tei:ref[@type="restxq"]) then
                                    for $xqref in $ref/tei:ref[@type="restxq"]
                                    let $uri := $xqref
                                    let $filename := 
                                        if ($xqref/tei:rs/text()) then
                                          $xqref/tei:rs/text()
                                        else
                                        $xqref/text()
                                    return
                                    <tr>
                                        <td>
                                        <a href="{$xqref}">{$filename}</a>
                                        </td>
                                    </tr>
                                else if ($ref/tei:ref[@type="xprof"]) then
                                    for $xprof in $ref/tei:ref[@type="xprof"]
                                    let $uri := $xprof
                                    let $filename := 
                                        if ($xprof/tei:rs/text()) then
                                          $xprof/tei:rs/text()
                                        else
                                        $xprof/text()                
                                    return
                                    <tr>
                                        <td>
                                        <a href="{$xprof}">{$filename}</a>
                                        </td>
                                    </tr>
                                else
                                ()
                          return $output
                         }
                         </table>
                         </td>
                         </tr>
                    else ()
                    }
                </table>
            </td>     
        </tr>
     </tbody>
     </table>
</div>
else ()
};


declare function brief-view:convert-ref ($node as node()*, $header as node()*) {
    typeswitch ($node)
        case text() return $node
        case element(tei:emph) 
            return
             <em>{$node}</em>        
        case element(tei:ptr)
            return
            let $tgtref := $header/id($node/@target)
            let $seq := data($tgtref/@n)
            let $id := request:get-parameter('id', '00001')
            let $uri := request:get-uri() || '?id=' || $id || '#cite_note-' || data($tgtref/@n)           
            return
            <sup><a id="cite_ptr-{$seq}" href="{$uri}">[{$seq}]</a></sup>
        default return brief-view:passthru-ref($node, $header)    
 };
 
 declare function brief-view:passthru-ref($nodes as node()*, $header as node()*) as item()* {
    for $node in $nodes/node() return brief-view:convert-ref($node, $header)
};

declare %private function brief-view:get-id($node as element()) {
    ($node/@xml:id, $node/@exist:id)[1]
};