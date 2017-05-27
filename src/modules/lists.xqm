xquery version "3.0";

(:
: Module Name: lists
: Module Version: 
: Date: 
: License: GNU-LGPL
: 
: Module Overview: Functions that return data as rows for tables
:)

(:~
 : Functions that return data as rows for tables
 : 
 :)
 
module namespace list="http://exist-db.org/xquery/lists";

import module namespace templates="http://exist-db.org/xquery/templates";
import module namespace query="http://exist-db.org/xquery/query" at "query.xqm";
import module namespace config="http://exist-db.org/xquery/apps/blume/config" at "config.xqm";
import module namespace detail="http://exist-db.org/xquery/detail" at "detail.xql";
import module namespace functx="http://www.functx.com" at "functx.xqm";
import module namespace werk-view="http://exist-db.org/xquery/werk-view" at "werk-view.xqm";
    
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare 
    %templates:wrap 
    %templates:default("mode", "all")
function list:briefs-grouped($node as node(), $model as map(*), $query as xs:string?, $jhr as xs:string?, $mode as xs:string) {
   let $collection := collection($config:brief-collection)/tei:TEI
   let $queryExpr := 
       if ($query= '')
       then query:create-query('.', 'regex') 
       else
       query:create-query($query, $mode)
   for $brief in ($collection/tei:teiHeader[ft:query(., $queryExpr)])
   let $asort := if ($brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/tei:surname) then
       $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/tei:surname
       else
       $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/text()
   let $author := if ($brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/tei:surname) then
        $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/*
        else
        $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/text()
   let $esort := 
        if ($brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/tei:surname) then
        $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/tei:surname
        else
        $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/text()        
   let $empfanger :=  
        if ($brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/tei:surname) then
        $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/*
        else
        $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/text()
   let $idlink := 
        let $id := $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/tei:idno
        let $link := './view-brief.html'
        let $href := $link || "?id=" || $id
        return
            <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$id}</a>
   let $place := $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:placeName
 (:~  let $titel :=     
        let $title := $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="meta"]/text()
        let $link := './view-brief.html'
        let $href := $link || "?id=" || $id
        return
            <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$title}</a>
 :)            
   let $dsort := for $date in $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:origDate/tei:note/tei:listEvent/tei:event[@sortKey][1]
                return data($date/@sortKey)
   let $date := $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:origDate/tei:note/tei:listEvent/tei:event[@type="origin"]/tei:note/tei:date
   let $year := substring-before($dsort, '-')
   let $where := 
        if ($jhr = '')
        then
        number($year) > 0
        else if (contains($jhr, '-'))
        then
            let $from := substring-before($jhr, '-')
            let $to := 
                if (substring-after($jhr, '-') = '')
                then '2015'
                else substring-after($jhr, '-')
            return number($year) >= number($from) and number($year) <= number($to) 
         else 
         number($year) = number($jhr)
   where $where         
   order by $dsort ascending
   return   
                        <tr>
                            <td>
                                <span>{$idlink}</span>
                            </td> 
                            <td>
                                <span>{$dsort}</span>
                            </td>                            
                            <td>
                                <span>{$date}</span>
                            </td>                            
                            <td>
                                <span>{$asort}</span>
                            </td>                            
                            <td>
                                <span>{$author}</span>
                            </td>
                            <td>
                                <span>{$esort}</span>
                            </td> 
                            <td>
                                <span>{$empfanger}</span>
                            </td>                            
                            <td>
                                <span>{$place}</span>
                            </td>
                        </tr>
};

declare 
    %templates:wrap 
    %templates:default("mode", "all")
function list:briefs-all($node as node(), $model as map(*)) {
   let $collection := collection($config:brief-collection)/tei:TEI
   for $brief in ($collection/tei:teiHeader)
   let $titleStmt := $brief/tei:fileDesc/tei:titleStmt
   let $creation := $brief/tei:profileDesc/tei:creation
   let $asort := if ($titleStmt/tei:author/tei:persName/tei:surname) then
       $titleStmt/tei:author/tei:persName/tei:surname
       else
       $titleStmt/tei:author/tei:persName/text()
   let $author := if ($titleStmt/tei:author/tei:persName/tei:surname) then
        $titleStmt/tei:author/tei:persName/*
        else
        $titleStmt/tei:author/tei:persName/text()
   let $esort := 
        if ($creation/tei:persName[@resp="emp"]/tei:surname) then
         $creation/tei:persName[@resp="emp"]/tei:surname
        else
         $creation/tei:persName[@resp="emp"]/text()        
   let $empfanger :=  
        if ($creation/tei:persName[@resp="emp"]/tei:surname) then
         $creation/tei:persName[@resp="emp"]/*
        else
         $creation/tei:persName[@resp="emp"]/text() 
   let $idlink := 
        let $id := $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/tei:idno
        let $link := './view-brief.html'
        let $href := $link || "?id=" || $id
        return
            <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$id}</a>
   let $place := $brief/tei:profileDesc/tei:creation/tei:placeName
 (:~ 
let $titel :=     
        let $title := $titleStmt/tei:title[@type="meta"]/text()
        let $link := './view-brief.html'
        let $href := $link || "?id=" || $id
        return
            <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$title}</a>
    :) 
   let $dsort := for $ds in $creation/tei:origDate/tei:note/tei:listEvent/tei:event[@type="origin"]
                return data($ds/@sortKey)
   let $date := $creation/tei:origDate/tei:note/tei:listEvent/tei:event[@type="origin"]/tei:note/tei:date

   order by $dsort ascending
   return   
                        <tr>
                            <td>
                                <span>{$idlink}</span>
                            </td> 
                            <td>
                                <span>{$dsort}</span>
                            </td>                            
                            <td>
                                <span>{$date}</span>
                            </td>                            
                            <td>
                                <span>{$asort}</span>
                            </td>                            
                            <td>
                                <span>{$author}</span>
                            </td>
                            <td>
                                <span>{$esort}</span>
                            </td> 
                            <td>
                                <span>{$empfanger}</span>
                            </td>                            
                            <td>
                                <span>{$place}</span>
                            </td>
                        </tr>
};

declare 
    %templates:wrap 
function list:works-cat($node as node(), $model as map(*), $id as xs:string?) {
   let $taxon-name := list:get-taxon-name($id)
   let $collection := collection($config:werke-collection)/tei:TEI
   for $work in $collection/tei:teiHeader
   let $biblnr := $work/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme="BiblNr"]/string()

   let $titel :=     
        let $title := $work/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="meta"]/text()
        let $bibnr := $work/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme="BiblNr"]/string()
        let $link := './view-work.html'
        let $href := $link || "?id=" || $biblnr
        return
            <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$title}</a>
   let $date := $work/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date[@type="publication"]
   let $dsort := data($work/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date/@when)
   where $work/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme="cat"]/tei:idno = $taxon-name and exists($biblnr) 
   order by $biblnr ascending
   return   
                        <tr>
                            <td>
                                <span>{$biblnr}</span>
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
                        </tr>
};

declare
   %templates:wrap
function list:works-cat-title($node as node(), $model as map(*), $id as xs:string?) {
   let $collection := collection($config:cat-config)
   for $taxon in $collection//tei:classCode
   let $desc := $taxon/tei:rs
   let $taxon-name := $taxon/tei:idno/text()
   let $idno := substring-before(data($taxon/tei:idno/@n), '.00')
   where $idno = $id
   return
         <h3>{$taxon-name} - <span><a href="./view-taxon.html?id={$id}">{$desc}</a></span></h3>
};

declare
   %templates:wrap
function list:get-taxon-name($id as xs:string?) {
   let $collection := collection($config:cat-config)
   for $taxon in $collection//tei:classCode
   let $taxon-name := $taxon/tei:idno/text()
   let $idno := substring-before(data($taxon/tei:idno/@n), '.00')
   where $idno = $id
   return
         $taxon-name
};

declare
   %templates:wrap
function list:works-cats($node as node(), $model as map(*), $cat as xs:string?) {
   for $cat in collection($config:cat-config)//tei:classCode
   let $desc := $cat/tei:rs  
   let $id := substring-before(data($cat/tei:idno/@n), '.')
   return
        <tr>
            <td>
                <span>{$id}</span>
            </td>                         
            <td>
                <span><a href="./work-list-cat.html?id={$id}">{$desc}</a></span>
            </td>                        
        </tr>
}; 

declare
   %templates:wrap
function list:cat-item($node as node(), $model as map(*)) {
   let $categories := collection($config:cat-config)
   let $output := 
            for $cat in $categories/categories/classCode
               let $desc := $cat/tei:rs  
               let $id := data($cat/@n)
               let $key := data($cat/@key)              
               return
                <li><a href="./work-list-cat.html?cat={$id}" target="_self">{$desc}</a></li>            
  return $output
}; 

declare 
    %templates:wrap 
function list:cat-tree($node as node(), $model as map(*)) {
    let $output :=
        <ul>
        {list:cat-item($node, $model)}
        </ul>
    return $output              
}; 

declare function list:cat-nodes ($categories as node()*) {
    typeswitch ($categories)
        case element(child) 
            return
            let $desc := $categories/text()  
            let $id := data($categories/@n)
            return
            <li id="{$id}" class="folder"><a href="./work-list-cat.html?cat={$id}" target="_self">{$desc}</a></li>
        case element(classCode) 
            return
            let $desc := $categories/text()  
            let $id := data($categories/@n)
            return
            <ul>
            <li id="{$id}" class="folder"><a href="./work-list-cat.html?cat={$id}" target="_self">{$desc}</a></li>
            {list:passthru-cats($categories)}            
            </ul>
        default return list:passthru-cats($categories)    
 };
 
 declare function list:passthru-cats($categories as node()*) as item()* {
    for $category in $categories/node() return list:cat-nodes($category)
};

declare 
    %templates:wrap 
    %templates:default("mode", "all")
function list:all-grouped($node as node(), $model as map(*), $query as xs:string?, $jhr as xs:string?, $mode as xs:string) {
   let $collection := collection($config:data)
   let $queryExpr := 
       if ($query= '')
       then query:create-query('.', 'regex') 
       else
       query:create-query($query, $mode)
   for $work in ($collection//tei:TEI[ft:query(., $queryExpr)])
        let $textclass := $work/tei:teiHeader/tei:profileDesc/tei:textClass
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
        let $titel :=
            if ($textclass/tei:classCode[@scheme="BiblNr"] and not($textclass/tei:classCode[@scheme="taxon"])) then
                let $title := $work/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="meta"]/text()
                let $id := $textclass/tei:classCode[@scheme="BiblNr"]/string()
                let $link := './view-work.html'
                let $href := $link || "?id=" || $id
                return
                    <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$title}</a>
            else if ($textclass/tei:classCode[@scheme='RegNr']/tei:idno) then
                 let $title := $work/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="meta"]/text()
                 let $id := $work/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/tei:idno
                 let $link := './view-brief.html'
                 let $href := $link || "?id=" || $id
                 return
                     <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$title}</a>
            else if ($textclass/tei:classCode[@scheme='taxon']) then
                 let $title := $work/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="taxon"]/text()
                 let $id := $textclass/tei:classCode[@scheme='taxon']
                 let $link := './view-taxon.html'
                 let $href := $link || "?id=" || $id
                 return
                     <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$title}</a>                     
             else ()    
         let $dsort := 
            if ($work/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date[@type="publication"]) then
                 for $date in $work/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date[@type="publication"]
                              return data($date/@when)
            else if ($work/tei:teiHeader/tei:profileDesc/tei:creation/tei:origDate/tei:note/tei:listEvent/tei:event) then
                 for $date in $work/tei:teiHeader/tei:profileDesc/tei:creation/tei:origDate/tei:note/tei:listEvent/tei:event
                         return data($date/@sortKey) 
            else ()            
         let $date := 
            if ($work/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date[@type="publication"]) then
                $work/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date[@type="publication"]
            else if ($work/tei:teiHeader/tei:profileDesc/tei:creation/tei:origDate/tei:note/tei:listEvent/tei:event[@type="origin"]/tei:note/tei:date) then
                $work/tei:teiHeader/tei:profileDesc/tei:creation/tei:origDate/tei:note/tei:listEvent/tei:event[@type="origin"]/tei:note/tei:date
         else ()
        let $year := substring-before($dsort[1], '-') 
        let $where := 
            if ($jhr = '')
            then
            number($year) > 0
            else if (contains($jhr, '-'))
            then
                let $from := substring-before($jhr, '-')
                let $to := 
                    if (substring-after($jhr, '-') = '')
                    then '2015'
                    else substring-after($jhr, '-')
                return number($year) >= number($from) and number($year) <= number($to) 
             else 
             number($year) = number($jhr)
   where $where 
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
                        </tr>
};

declare 
    %templates:wrap 
    %templates:default("mode", "all")
function list:works-grouped($node as node(), $model as map(*), $query as xs:string?, $jhr as xs:string?, $mode as xs:string) {
   let $collection := collection($config:werke-collection)
   let $queryExpr := 
       if ($query= '')
       then query:create-query('.', 'regex') 
       else
       query:create-query($query, $mode)
   for $work in ($collection//tei:TEI[ft:query(., $queryExpr)])
   let $id := $work/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme="BiblNr"]/string()
   let $titel :=     
        let $title := 
            if ($id) then 
            $work/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="meta"]/text()
            else
            $work/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="taxon"]/text()
        let $uid := 
            if ($id) then 
            $work/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme="BiblNr"]/string()
            else 
            $work/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme="taxon"]/string()
        let $link := 
            if ($id) then 
                './view-work.html'
                else
                './view-taxon.html'
        let $href := $link || "?id=" || $uid
        return
            <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$title}</a>
   let $dsort := for $date in $work/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date[@type="publication"]
                return data($date/@when)
   let $year := substring-before($dsort[1], '-')
   let $date := $work/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date[@type="publication"]
    let $where := 
    if ($jhr = '')
    then
    number($year) > 0
    else if (contains($jhr, '-'))
    then
        let $from := substring-before($jhr, '-')
        let $to := 
            if (substring-after($jhr, '-') = '')
            then '2015'
            else substring-after($jhr, '-')
        return number($year) >= number($from) and number($year) <= number($to) 
     else 
     number($year) = number($jhr)
   where $where 
   order by $id ascending
   return   
                        <tr>
                            <td>
                                <span>{$id}</span>
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
                        </tr>
};

declare 
    %templates:wrap 
    %templates:default("mode", "any")
function list:works-all($node as node(), $model as map(*)) {
   let $collection := collection($config:werke-collection)/tei:TEI
   for $work in ($collection//tei:teiHeader)
   where exists($work/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme="BiblNr"]/string())
        return
            if ($work/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="meta"]/text()) then
                 let $id := $work/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme="BiblNr"]/string()
                 let $titel :=     
                      let $title := $work/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="meta"]/text()
                      let $id := $work/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme="BiblNr"]
                      let $link := './view-work.html'
                      let $href := $link || "?id=" || $id
                      return
                          <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$title}</a>
                 let $dsort := for $date in $work/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date[@type="publication"]
                              return data($date/@when)
                 let $date := $work/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date[@type="publication"]
                 order by $id ascending
                 return   
                                      <tr>
                                          <td>
                                              <span>{$id}</span>
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
                                      </tr>
             else ()                         
};

declare 
    %templates:wrap 
    %templates:default("mode", "any")
function list:taxons-all($node as node(), $model as map(*)) {
   let $collection := collection($config:werke-collection)/tei:TEI
   for $work in ($collection//tei:teiHeader)
   where exists($work/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme="taxon"]/string())
        return
            if ($work/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="taxon"]/text()) then
                 let $id := $work/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme="taxon"]/string()
                 let $titel :=     
                      let $title := $work/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="taxon"]/text()
                      let $link := './view-taxon.html'
                      let $href := $link || "?id=" || $id
                      return
                          <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$title}</a>
                 let $dsort := for $date in $work/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date[@type="publication"]
                              return data($date/@when)
                 let $date := $work/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date[@type="publication"]
                 order by $id ascending
                 return   
                                      <tr>
                                          <td>
                                              <span>{$id}</span>
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
                                      </tr>
             else ()                         
};

declare 
    %templates:wrap 
    %templates:default("mode", "any")
function list:persons-all($node as node(), $model as map(*)) {
   let $collection := collection($config:brief-collection)/tei:TEI
   let $persons := $collection//tei:persName
   for $pers in $persons
   let $surname := 
            if (exists($pers/tei:surname))
            then $pers/tei:surname
            else
            ()
   let $field := distinct-values($pers/tei:surname)
   let $forename := $pers/tei:forename
   let $link := detail:search-link($node, $model, $field)    
   group by $surname, $forename
   order by $surname ascending
   return   
                        <tr>
                            <td>
                                <span>{$forename}</span>
                            </td>
                            <td>
                                <span>{$surname}</span>
                            </td> 
                            <td>
                                <span>{$link}</span>
                            </td>                             
                        </tr>
};

declare 
    %templates:wrap 
    %templates:default("mode", "any")
function list:places-all($node as node(), $model as map(*)) {
   let $collection := collection($config:brief-collection)/tei:TEI
   let $places := $collection//tei:placeName
   for $place in $places 
   let $plc := $place/ancestor-or-self::tei:placeName
   let $id := 
            $place/ancestor::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/tei:idno
   let $field := distinct-values($place/ancestor-or-self::tei:placeName)
   let $link := 
           let $base := './view-brief.html'
           let $href := $base || "?id=" || $id[1] 
           return
                <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$field}</a> 
   group by $plc
   order by $plc ascending
   return   
                        <tr>
                            <td>
                                <span>{$plc}</span>
                            </td>
                            <td>
                                <span>{$link}</span>
                            </td>                             
                        </tr>
};

declare 
    %templates:wrap 
    %templates:default("mode", "any")
function list:objects-all($node as node(), $model as map(*)) {
   let $collection := collection($config:brief-collection)/tei:TEI
   let $objects := $collection//tei:rs[@type="obj"]
   for $object in $objects
   let $id := $object/ancestor::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/tei:idno
   let $title := $object/ancestor-or-self::tei:fileDesc/tei:titleStmt/tei:title[@type="meta"]/text()
   let $link := 
           let $base := './view-brief.html'
           let $href := $base || "?id=" || $id[1] 
           return
                <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$title}</a>
   order by number($id) ascending             
   return   
                        <tr>
                             <td>
                                <span>{$id}</span>
                            </td>                       
                            <td>
                                <span>{$object}</span>
                            </td>
                            <td>
                                <span>{$link}</span>
                            </td>                             
                        </tr>
};

declare 
    %templates:wrap 
    %templates:default("mode", "any")
function list:refs-briefs($node as node(), $model as map(*)) {
   let $collection := collection($config:brief-collection)/tei:TEI
   let $refs := $collection//tei:ref
   for $ref in $refs
   let $id := $ref/ancestor::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/tei:idno
   let $title := $ref/ancestor-or-self::tei:fileDesc/tei:titleStmt/tei:title[@type="meta"]/text()
   let $link := 
           let $base := './view-brief.html'
           let $href := $base || "?id=" || $id[1] 
           return
                <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$id}</a>
   let $rs := $ref/following-sibling::tei:rs
   let $xmlid := $ref/data(@xml:id)
   let $seq := $ref/data(@n)
   let $uri := <a xmlns="http://www.w3.org/1999/xhtml" href="{$ref}">{$ref}</a>
   let $reflink := 
                <a xmlns="http://www.w3.org/1999/xhtml" href="{$ref}">{$rs}</a>                
   order by number($seq) ascending             
   return
   if (not($ref[@target="http://adw-goe.de/"])) then   
                        <tr>
                            <td>
                                <span>{$link}</span>
                            </td>                        
                            <td>
                                <span>{$seq}</span>
                            </td>
                              <td>
                                <span>{$xmlid}</span>
                            </td>                             
                            <td>
                                <span>{$reflink}</span>
                            </td>
                             <td>
                                <span>{$uri}</span>
                            </td>                           
                        </tr>
    else
    ()
};

declare 
    %templates:wrap 
    %templates:default("mode", "any")
function list:emphs-all($node as node(), $model as map(*)) {
   let $collection := collection($config:brief-collection)/tei:TEI
   let $emphs := $collection//tei:emph
   for $emph in $emphs
   let $id := $emph/ancestor::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/tei:idno
   let $link := 
           let $base := './view-brief.html'
           let $href := $base || "?id=" || $id[1] 
           return
                <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$id}</a>
   order by $emph ascending             
   return   
                        <tr>
                             <td>
                                <span>{$link}</span>
                            </td>                       
                            <td>
                                <span><em>{$emph}</em></span>
                            </td>                          
                        </tr>
};

declare 
    %templates:wrap 
    %templates:default("mode", "any")
function list:titles-in-stdf($node as node(), $model as map(*)) {
   let $collection := collection($config:werke-collection)/tei:TEI
   let $groups := $collection//tei:spanGrp
   for $group in $groups
   return
       let $titles := $group//tei:span[@type='title']
       for $title in $titles
       let $id := $title/ancestor::tei:TEI/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='BiblNr']/string()
       let $link := 
               let $base := './view-work.html'
               let $href := $base || "?id=" || $id[1] 
               return
                    <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$id}</a>
       let $fulltitle := werk-view:convert-notes($title)
       let $style := data($title/@style)
       let $biblScope :=
            if ($style = 'j') then
                if ($title/following-sibling::tei:span[@type='biblScope'] and not($title/preceding-sibling::tei:span[@type='biblScope'])) then
                    $title/following-sibling::tei:span[@type='biblScope']
                 else if ($title/preceding-sibling::tei:span[@type='biblScope']) then
                 $title/preceding-sibling::tei:span[@type='biblScope']
                 else
                 ()
            else if (not($title/following-sibling::tei:span[@style='j'])) then
                $title/following-sibling::tei:span[@type='biblScope']
            else
            ()
       let $citedRange:=
            $title/following-sibling::tei:span[@type='citedRange']
       group by $fulltitle          
       order by $fulltitle ascending
       return   
                            <tr>
                                 <td>
                                    <span>{$link}</span>
                                </td>                       
                                <td>
                                    <span>{$fulltitle}</span>
                                </td>
                                <td>
                                    <span>{$biblScope}</span>
                                </td>
                                <td>
                                    <span>{$citedRange}</span>
                                </td>                                 
                            </tr>
};

declare 
    %templates:wrap 
    %templates:default("mode", "any")
function list:publishers-all($node as node(), $model as map(*)) {
   let $collection := collection($config:werke-collection)/tei:TEI
   let $publishers := $collection//tei:publisher/tei:name
   for $publ in $publishers
   let $id := 
            if ($publ/ancestor::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='BiblNr']/string()) then
            $publ/ancestor::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='BiblNr']/string()
            else
            $publ/ancestor::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='taxon']
   let $pubPlace := $publ/ancestor::tei:imprint/tei:pubPlace
   let $dsort := for $date in $publ/ancestor::tei:imprint/tei:date[@type="publication"]
                return data($date/@when)
   let $date := $publ/ancestor::tei:imprint/tei:date
   let $link := 
           let $base := 
               if ($publ/ancestor::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='BiblNr']/string()) then 
                   './view-work.html'
               else
                   './view-taxon.html' 
           let $href := $base || "?id=" || $id[1] 
           return
                <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$id}</a>           
            
   where exists($publ/text()) and not($publ/text() = '[s.n.]')             
   order by $publ ascending             
   return   
                        <tr>
                             <td>
                                <span>{$link}</span>
                            </td>                       
                            <td>
                                <span>{$publ}</span>
                            </td>
                            <td>
                                <span>{$pubPlace}</span>
                            </td>
                             <td>
                                <span>{$dsort}</span>
                            </td>                           
                            <td>
                                <span>{$date}</span>
                            </td>                             
                        </tr>
};

declare
   %templates:wrap
function list:queries($node as node(), $model as map(*)) {
   for $qry in doc($config:query-config)//query
   let $label := $qry/label/text()  
   let $id := data($qry/@n)
   let $page := $qry/page/text()
   return
        <tr>
            <td>
                <span>{$id}</span>
            </td>                         
            <td>
                <span><a href="{$page}">{$label}</a></span>
            </td>                        
        </tr>
}; 

declare
   %templates:wrap
function list:admin-functions($node as node(), $model as map(*)) {
   for $funct in doc($config:admin-config)//function
   let $label := $funct/label/text()  
   let $id := data($funct/@n)
   let $page := $funct/page/text()
   return
        <tr>
            <td>
                <span>{$id}</span>
            </td>                         
            <td>
                <span><a href="{$page}">{$label}</a></span>
            </td>                        
        </tr>
}; 

