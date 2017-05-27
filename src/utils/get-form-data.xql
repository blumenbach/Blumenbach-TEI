xquery version "3.0";
import module namespace config="http://exist-db.org/apps/blume/config" at "../modules/config.xqm";

let $files := collection($config:orbeon-brief-collection)//form
for $file in $files
return 
    <TEI>{$file}</TEI>