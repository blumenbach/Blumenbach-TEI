xquery version "3.0";

module namespace werk-view="http://exist-db.org/werk-view/";
import module namespace functx="http://www.functx.com" at "functx.xqm";
import module namespace filesize="filesize" at "filesize.xql";
import module namespace detail="http://exist-db.org/xquery/detail" at "detail.xql";
import module namespace config="http://exist-db.org/apps/blume/config" at "config.xqm";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace so="http://standoff.proposal";
declare namespace xi="http://www.w3.org/2001/XInclude";
declare namespace util="http://exist-db.org/xquery/util";


declare function werk-view:render($nodes as node()*) {
    for $node in $nodes
    return
        typeswitch ($node)
            case text() return
                $node
            case element(tei:TEI) return
                werk-view:render($node/*)
            case element(tei:teiHeader) return
                werk-view:render-header($node)
            case element(so:stdf) return
                werk-view:render-annotations-text($node)                
            default return
                $node/string()                
};

declare function werk-view:render-header($header as element(tei:teiHeader)) {

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
                            {$profileDesc/tei:textClass/tei:classCode[@scheme="BiblNr"]}
                            </td>
                        </tr>
                        <tr>
                            <td class="col-md-2">
                            <span>Class: </span>
                            </td>
                            <td>
                            {let $cats := $profileDesc/tei:textClass/tei:classCode[@scheme="cat"]
                            let $numcats := count($cats)
                            for $cat at $i in $cats                            
                            return 
                            if ($cat) then
                                let $taxon-id := werk-view:get-taxon-id($cat/tei:idno/text())
                                return
                                    if ($i = $numcats) then 
                                        <span><a href="./work-list-cat.html?id={$taxon-id}">{$cat/tei:idno/text()}<span>:&#160;</span>{$cat/text()}</a>&#160;</span> 
                                    else
                                        <span><a href="./work-list-cat.html?id={$taxon-id}">{$cat/tei:idno/text()}<span>:&#160;</span>{$cat/text()}</a>&#160;&#11177;&#160;</span>
                            else ()           
                             }   
                            </td>
                        </tr>
                        <tr>
                            <td class="col-md-2">
                            <span>Titel: </span>
                            </td>
                            <td>
                            {for $title in $monogr/tei:title
                            where $title[@type="aut"]
                            return 
                                werk-view:convert-meta($title)
                            }    
                            {for $title in $monogr/tei:title
                            where $title[@type="main"]
                            return 
                                werk-view:convert-meta($title)
                            }                                
                            {for $title in $monogr/tei:title
                            where $title[@type="sub"]
                            return if (not($analytic/tei:title/text())) then
                                 werk-view:convert-meta($title)
                                 else
                                 ()
                            }
                            {for $title in $monogr/tei:title
                            where $title[@type="ed"]
                            return 
                                werk-view:convert-meta($title)
                            }
                            {for $struct in $biblStruct
                            where $struct/tei:analytic/tei:title[@type="main"]
                            return
                            werk-view:convert-meta($struct/tei:analytic/tei:title[@type="main"])
                            }                            
                            </td>
                        </tr>          
                           {if ($monogr/tei:title[@level="j"]) then                        
                             <tr>
                                 <td class="col-md-2">
                                 <span>In: </span>
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
                                         <span>In: </span>
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
                        {if ($sourceDesc/tei:biblStruct/tei:monogr/tei:edition) then                        
                        <tr>
                            <td class="col-md-2">
                            <span>Edition </span>
                            </td>
                            <td>                                
                              {$sourceDesc/tei:biblStruct/tei:monogr/tei:edition/text()}
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
                        {if ($msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:extent/text()) then                         
                        <tr>
                            <td class="col-md-2">
                            <span>Umfang:</span>
                            </td>
                            <td>                                
                              {$msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:extent/text()}
                                {if ($msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:extent/tei:dimensions/tei:dim/text()) then                         
                                    <span>&#160;&#x3b;&#160;{$msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:extent/tei:dimensions/tei:dim/text()}</span>
                                else
                                ()
                                }
                            </td>
                        </tr>                        
                        else
                        ()
                        } 
                        {if ($sourceDesc/tei:biblStruct/tei:series) then                        
                        <tr>
                            <td class="col-md-2">
                            <span>Series: </span>
                            </td>
                            <td>                                
                              {$sourceDesc/tei:biblStruct/tei:series/text()}
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
                                      {let $idno := $msDesc/tei:msIdentifier/tei:idno/text()
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
                        {if ($msDesc/tei:additional/tei:adminInfo/tei:recordHist/tei:source/tei:certainty/tei:desc/text()) then                        
                        <tr>
                            <td class="col-md-2">
                            <span>Certainty:</span>
                            </td>
                            <td>                                
                            <span>Nicht Autopsierte</span>
                            </td>
                        </tr>
                         else
                        ()
                        }
                        {for $note in $notesStmt
                        return
                        if ($note/tei:note[@type='anm']) then                        
                        <tr>
                            <td class="col-md-2">
                            <span>Notes:</span>
                            </td>
                            <td>                                
                              <ul>
                                  <li>{$note/tei:note[@type='anm'][1]/text()}</li>
                                  <li>{$note/tei:note[@type='anm'][2]/text()}</li>
                                  <li>{$note/tei:note[@type='anm'][3]/text()}</li>
                                  <li>{$note/tei:note[@type='anm'][4]/text()}</li>
                                  <li>{$note/tei:note[@type='anm'][5]/text()}</li>
                                  <li>{$note/tei:note[@type='anm'][6]/text()}</li>
                                  <li>{$note/tei:note[@type='anm'][7]/text()}</li>
                              </ul>
                            </td>
                        </tr>
                         else
                        ()
                        }
                    </tbody>                        
             }
                </table>
        </div>
        {if ($notesStmt) then werk-view:render-refs($notesStmt)
        else
        ()}
        <div xmlns="http://www.w3.org/1999/xhtml" class="work-body">    
        </div>
  </div>      
};

declare function werk-view:render-refs($notesStmt as element(tei:notesStmt)) {
     <div xmlns="http://www.w3.org/1999/xhtml" class="meta-table">
        <table class="table table-condensed table-bordered">
            <thead>
                <tr>
                    <th>Elektronische Versionen:</th>
                </tr>
            </thead>
            <tbody>
            <tr>
            <td>
             <table class="table table-condensed table-bordered">
                 <tbody>
             {for $note in $notesStmt                        
                 return
                 if ($note/tei:note[@type='ref']) then 
                    let $refs := $note/tei:note[@type='ref']
                    for $ref at $i in $refs
                         return
                             if ($ref/tei:ref[@type='html']) then
                                 <tr>
                                     <td class="col-md-1">
                                     <span>Volltext:</span>
                                     </td>
                                     <td>
                                     <dl class="dl-horizontal">
                                           <dt id="pageicon"></dt>
                                           <dd><a href="{escape-uri($ref/tei:ref[@type='html'], false())}" target="_blank">{tokenize($ref/tei:ref[@type='html'], "/")[last()]}</a>
                                             </dd> 
                                       </dl>                                   
                                     </td>
                                 </tr>
                             else
                                 <tr>
                                     <td class="col-md-1">
                                     <span>PDF:</span>
                                     </td>
                                     <td>
                                         <dl class="dl-horizontal">
                                         <dt id="pdficon"></dt>
                                               <dd><a href="{escape-uri($ref/tei:ref[@type='pdf'], false())}" target="_blank">{tokenize($ref/tei:ref[@type='pdf'], "/")[last()]}</a> [{filesize:get-size($ref/tei:ref[@type='pdf'])}]</dd>
                                         </dl>                                   
                                     </td>
                                 </tr>
                else
                ()
                }
                </tbody>
                </table>
                </td>
                </tr>
                </tbody>
       </table>       
       </div>
};
declare function werk-view:render-annotations-text($notes as element(so:stdf)) {
let $annotations := $notes/so:annotations
return
    if ($annotations/tei:spanGrp/tei:span) then
    <div xmlns="http://www.w3.org/1999/xhtml" class="meta-table">
        <table class="table table-condensed table-bordered">
            <thead>
                <tr>
                    <th>Anmerkung:</th>
                </tr>
            </thead>
            <tbody>
            <tr>
                <td class="col-md-2">
                    <table class="table table-condensed table-bordered">
                        <thead>
                            <tr>
                                <th>Statement</th>
                                <th>Text</th>                            
                            </tr>
                        </thead>
                        <tbody>                    
                    {for $spanGrp at $i in $annotations/tei:spanGrp                    
                        return
                        <tr>
                         <td>{$i}</td> 
                         <td>                        
                            {for $span in $spanGrp/tei:span
                            return werk-view:convert-notes($span)}
                         </td>
                         </tr>
                    }
                        </tbody>        
                    </table> 
                </td>
                </tr>
           </tbody>
           </table>
        </div>
    else
    ()
};


declare function werk-view:convert-meta($node as node()*) {
    typeswitch ($node)
        case text() return $node
        case element(tei:emph) 
            return
            <em>{$node}</em>        
        case element(tei:gap) 
            return
            <span>&#160;&#8230;&#160;</span>
        case element(tei:pc)
            return
            let $pc := 
                if ($node/@unit='comma') then
                <span type="meta">,&#160;</span>
                else if ($node/@unit='semicolon') then
                <span type="meta">&#160;&#x3b;&#160;</span>
                else if ($node/@unit='slash') then
                <span type="meta">&#160;&#x2215;&#160;</span>
                else if ($node/@unit='bind') then
                <span type="meta">&#160;–&#160;</span>
                else if ($node/@unit='point') then
                <span type="meta">.&#160;</span>
                else if ($node/@unit='colon') then
                <span type="meta">:&#160;</span>
                else ()
                return $pc
        default return werk-view:passthru-meta($node)    
 };
 
 declare function werk-view:passthru-meta($nodes as node()*) as item()* {
    for $node in $nodes/node() return werk-view:convert-meta($node)
};
 
 declare function werk-view:convert-notes ($node as node()*) {
    typeswitch ($node)
        case text() return $node
        case element(tei:span)
            return
            let $span :=
                if ($node[@style='j']) then
                <em>&#160;{werk-view:convert-meta($node)}&#160;</em>
                else if ($node[@type='title']) then
                <span>{werk-view:convert-meta($node)}&#160;</span>
                else if ($node[@type='note']) then
                    for $n in $node
                    return 
                        werk-view:convert-meta($n)
                else if ($node[@type='note']/child::tei:lb) then
                    let $br := '&#160;' || werk-view:convert-meta($node)
                    return <span>{$br}<br/></span>
                else if ($node[@type='persName']) then
                    werk-view:convert-meta($node)
                else if ($node[@type='author']) then
                     let $author := werk-view:convert-meta($node)
                     return <span>&#160;{$author}</span>
                else if ($node[@type='extent']) then
                    '–&#160;' || $node || '&#160;'
                else if ($node[@type='edition']) then
                    '.–&#160;' || $node   
                else if ($node[@type='pubPlace']) then
                    '.–&#160;' || $node || ':&#160;'
                else if ($node[@type='publisher']) then
                    $node     
                else if ($node[@type='date']) then
                    ',&#160;' || $node || '&#160;'
                else if ($node[@type='biblScope']) then
                    $node || ',&#160;'                   
                else if ($node[@type='citedRange']) then
                    $node || '&#160;'
                else if ($node[@type='img']) then
                    <span>&#160;<img style="width: 16px; height: 16px;" src="/apps/blumenbach/resources/images/work.png"/>&#160;</span>                     
                else if ($node[@type='reference']) then
                     let $link := './view-work.html'
                     let $ref := $node[@type="reference"]
                     let $href := concat($link, '?id=', $ref)
                     return
                     detail:render-token($href, $ref, 'blue', 'book')
                else if ($node[@type='idno']) then
                    for $repopos in $node/preceding-sibling::tei:span[@type='repository'][position()=1]
                     return                    
                         let $repo := functx:trim($repopos/text())
                         let $idno := $node[@type='idno']
                         let $link :=
                            if ($repo eq 'SUB Göttingen') then
                                 let $a := detail:api-link($repo, $idno, 'green', 'external-link')
                                 return $a
                             else $node    
                         return
                         $link                     
                else $node ||'&#160;'
            return $span
        default return werk-view:passthru-note($node)
};  

declare function werk-view:get-taxon-id($cat as xs:string?) {
   let $collection := collection($config:cat-config)
   for $taxon in $collection//tei:classCode
   let $taxon-name := $taxon/tei:idno/text()
   let $taxon-id := substring-before(data($taxon/tei:idno/@n), '.00')
   where $taxon-name = $cat
   return
        $taxon-id 
};

 declare function werk-view:passthru-note($nodes as node()*) as item()* {
    for $node in $nodes/node() return werk-view:convert-notes($node)
};