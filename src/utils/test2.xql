xquery version "3.0";

import module namespace filesize="filesize" at "filesize.xql";
import module namespace request="http://exist-db.org/xquery/request";
import module namespace functx="http://www.functx.com" at "functx.xqm";

let $uri := escape-uri(request:get-parameter('url', ()), false())
let $results := filesize:get-file-header($uri)
let $size := $results//line[contains(.,'Content-Length:')]/text()
let $value := number(substring-after($size, 'Content-Length: '))
let $mb := $value div 1048576
return <node>{round($mb *100) div 100} MiB</node> 

