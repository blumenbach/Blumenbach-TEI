xquery version "3.0";

declare namespace test="test";

let $output := util:registered-modules()
return 
<xml>
{$output}
</xml>