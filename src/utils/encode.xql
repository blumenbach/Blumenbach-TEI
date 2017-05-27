xquery version "3.0";

import module namespace util="http://exist-db.org/xquery/util";

let $output := util:base64-encode('password')
return 
<code>{$output}</code>