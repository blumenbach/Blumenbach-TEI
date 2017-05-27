xquery version "3.0";
import module namespace util="http://exist-db.org/xquery/util";
declare namespace tei="http://www.tei-c.org/ns/1.0";
import module namespace functx="http://www.functx.com" at "../modules/functx.xqm";

let $collection:= collection('/db/apps/blumenbach/data/werke-fix')
for $taxon in $collection
let $rs := $taxon//tei:textClass/tei:classCode[@scheme='cat']/text()
let $id := $taxon//tei:textClass/tei:classCode[@scheme='cat']/tei:idno/text()
return 
    update replace $taxon//tei:textClass/tei:classCode[@scheme='cat'] with <classCode xmlns="http://www.tei-c.org/ns/1.0" scheme="cat"><idno xmlns="http://www.tei-c.org/ns/1.0">{$id}</idno><rs xmlns="http://www.tei-c.org/ns/1.0">{$rs}</rs></classCode>