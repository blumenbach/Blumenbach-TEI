xquery version "3.0";

(:
: Module Name: taxon-view
: Module Version: 
: Date: 
: License: GNU-LGPL
: 
: XQuery Specification : XQuery v3.0
: Module Overview: Renders a single taxon
:)

(:~ Renders a single taxon
:)
module namespace taxon-view="http://exist-db.org/xquery/taxon-view";

import module namespace werk-view="http://exist-db.org/xquery/werk-view" at "werk-view.xqm";
import module namespace functx="http://www.functx.com" at "functx.xqm";
import module namespace filesize="http://exist-db.org/xquery/filesize" at "filesize.xql";
import module namespace detail="http://exist-db.org/xquery/detail" at "detail.xql";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace so="http://standoff.proposal";
declare namespace xi="http://www.w3.org/2001/XInclude";
declare namespace util="http://exist-db.org/xquery/util";

declare function taxon-view:render($nodes as node()*) {
    for $node in $nodes
    return
        typeswitch ($node)
            case text() return
                $node
            case element(tei:TEI) return
                taxon-view:render($node/*)
            case element(tei:teiHeader) return
                taxon-view:render-header($node)             
            default return
                $node/string() 
};

declare function taxon-view:render-header($header as element(tei:teiHeader)) {

    let $titleStmt := $header/tei:fileDesc/tei:titleStmt
    let $notesStmt := $header/tei:fileDesc/tei:notesStmt    
    let $sourceDesc := $header/tei:fileDesc/tei:sourceDesc
    let $msDesc := $sourceDesc/tei:msDesc
    let $biblStruct := $header/tei:fileDesc/tei:sourceDesc/tei:biblStruct
    let $monogr := $header/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr
    let $analytic := $header/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic
    let $profileDesc := $header/tei:profileDesc
    let $space := '&#32;'
    return
        <div xmlns="http://www.w3.org/1999/xhtml" class="work-header">
            <div xmlns="http://www.w3.org/1999/xhtml" class="meta-table">
                <table class="table table-condensed table-bordered">
                    <thead>
                        <tr>
                            <th style="width: 20%">Meta Element</th>
                            <th>Value</th>
                        </tr>
                    </thead>
                {for $element in $header
                return
                  <tbody>
                        <tr>
                            <td class="col-md-2">
                            <span>ID: </span>
                            </td>
                            <td>
                            {$profileDesc/tei:textClass/tei:classCode[@scheme="taxon"]}
                            </td>
                        </tr>
                        <tr>
                            <td class="col-md-2">
                            <span>Class: </span>
                            </td>
                            <td>
                            {let $cat := $profileDesc/tei:textClass/tei:classCode[@scheme="cat"]
                             let $taxon-id := werk-view:get-taxon-id($cat/tei:idno/text())
                            return 
                                <span><a href="./work-list-cat.html?id={$taxon-id}">{$cat/tei:idno/text()}<span>:&#160;</span>{$cat/tei:rs}</a></span>
                             }   
                            </td>
                        </tr>
                        <tr>
                            <td class="col-md-2">
                            <span>Taxon Titel (Meta): </span>
                            </td>
                            <td>
                            {for $title in $titleStmt/tei:title
                            where $title[@type="taxon"]
                            return 
                                werk-view:convert-meta($title)
                            }                     
                            </td>
                        </tr>          
                           {if ($monogr/tei:title[@level="j"]) then                        
                             <tr>
                                 <td class="col-md-2">
                                 <span>Taxon Titel (Source): </span>
                                 </td>
                                 <td>                                
                                   <em>{werk-view:convert-meta($monogr/tei:title[@level="j"])}</em>
                                 </td>
                             </tr>
                           else  
                           ()
                            }
                           {if ($monogr/tei:title[@level="m"]) then 
                                if ($analytic/tei:title[@level="a"]) then
                                     <tr>
                                         <td class="col-md-2">
                                         <span>Titel: </span>
                                         </td>
                                         <td>                                
                                           {werk-view:convert-meta($monogr/tei:title[@level="m"])}
                                           {for $title in $monogr/tei:title
                                            where $title[@type="sub"]
                                            return werk-view:convert-meta($monogr/tei:title[@type="sub"])
                                            }
                                         </td>
                                     </tr>
                                  else ()   
                           else  
                           ()
                            }                             
                        {if ($monogr/tei:biblScope) then
                        <tr>
                            <td class="col-md-2">
                            <span>biblScope: </span>                            
                            </td>
                            <td>                                
                              {$monogr/tei:biblScope/text()}
                            </td>
                        </tr>
                        else
                        ()
                        }
                        {if ($biblStruct/tei:citedRange) then
                        <tr>
                            <td class="col-md-2">
                            <span>citedRange: </span>                            
                            </td>
                            <td>                                
                              {$biblStruct/tei:citedRange/text()}
                            </td>
                        </tr>
                        else
                        ()
                        }
                         {if ($monogr/tei:imprint/tei:publisher/tei:name/text()) then                        
                        <tr>
                            <td class="col-md-2">
                            <span>Erschienen: </span>
                            </td>
                            <td>
                            <span> {$monogr/tei:imprint/tei:pubPlace/text()}:</span>
                            <span>&#160;{$monogr/tei:imprint/tei:publisher/tei:name/text()},&#160;</span>                            
                            <span>{$monogr/tei:imprint/tei:date[@type="publication"]}</span>
                            </td>
                        </tr>
                        else
                        ()
                        }
                        {if ($msDesc/tei:msIdentifier/tei:repository/text()) then                        
                        <tr>
                            <td class="col-md-2">
                            <span>Besitzende Bibliothek:</span>
                            </td>
                            <td>                                
                              {$msDesc/tei:msIdentifier/tei:repository/text()}
                                 {if ($msDesc/tei:msIdentifier/tei:idno) then                         
                                  <span>:&#160;                           
                                      {let $idno := data($msDesc/tei:msIdentifier/tei:idno/@n)
                                      let $repo := $msDesc/tei:msIdentifier/tei:repository/text()
                                      let $link :=
                                            if ($repo eq 'SUB Göttingen') then
                                            let $a := detail:api-link($repo, $idno, 'grey', 'external-link')
                                            return $a
                                            else $idno
                                       return $link}                             
                                    </span>                        
                                else
                                ()
                                }                              
                            </td>
                        </tr>
                        else
                        ()
                        }                        
                        {for $note in $notesStmt
                        return
                            if ($note/tei:note) then                        
                            <tr>
                                <td class="col-md-2">
                                <span>Anmerkung:</span>
                                </td>
                                <td>                                
                                  <dt>Anm. {data($note/tei:note/@n)}</dt>
                                      <dl>{werk-view:convert-meta($note/tei:note)}</dl>
                                  
                                </td>
                            </tr>
                             else
                            ()
                        }                         
                    </tbody>                        
                    }
                </table>
        </div>
     </div>   
};                        

