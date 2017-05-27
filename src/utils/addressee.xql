xquery version "1.0";

declare default element namespace "http://www.tei-c.org/ns/1.0"; 

declare namespace briefs="briefs";

declare function briefs:list-titles($colName as xs:string) as element(*)
{
    <TEI>
    {
        let $files := collection('/db/apps/blumenbach/data/br')//teiHeader
        for $file in $files
        order by $file/fileDesc/sourceDesc/listEvent/event/@sortKey ascending
        return $file
    }
    </TEI>
};
briefs:list-titles('/db/apps/blumenbach/data/br')