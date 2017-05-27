xquery version "3.0";

declare namespace test="http://exist-db.org/xquery/test";
import module namespace config="http://exist-db.org/apps/blume/config" at "config.xqm";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
import module namespace functx="http://www.functx.com" at "functx.xqm";

declare function test:get-briefs-for-work($id as xs:string) {
    <TEI>
    {
    let $briefs := collection($config:brief-collection)//tei:TEI
    for $brief in $briefs
    for $rs in $brief//tei:rs[@type='html']
    let $bid := $rs/ancestor::tei:teiHeader//tei:idno[@type='RegNr']
    let $rstrim := functx:substring-before-if-contains($rs, ' ')
    where $rstrim = $id
    order by $bid ascending
    return $bid
    }
    </TEI>    
};
let $id := request:get-parameter('id', '00001')
return test:get-briefs-for-work($id)
