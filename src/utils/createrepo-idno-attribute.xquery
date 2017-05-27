xquery version "3.0";
import module namespace util="http://exist-db.org/xquery/util";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $collection:= collection('/db/apps/blumenbach/data/werke')
for $werke in $collection
let $msid := $werke//tei:span[@type ='idno']
let $val := $werke//tei:span[@type ='idno']/text()
return 
    update insert attribute n {$val} into $msid