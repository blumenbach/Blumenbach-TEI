xquery version "3.0";
import module namespace config="http://exist-db.org/apps/blume/config" at "config.xqm";
import module namespace util="http://exist-db.org/xquery/util";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $collection:= collection('/db/apps/blumenbach/data/werke-fix')
for $werke in $collection
let $extent := $werke//tei:extent/text()
return 
    update insert <biblScope xmlns="http://www.tei-c.org/ns/1.0">{$extent}</biblScope> following $werke//tei:imprint