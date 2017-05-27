xquery version "3.0";

(:
: Module Name: get-remote-data
: Module Version: 
: Date: 
: License: GNU-LGPL
: 
: Module Overview: Returns Remote API Response
:)

(:~
 : Returns Remote API Response
 : 
 :)

import module namespace httpclient = "http://exist-db.org/xquery/httpclient";
import module namespace request = "http://exist-db.org/xquery/request";

declare namespace tgn = "http://textgrid.info/namespaces/vocabularies/tgn";
declare namespace remote = "http://exist-db.org/xquery/remote";
declare variable $remote:HEADERS := <headers/>;

declare function remote:search-textgrid-tgn($q as xs:string) {
    <root>
        {
            let $req := xs:anyURI('http://textgridlab.org/tgnsearch/tgnquery.xql?ac=' || $q)
            let $items := httpclient:get($req, true(), $remote:HEADERS)/httpclient:body/tgn:response/tgn:term
            for $item in $items
            return
                <term>
                    <id>{'http://vocab.getty.edu/tgn/' || substring-after(data($item/@id), ':')}</id>
                    <label>{$item/tgn:name/string() || ' | ' || $item/tgn:path/string()}
                    </label>
                </term>
        }
    </root>
};
let $query-string := tokenize(request:get-parameter('q', ''), '\s')
let $last-item := $query-string[last()]
let $query-string :=
    if ($last-item castable as xs:integer)
    then
    string-join(subsequence($query-string, 1, count($query-string) - 1), ' ')
    else
    string-join($query-string, ' ')

return
    remote:search-textgrid-tgn(encode-for-uri($query-string))