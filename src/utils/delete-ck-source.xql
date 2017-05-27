xquery version "3.0";
import module namespace util="http://exist-db.org/xquery/util";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $collection:= collection('/db/apps/blumenbach/data/werke')
for $brief in $collection
return 
    update delete $brief//tei:note[@type='ck_source']