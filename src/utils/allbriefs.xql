xquery version "3.0";

import module namespace templates="http://exist-db.org/xquery/templates";
import module namespace query="http://exist-db.org/query/" at "query.xqm";
import module namespace config="http://exist-db.org/apps/blume/config" at "config.xqm";
import module namespace tei2="http://exist-db.org/xquery/app/tei2html" at "tei2html.xql";
import module namespace detail="http://exist-db.org/xquery/detail" at "detail.xql";
import module namespace functx="http://www.functx.com" at "functx.xqm";
declare namespace tei="http://www.tei-c.org/ns/1.0"; 
declare namespace list="list";
declare namespace json="http://www.json.org";
declare option exist:serialize "method=json media-type=text/javascript";

declare function list:briefs-all() {
    <data>
    {
   let $collection := collection($config:brief-collection)/tei:TEI
   for $brief in ($collection//tei:teiHeader)
   let $asort := if ($brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/tei:surname) then
       $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/tei:surname/text()
       else
       $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/text()
   let $author := if ($brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/tei:surname) then
        $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/*
        else
        $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author/tei:persName/text()
   let $esort := 
        if ($brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/tei:surname) then
        $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/tei:surname/text()
        else
        $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/text()        
   let $empfanger :=  
        if ($brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/tei:surname) then
        $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/*
        else
        $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:persName[@resp="emp"]/text() 
   let $titel := $brief/ancestor-or-self::tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type="main"]/text()

   let $dsort := for $date in $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:origDate/tei:note/tei:listEvent/tei:event
                return data($date/@sortKey)
   let $date := $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:creation/tei:origDate/tei:note/tei:listEvent/tei:event[@type="iso-origin"]/tei:note/tei:date/text()
   let $id := $brief/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/tei:idno
   order by $dsort ascending        
    return (
        <data>,
        <ID>{$id}</ID>,
        <dsort>{$dsort}</dsort>,
        <date>{$date}</date>,
        <asort>{$asort}</asort>,
        <author>{$author}</author>,
        <esort>{$esort}</esort>,
        <empfanger>{$empfanger}</empfanger>,
        <title>{$titel}</title>,
        </data>)   
    }
    </data>
};

let $output := list:briefs-all()
return $output