xquery version "3.0";

(:
: Module Name: xtransform
: Module Version: 
: Date: 
: License: GNU-LGPL
: 
: XQuery Specification : XQuery v3.0
: Module Overview: Transforms XForm XML to TEI
:)

(:~ This module creates TEI sourcing from an XForms data collection and saving into a pre-publish staging collection 
:)

import module namespace templates="http://exist-db.org/xquery/templates";
import module namespace config="http://exist-db.org/xquery/apps/blume/config" at "config.xqm";

declare namespace xtransform="http://exist-db.org/xquery/xtransform";
declare namespace functx = "http://www.functx.com";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace file = "http://exist-db.org/xquery/file";
declare namespace transform = "http://exist-db.org/xquery/transform";
declare namespace util = "http://exist-db.org/xquery/util";
declare namespace response="http://exist-db.org/xquery/response";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

(:~
 : transform complete TEI from Form Data
 :)
declare function xtransform:complete-file($type as xs:string?, $id as xs:string?)
{
    <ROOT>
    {
        if ($type eq "brief") then       
            let $files := collection($config:orbeon-brief-collection)//form
            for $file in $files[textClass/classCode-scheme.RegNr-idno = $id]  
                return 
                    $file
        else if ($type eq "taxon") then
            let $files := collection($config:orbeon-taxon-collection)//form
            for $file in $files[profileDesc-textClass/classCode-scheme.taxon = $id]
                return 
                    $file                 
        else if ($type eq "werk") then       
            let $files := collection($config:orbeon-werk-collection)//form
            for $file in $files[profileDesc-textClass/classCode-scheme.BiblNr = $id]          
                return 
                    $file 
        else
        ()        
    }
    </ROOT>        
};

declare function xtransform:transform-file($file, $type as xs:string?, $file_format as xs:string?, $method as xs:string?, $id as xs:string?)
{
       let $xsl := 
          if ($type eq "taxon" and $file_format eq "corpus") then
            "xmldb:exist:///db/apps/blumenbach/styles/taxon-form-to-TEI-corpus.xsl"
          else if ($type eq "taxon" and $file_format eq "single") then
            "xmldb:exist:///db/apps/blumenbach/styles/taxon-form-to-TEI.xsl"            
          else if ($type eq "brief" and $file_format eq "corpus") then
            "xmldb:exist:///db/apps/blumenbach/styles/brief-form-to-TEI-corpus.xsl"
          else  if ($type eq "brief" and $file_format eq "single") then
            "xmldb:exist:///db/apps/blumenbach/styles/brief-form-to-TEI.xsl"            
          else  if ($type eq "werk" and $file_format eq "corpus") then
            "xmldb:exist:///db/apps/blumenbach/styles/werk-form-to-TEI-corpus.xsl"
          else  if ($type eq "werk" and $file_format eq "single") then
            "xmldb:exist:///db/apps/blumenbach/styles/werk-form-to-TEI.xsl"                
          else
            ()                 
        let $params := 
                 <parameters></parameters>                  
        let $options := 
            if ($method = 'download') then 
                util:declare-option("output:media-type", "application/x-download")
            else
                util:declare-option("output:media-type", "text/xml")
        let $tei := transform:transform($file, xs:anyURI($xsl), $params)
        return
            $tei       
};  

declare function xtransform:save-to-collection($tei, $resource_name as xs:string?) {
 let $resource := util:expand($tei)
 let $stored := xmldb:store($config:orbeon-publish, $resource_name, $resource)
 let $message :=
    if (not($stored)) then
        <error>
        <message>fail</message>
        </error>
     else
     <message>success</message>
  return $message     
};    

declare function xtransform:output-transformation($type as xs:string?, $id as xs:string?, $file_format as xs:string?, $method as xs:string?) {
    let $file := xtransform:complete-file($type, $id)
    let $transform := xtransform:transform-file($file, $type, $file_format, $method, $id)
    return
        $transform
};

let $type := request:get-parameter("type", ())
let $id := request:get-parameter("id", ())
let $uuid := request:get-parameter("uuid", ())
let $file_format := request:get-parameter("file_format", ())
let $method := request:get-parameter("method", ())
let $transform := 
    if ($id) then 
        xtransform:output-transformation($type, $id, $file_format, $method)
    else
    ()    
let $resource_name := 
    if ($id) then
    'jfb_' || $type || '_' || $id || '_' || $uuid || '.xml'
    else 
    'jfb_' || $type || '_corpus' || '_' || $uuid || '.xml'
let $output := 
    if ($method = 'save') then 
        let $stored := xtransform:save-to-collection($transform, $resource_name)
        return $stored
    else
        let $response_value := '"attachment; filename*=UTF-8''' || $resource_name
        let $response := response:set-header("Content-Disposition", $response_value)
        return $transform
    return
        $output