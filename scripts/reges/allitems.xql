xquery version "1.0";

declare default element namespace "http://www.tei-c.org/ns/1.0"; 

declare namespace briefs="briefs";

declare function briefs:list-titles($colName as xs:string) as element(*)
{
    <TEI>
    {
        let $items := collection($colName)//item
        for $item in $items
        return $item  
    }  
    </TEI>
};
briefs:list-titles('/db/apps/blumenbach/data/br1.1')