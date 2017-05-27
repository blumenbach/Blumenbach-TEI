xquery version "3.0";

(:
: Module Name: get-fragment
: Module Version: 
: Date: 
: License: GNU-LGPL
: 
: Module Overview: Returns XML Fragment
:)

(:~
 : Returns XML Fragment
 : 
 :)
 
import module namespace detail="http://exist-db.org/xquery/detail" at "detail.xql";
import module namespace config="http://exist-db.org/xquery/apps/blume/config" at "config.xqm";

declare namespace fragment="http://exist-db.org/xquery/fragment";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace so="http://standoff.proposal";
declare namespace xi="http://www.w3.org/2001/XInclude";
declare namespace util="http://exist-db.org/xquery/util";


declare variable $frag_id external;

declare function fragment:get-fragment() {
let $doc_coll := "/db/apps/blumenbach/data/ck-source"
let $frags := collection($doc_coll) 
for $frag in $frags
let $id := $frag//tei:ab/@xml:id
let $eintrag := substring-before($frag//tei:ab, '<lb/>')
let $anm := substring-after($frag//tei:ab, '<lb/>')
return
    <note type="ck_source">
        <ab resp="proj" rend="html" xml:id="{$id}">
        {$eintrag}<lb/>
        {$anm}
        </ab>
    </note>
};

let $output := fragment:get-fragment()
return
$output