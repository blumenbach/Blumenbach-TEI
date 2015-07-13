xquery version "3.0";

module namespace list-forms="http://exist-db.org/list-forms/";

import module namespace templates="http://exist-db.org/xquery/templates";
import module namespace query="http://exist-db.org/query/" at "query.xqm";
import module namespace config="http://exist-db.org/apps/blume/config" at "config.xqm";
import module namespace functx="http://www.functx.com" at "functx.xqm";
import module namespace detail="http://exist-db.org/xquery/detail" at "detail.xql";
import module namespace util = "http://exist-db.org/xquery/util";
import module namespace httpclient = "http://exist-db.org/xquery/httpclient";
import module namespace response = "http://exist-db.org/xquery/response";
import module namespace xmldb = "http://exist-db.org/xquery/xmldb";
    
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function list-forms:get-orbeon-metadata($form-path as xs:string?) {
    let $orbeon-search-uri := $config:orbeon-fr || '/service/persistence/search/'
    let $form-path := $orbeon-search-uri || $form-path
    let $query := <search>
                    <drafts>only</drafts>
                        <page-size>10</page-size>
                        <page-number>1</page-number>
                        <lang>en</lang>
                  </search>
    let $headers := <headers><header name="Content-Type" value="application/xml"/></headers>              
    let $documents := httpclient:post($form-path, $query, true(), $headers)
    return
        $documents
 };

declare 
    %templates:wrap 
    %templates:default("mode", "all")
