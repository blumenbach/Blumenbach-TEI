xquery version "3.0";
import module namespace util="http://exist-db.org/xquery/util";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $collection:= collection('/db/apps/blumenbach/data/br')
for $brief in $collection
return 
    update value $brief//tei:encodingDesc/tei:projectDesc/tei:p with 'Projekt „Johann Friedrich Blumenbach - online“ der Akademie der Wissenschaften zu Göttingen'