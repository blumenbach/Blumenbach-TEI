xquery version "3.0";

(:
: Module Name: filesize
: Module Version: 
: Date: 
: License: GNU-LGPL
: 
: Module Overview: Prefetch Content-Length for files with curl
:)

(:~
 : Prefetches file size using curl
 : 
 :)
 
module namespace filesize="http://exist-db.org/xquery/filesize";

import module namespace process="http://exist-db.org/xquery/process" at "java:org.exist.xquery.modules.process.ProcessModule";
import module namespace config="http://exist-db.org/xquery/apps/blume/config" at "config.xqm";

declare function filesize:get-file-header($url as xs:string?) {
    let $input := concat($url, ' |  grep -i Content-Length |  tr -d &#39;\r&#39; $2 | tr -d &#39;Content Length:-&#39; $3 | numfmt --to=iec-i --suffix=B --padding=7 $4')
    let $opts := '-sI'
    let $options := <option></option>
    let $results := system:as-user((util:base64-decode($config:system-user)),(util:base64-decode($config:system-password)), (process:execute(("curl", $opts, $input) , $options)))
    return
    $results
};

declare function filesize:get-size($url as xs:string) {
let $uri := escape-uri($url, false())
let $results := filesize:get-file-header($uri)
let $size := $results//line[contains(.,'Content-Length:')]/text()
let $value := number(substring-after($size, 'Content-Length: '))
let $mb := 
    if ($value) then
        $value div 1048576
    else ()    
let $round := round(xs:decimal($mb) *100) div 100
let $output := concat($round, ' Mib')
    return $output
};

