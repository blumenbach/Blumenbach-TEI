xquery version "3.0";

import module namespace templates="http://exist-db.org/xquery/templates";
import module namespace config="http://exist-db.org/apps/blume/config" at "config.xqm";

declare namespace functx = "http://www.functx.com";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace file = "http://exist-db.org/xquery/file";
declare namespace transform = "http://exist-db.org/xquery/transform";
declare namespace util = "http://exist-db.org/xquery/util";
declare namespace publish="publish";
declare namespace response="http://exist-db.org/xquery/response";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

(:~
 : Publish TEI to Data Collection
 :)

declare function publish:copy-to-collection($source as xs:string?, $target as xs:string?, $resource as xs:string?) {
    let $isCollection := xmldb:collection-available($source)
    return
        try {
            if ($isCollection) then
                let $null := xmldb:copy($source, $target, $resource)
                        return
                            <response status="ok"/>
            else
            ()
            } catch * {
                <response status="fail">
                    <message>Failed to Publish File</message>
                </response>
            } 
};    

let $source := request:get-parameter("source", ())
let $target := request:get-parameter("target", ())
let $resource := request:get-parameter("resource", ())
let $method := request:get-parameter("method", ())
return
    try {
        if ($method = 'copy') then 
                let $result:= publish:copy-to-collection($source, $target, $resource)
                return
                    ($result[@status = "fail"], $result[1])[1]
        else
        ()
    } catch * {
        <response status="fail">Error</response>
    }