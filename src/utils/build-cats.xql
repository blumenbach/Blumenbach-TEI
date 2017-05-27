xquery version "1.0";

declare default element namespace "http://www.tei-c.org/ns/1.0"; 

declare namespace cats="cats";
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function cats:list-titles($colName as xs:string) as element(*)
{
    <categories>
    {
        for $work in collection($colName)
        let $bibsort := data($work//tei:classCode[@scheme="BiblNr"]/@n)
        let $n := data($work//tei:classCode[@scheme="cat"]/tei:idno/@n)
        let $sort := xs:decimal(data($work//tei:classCode[@scheme="cat"]/tei:idno/@n))
        let $idno := $work//tei:classCode[@scheme="cat"]/tei:idno/text()
        let $desc := $work//tei:classCode[@scheme="cat"]/text()
        where empty($work/ancestor-or-self::tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme="BiblNr"]/text())
        order by xs:decimal($sort) ascending
        return 
        <classCode scheme="cat" n="{$bibsort}">
                    <idno n="{$n}">{$idno}</idno>{$desc}</classCode>
    }  
    </categories>
};
cats:list-titles('/db/apps/blumenbach/data/werke')