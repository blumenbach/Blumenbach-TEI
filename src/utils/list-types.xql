xquery version "3.0";

declare default element namespace "http://www.tei-c.org/ns/1.0"; 

declare namespace types="types";

declare function types:list-types($colName as xs:string)
{
    <TEI>
    {
        let $types := collection($colName)//*/@type
        for $type in $types
        let $value := data($type/@type)
        let $name :=
            if (exists($type/@type)) then
            $type/name()
            else ()
        let $output :=
            if ($name and $value) then
            $name || ':' || $value 
            else
            ()
        group by $type    
        return 
        $output
    }  
    </TEI>
};
types:list-types('/db/apps/blumenbach/data')