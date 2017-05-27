xquery version "1.0";

declare default element namespace "http://www.tei-c.org/ns/1.0"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace briefs="briefs";

declare function briefs:reindex($colName as xs:string)
{
xmldb:reindex($colName)
};


declare function briefs:index-query($colName as xs:string) as element(*)
{
    <TEI>
    <text>
    <body>  
    {
        let $items := collection($colName)/tei:TEI
        let $div := $items//tei:placeName[ft:query(., 'Berlin')]
        return
        <div xmlns="http://www.w3.org/1999/xhtml" class="play">
        { $div }
        </div>
    }
    </body>
    </text>    
    </TEI>
};
briefs:reindex('/db/apps/blumenbach')

