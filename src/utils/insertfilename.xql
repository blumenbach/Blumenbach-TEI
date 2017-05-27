xquery version "3.0";
import module namespace util="http://exist-db.org/xquery/util";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $collection:= collection('/db/apps/blumenbach/data/br')
for $work in $collection
let $docname := util:document-name($work)
return 
    update value $work//tei:publicationStmt/tei:idno with $docname