xquery version "1.0";
import module namespace xqxuf="http://www.w3.org/2007/xquery-update-10";
declare default element namespace "http://www.tei-c.org/ns/1.0"; 

declare namespace update="update";

declare function update:delete-rs()
{
        let $refs := collection('/db/apps/blumenbach/data/br')//tei:notesStmt/tei:note[@type='ref']
        for $ref in $refs/tei:rs[@type='obj']
        return
            xqxuf:update delete $ref
};
update:delete-rs()