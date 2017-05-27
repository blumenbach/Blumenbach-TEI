xquery version "3.0";
import module namespace config="http://exist-db.org/apps/blume/config" at "config.xqm";
import module namespace util="http://exist-db.org/xquery/util";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $collection:= collection('/db/apps/blumenbach/data/br-fix')
for $brief in $collection
let $id := replace($brief//tei:classCode/tei:idno, '0*([1-9][0-9]*|0)', '$1')
return 
    update value $brief//tei:classCode/tei:idno with $id