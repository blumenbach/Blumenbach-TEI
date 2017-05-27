xquery version "3.0";
import module namespace util="http://exist-db.org/xquery/util";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $collection:= collection('/db/apps/blumenbach/data/br')
for $werk in $collection
return 
    update replace $werk//tei:orgName[@resp="proj"] with <orgName xmlns="http://www.tei-c.org/ns/1.0" resp="proj"><name xmlns="http://www.tei-c.org/ns/1.0">Akademie der Wissenschaften zu Göttingen</name><ref xmlns="http://www.tei-c.org/ns/1.0" target="http://adw-goe.de/"/></orgName>