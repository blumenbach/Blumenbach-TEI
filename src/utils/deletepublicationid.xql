xquery version "3.0";
import module namespace util="http://exist-db.org/xquery/util";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $collection:= collection('/db/apps/blumenbach/data/br')
for $brief in $collection
let $id := $brief//tei:textClass/tei:classCode/tei:idno
return 
    update value $brief//tei:event/@where with concat('#orgplc_',$id)