function list-forms:taxons($node as node(), $model as map(*)) {
   let $collection := collection($config:orbeon-taxon-collection)
   for $form in ($collection//form)
   let $taxonid := $form/profileDesc-textClass/classCode-scheme.taxon      
   let $title := $form/titleStmt/title-type.taxon
   let $uuid := tokenize(util:collection-name($form),'/')[last()]
   let $file := '/jfb_taxon_' || $taxonid || '_' || $uuid || '.xml'
   let $docname := $config:orbeon-publish || $file
   let $transformed := 
                    if (util:document-name($docname)) then
                    true()
                    else
                    false()
   let $metadata := list-forms:get-orbeon-metadata('blumenbach/taxon')
   let $modified_date := substring-before(data($metadata/httpclient:body/documents/document[@name = $uuid]/@last-modified), 'T')
   let $modified_time := substring-before(substring-after(data($metadata/httpclient:body/documents/document[@name = $uuid]/@last-modified), 'T'),'.')
   let $modified := $modified_date || ' / ' || $modified_time
   let $edit_link := 
           if ($transformed = true()) then
               let $eXide-link := templates:link-to-app("http://exist-db.org/apps/eXide", "index.html?open=" || $docname)
               return
                    <a class="list-group-item" xmlns="http://www.w3.org/1999/xhtml" href="{$eXide-link}" target="_blank">edit</a>
               else
                   let $base := $config:orbeon-fr || 'blumenbach/taxon/edit/'
                   let $href := $base || $uuid 
                   return
                        <a class="list-group-item" xmlns="http://www.w3.org/1999/xhtml" href="{$href}">edit</a>
   let $transform_link := 
           let $base := './transform.xml'
           let $href := $base || '?id=' || $taxonid || '&amp;method=save' || '&amp;file_format=single' || '&amp;type=taxon' || '&amp;uuid=' || $uuid 
           let $link :=
              if ($transformed = false()) then
                <a class="list-group-item" xmlns="http://www.w3.org/1999/xhtml" href="{$href}">transform</a>
              else
                <span class="list-group-item disabled">transform</span>           
           return
                $link
   let $download_link := 
           let $download_name := 'jfb_taxon_' || $taxonid || '.xml'
           let $base := './transform.xml'
           let $href := $base || '?id=' || $taxonid || '&amp;method=download' || '&amp;file_format=single' || '&amp;type=taxon' || '&amp;uuid=' || $uuid 
           return
                <a class="list-group-item" download="{$download_name}" xmlns="http://www.w3.org/1999/xhtml" href="{$href}">download</a>
   let $reponse := response:set-header("Cache-Control", "no-cache")
   let $result := request:get-attribute("results")
   let $message :=     
        if ($result) then            
            <span class="green">The document is transformed</span>
        else
            ()      
   return   
            <tr>                            
                <td>
                    <span>{$taxonid}</span>
                </td> 
                <td>
                    <span>{$title}</span>
                </td>
                 <td>
                    <span>{$modified}</span>
                </td>
                <td>
                    <span>{$transformed}</span>
                    <span>{$message}</span>
                </td>                
                <td>
                    <div class="list-group">{$edit_link} {$transform_link}{$download_link}</div>
                </td>                             
            </tr>
};

declare 
    %templates:wrap 
    %templates:default("mode", "all")
function list-forms:briefe($node as node(), $model as map(*)) {
   let $collection := collection($config:orbeon-brief-collection)
   for $form in ($collection//form)
   let $briefid := $form/textClass/classCode-scheme.RegNr-idno      
   let $title := $form/titleStmt/title-type.meta
   let $uuid := tokenize(util:collection-name($form),'/')[last()]
   let $docname := $config:orbeon-publish || '/jfb_brief_' || $briefid || '_' || $uuid || '.xml'
   let $transformed := 
                    if (util:document-name($docname)) then
                    true()
                    else
                    false()
   let $metadata := list-forms:get-orbeon-metadata('blumenbach/brief')
   let $modified_date := substring-before(data($metadata/httpclient:body/documents/document[@name = $uuid]/@last-modified), 'T')
   let $modified_time := substring-before(substring-after(data($metadata/httpclient:body/documents/document[@name = $uuid]/@last-modified), 'T'),'.')
   let $modified := $modified_date || ' / ' || $modified_time                
   let $edit_link := 
           if ($transformed = true()) then
               let $eXide-link := templates:link-to-app("http://exist-db.org/apps/eXide", "index.html?open=" || $docname)
               return
                    <a class="list-group-item" xmlns="http://www.w3.org/1999/xhtml" href="{$eXide-link}" target="_blank">edit</a>
               else   
                   let $base := $config:orbeon-fr || 'blumenbach/brief/edit/'
                   let $href := $base || $uuid 
                   return
                        <a class="list-group-item" xmlns="http://www.w3.org/1999/xhtml" href="{$href}">edit</a>
   let $transform_link := 
           let $base := './transform.xml'
           let $href := $base || '?id=' || $briefid || '&amp;method=save' || '&amp;file_format=single' || '&amp;type=brief' || '&amp;uuid=' || $uuid 
           let $link :=
              if ($transformed = false()) then
               <a class="list-group-item" xmlns="http://www.w3.org/1999/xhtml" href="{$href}">transform</a>
              (:
                <a class="btn btn-default" id="openBtn" href="#modal-content" data-toggle="modal">transform</a>
              :)
              else
                <span class="list-group-item disabled">transform</span>           
           return
                $link
    let $modal := 
           let $base := './transform.xml'
           let $href := $base || '?id=' || $briefid || '&amp;method=save' || '&amp;file_format=single' || '&amp;type=brief' || '&amp;uuid=' || $uuid
           return
                <div id="modal-content" class="modal fade modal-xs" tabindex="-1" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">×</button>
                            <h4>Transform</h4>
                        </div>
                        <div class="modal-body">Transform Form XML to TEI
                        </div>
                        <div class="modal-footer"> 
                             <a href="{$href}" id="executeBtn" class="btn btn-primary">Execute</a>
                        </div>
                    </div>
                </div>
            </div>
    let $download_link := 
           let $download_name := 'jfb_brief_' || $briefid || '.xml' 
           let $base := './transform.xml'
           let $href := $base || '?id=' || $briefid || '&amp;method=download' || '&amp;file_format=single' || '&amp;type=brief' || '&amp;uuid=' || $uuid 
           return
                <a class="list-group-item" download="{$download_name}" xmlns="http://www.w3.org/1999/xhtml" href="{$href}">download</a>               
   return   
        <tr>
            <td>
                <span>{$briefid}</span>
            </td> 
            <td>
                <span>{$title}</span>
            </td>            
             <td>
                <span>{$modified}</span>
            </td>
             <td>
                <span>{$transformed}</span>
            </td>            
            <td>
                <div class="list-group">{$edit_link} {$transform_link}{$download_link}</div>
                
            </td>                             
        </tr>
};

declare 
    %templates:wrap 
    %templates:default("mode", "all")
function list-forms:werke($node as node(), $model as map(*)) {
   let $collection := collection($config:orbeon-werk-collection)
   for $form in ($collection//form)
   let $werkid := $form/profileDesc-textClass/classCode-scheme.BiblNr      
   let $title := $form/titleStmt/title-type.meta
   let $uuid := tokenize(util:collection-name($form),'/')[last()]
   let $docname := $config:orbeon-publish || '/jfb_werk_' || $werkid || '_' || $uuid || '.xml'
   let $transformed := 
                    if (util:document-name($docname)) then
                    true()
                    else
                    false()
   let $metadata := list-forms:get-orbeon-metadata('blumenbach/werk')
   let $modified_date := substring-before(data($metadata/httpclient:body/documents/document[@name = $uuid]/@last-modified), 'T')
   let $modified_time := substring-before(substring-after(data($metadata/httpclient:body/documents/document[@name = $uuid]/@last-modified), 'T'),'.')
   let $modified := $modified_date || ' / ' || $modified_time                   
   let $edit_link := 
           if ($transformed = true()) then
               let $eXide-link := templates:link-to-app("http://exist-db.org/apps/eXide", "index.html?open=" || $docname)
               return
                    <a class="list-group-item" xmlns="http://www.w3.org/1999/xhtml" href="{$eXide-link}" target="_blank">edit</a>
               else           
                    let $base := $config:orbeon-fr || 'blumenbach/werk/edit/'
                    let $href := $base || $uuid 
                    return
                         <a class="list-group-item" xmlns="http://www.w3.org/1999/xhtml" href="{$href}">edit</a>
   let $transform_link :=  
               let $base := './transform.xml'
               let $href := $base || '?id=' || $werkid || '&amp;method=save' || '&amp;file_format=single' || '&amp;type=werk' || '&amp;uuid=' || $uuid 
               let $link :=
                  if ($transformed = false()) then
                    <a class="list-group-item" xmlns="http://www.w3.org/1999/xhtml" href="{$href}">transform</a>
                  else
                    <span class="list-group-item disabled">transform</span>
               return
                    $link
   let $download_link := 
           let $download_name := 'jfb_werk_' || $werkid || '.xml'
           let $base := './transform.xml'
           let $href := $base || '?id=' || $werkid || '&amp;method=download' || '&amp;file_format=single' || '&amp;type=werk' || '&amp;uuid=' || $uuid 
           return
                <a class="list-group-item" download="{$download_name}" xmlns="http://www.w3.org/1999/xhtml" href="{$href}">download</a>                
   return   
        <tr> 
            <td>
                <span>{$werkid}</span>
            </td> 
            <td>
                <span>{$title}</span>
            </td>
             <td>
                <span>{$modified}</span>
            </td>
            <td>
                <span>{$transformed}</span>
            </td>            
            <td>
                <div class="list-group">{$edit_link} {$transform_link}{$download_link}</div>
            </td>                             
        </tr>
};

declare 
    %templates:wrap 
    %templates:default("mode", "all")
function list-forms:staged-tei($node as node(), $model as map(*)) {
   let $reponse := response:set-header("Cache-Control", "no-cache")
   let $collection := collection($config:orbeon-publish)
   for $work in ($collection//tei:TEI)
       let $textclass := $work/tei:teiHeader/tei:profileDesc/tei:textClass
       let $resource := util:document-name($work)
       let $target := 
            if ($textclass/tei:classCode[@scheme="BiblNr"]) then
                $config:werke-collection                 
            else if ($textclass/tei:classCode[@scheme='RegNr']/tei:idno) then
                $config:brief-collection 
            else
            ()
       let $target_resource :=
            if ($textclass/tei:classCode[@scheme="BiblNr"]) then
                $config:werke-collection || '/' || $resource                
            else if ($textclass/tei:classCode[@scheme='RegNr']/tei:idno) then
                $config:brief-collection || '/' || $resource
            else
            ()       
       let $docname := 
            if ($textclass/tei:classCode[@scheme="BiblNr"]) then
                $config:werke-collection || '/' || $work/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno
            else if ($textclass/tei:classCode[@scheme='RegNr']/tei:idno) then
                $config:brief-collection || '/' || $work/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno
            else
            ()
       let $docpath := substring-after($docname, '/db/apps/blumenbach/data/')     
       let $published := 
                if ($docname) then
                    if (util:document-name($docname)) then
                        true()
                    else if (util:document-name($target_resource)) then
                        true()
                    else
                        false()
                 else
                 ()
        let $icon := 
            if ($textclass/tei:classCode[@scheme="BiblNr"] and not($textclass/tei:classCode[@scheme="taxon"])) then
                    "workicon"
            else if ($textclass/tei:classCode[@scheme='RegNr']/tei:idno) then
                    "brieficon"
            else if ($textclass/tei:classCode[@scheme='taxon']) then
                    "taxonicon"                    
            else ()  
        
        let $id := 
            if ($textclass/tei:classCode[@scheme="BiblNr"] and not($textclass/tei:classCode[@scheme="taxon"])) then
                     $textclass/tei:classCode[@scheme="BiblNr"]/string()
            else if ($textclass/tei:classCode[@scheme='RegNr']/tei:idno) then
                    $textclass/tei:classCode[@scheme='RegNr']/tei:idno
            else if ($textclass/tei:classCode[@scheme='taxon']) then
                    $textclass/tei:classCode[@scheme='taxon']                    
            else ()
        let $staged := 
            if ($published = false()) then
                "&amp;status=staged"
            else
                ()    
        let $titel :=
            if ($textclass/tei:classCode[@scheme="BiblNr"] and not($textclass/tei:classCode[@scheme="taxon"])) then
                let $title := $work/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="meta"]/text()
                let $id := $textclass/tei:classCode[@scheme="BiblNr"]/string()
                let $link := './view-work.html'
                let $href := $link || "?id=" || $id || $staged
                return
                    <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$title}</a>
            else if ($textclass/tei:classCode[@scheme='RegNr']/tei:idno) then
                 let $title := $work/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="meta"]/text()
                 let $id := $work/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/tei:idno
                 let $link := './view-brief.html'
                 let $href := $link || "?id=" || $id || $staged
                 return
                     <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$title}</a>
            else if ($textclass/tei:classCode[@scheme='taxon']) then
                 let $title := $work/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="taxon"]/text()
                 let $id := $textclass/tei:classCode[@scheme='taxon']
                 let $link := './view-taxon.html'
                 let $href := $link || "?id=" || $id || $staged
                 return
                     <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$title}</a>                     
             else ()    
         let $dsort := substring-after($work/tei:teiHeader/tei:revisionDesc/tei:change, 'Erstellungsdatum: ')
         let $date := substring-before(substring-after($work/tei:teiHeader/tei:revisionDesc/tei:change, 'Erstellungsdatum: '), 'T')
         let $publish_link :=  
               let $base := './publish.xml'
               let $href := $base || '?source=' || $config:orbeon-publish || '&amp;target=' || $target || '&amp;resource=' || $resource || '&amp;method=copy' 
               let $link :=
                  if ($published = false()) then
                    <a class="list-group-item" xmlns="http://www.w3.org/1999/xhtml" href="{$href}">Publish</a>
                  else
                    <span class="list-group-item disabled">Publish</span>
               return
                    $link
   order by $id ascending
   return   
                        <tr>
                            <td>
                             <dl class="dl-horizontal">
                                <dt id="{$icon}"></dt>
                                <dd>{$id}</dd>
                             </dl>                            
                            </td>                 
                            <td>
                                <span>{$titel}</span>
                            </td>
                            <td>
                                <span>{$dsort}</span>
                            </td>                              
                            <td>
                                <span>{$date}</span>
                            </td>
                             <td>
                                <span>{$published}</span>
                             </td>                           
                            <td>
                                <span>{$docpath}</span>
                             </td>                             
                            <td>
                                <div class="list-group">{$publish_link}</div>
                             </td> 
                        </tr>
};