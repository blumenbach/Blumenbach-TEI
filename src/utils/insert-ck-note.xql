xquery version "3.0";
import module namespace util="http://exist-db.org/xquery/util";
declare namespace tei="http://www.tei-c.org/ns/1.0";
import module namespace functx="http://www.functx.com" at "../modules/functx.xqm";

let $werke := collection('/db/apps/blumenbach/data/werke-fix')
let $merge := collection('/db/apps/blumenbach/data/merge')
for $work in $werke
    let $biblnr := $werke//tei:classCode[@type='biblNr']
    where $biblnr = $merge
    return 
        update insert $insert into $werke//tei:sourceDesc 