xquery version "3.0";
import module namespace util="http://exist-db.org/xquery/util";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $collection:= collection('/db/apps/blumenbach/data/taxons')/tei:categories
for $taxon in $collection/tei:classCode
    let $id := substring-before($taxon/tei:idno/@n, '.')
    let $out := concat('cat_', $id)
    return
        update insert attribute xml:id {$out} into $taxon