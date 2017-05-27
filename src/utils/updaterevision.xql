xquery version "3.0";
import module namespace util="http://exist-db.org/xquery/util";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $collection:= collection('/db/apps/blumenbach/data/werke')
let $now := current-dateTime()
for $brief in $collection
return 
    update value $brief//tei:revisionDesc/tei:change with 'Erstellungsdatum: ' || $now