xquery version "1.0";

declare default element namespace "http://www.tei-c.org/ns/1.0"; 

declare namespace briefs="briefs";

declare function briefs:list-titles($colName as xs:string) as element(*)
{
    <TEI>
    <text>
    <body>  
    {
        let $items := collection($colName)//item
        for $item in $items
        return 
         <item n="{$item/@xml:id}">
         {
            for $pers in $item//persName
            return $pers
         }   
        </item>   
    }
    </body>
    </text>    
    </TEI>
};
briefs:list-titles('/db/apps/blumenbach/data/br')