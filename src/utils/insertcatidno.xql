xquery version "3.0";
import module namespace util="http://exist-db.org/xquery/util";
declare namespace tei="http://www.tei-c.org/ns/1.0";
import module namespace functx="http://www.functx.com" at "../modules/functx.xqm";

let $collection:= collection('/db/apps/blumenbach/data/werke-fix')
for $taxon in $collection
let $docname := util:document-name($taxon)
let $n := number(tokenize(substring-before($docname, '.'),'_')[last()])
let $nval := functx:pad-integer-to-length($n, 4)
return 
    update insert attribute n {concat($nval, '.00')} into $taxon//tei:classCode/tei:idno