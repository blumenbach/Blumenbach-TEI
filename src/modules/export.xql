xquery version "3.0";

(:
: Module Name: export
: Module Version: 
: Date: 
: License: GNU-LGPL
: 
: Module Overview: Exports TEI collection as TEI Corpus
:)

(:~
 : Transforms individual TEI Headers into a single file TEI Corpus and outputs as a download 
 : 
 :)
 
import module namespace templates="http://exist-db.org/xquery/templates";
import module namespace config="http://exist-db.org/xquery/apps/blume/config" at "config.xqm";
    
declare namespace export="http://exist-db.org/xquery/export";
declare namespace functx = "http://www.functx.com";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace file = "http://exist-db.org/xquery/file";
declare namespace transform = "http://exist-db.org/xquery/transform";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace response="http://exist-db.org/xquery/response";


(:~
 : export TEI Corpus from individual TEI Headers
 :)
declare function export:complete-file($type as xs:string?)
{
    <ROOT>
    {
        if ($type eq "br-corpus") then
             let $files := collection($config:brief-collection)/tei:TEI
            for $file in $files
            group by $regnr := substring-before(data($file/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/@n),'.')
            order by number($regnr) ascending
            return 
                $file 
        else if ($type eq "taxon-corpus") then
             let $files := collection($config:werke-collection)/tei:TEI
            for $file in $files
            where exists($file/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='taxon'])
            group by $taxonnr := $file/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='taxon']
            order by number($taxonnr) ascending 
            return 
                $file                 
        else if ($type eq "werke-corpus") then       
            let $files := collection($config:werke-collection)/tei:TEI
            for $file in $files
            where exists($file/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='BiblNr']/string()) and not($file/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='taxon'])
            group by $biblnr := $file/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='BiblNr']
            order by number($biblnr) ascending        
            return 
                $file
        else
        ()        
    }
    </ROOT>        
};

declare function export:transform-file($file, $type as xs:string?)
{
           let $xsl := 
              if ($type eq "br-corpus") then
                "xmldb:exist:///db/apps/blumenbach/styles/brcorpus.xsl"
              else  if ($type eq "werke-corpus") then
                "xmldb:exist:///db/apps/blumenbach/styles/workcorpus.xsl"
              else  if ($type eq "taxon-corpus") then
                "xmldb:exist:///db/apps/blumenbach/styles/workcorpus.xsl"                
              else
                ()        
        let $params := 
                 <parameters></parameters>                  
        let $options := util:declare-option("output:media-type", "application/x-download")
                 
        let $tei := transform:transform($file, xs:anyURI($xsl), $params)  
        return
            $tei       
};  

declare function export:serialized-file($transform) {
    let $datestamp := fn:current-date()
    let $filename := "jfb_briefregesten_" || $datestamp || ".tei"
    let $params := 
    <parameters>
       <param name="output:method"  value="xml"/>
    </parameters>
    return
        file:serialize($transform, xs:anyURI($filename), $params)
};

declare function export:output-transformation($type as xs:string?) {
    let $file := export:complete-file($type)
    let $transform := export:transform-file($file, $type)
    return
        $transform
};

let $type := request:get-parameter("type", ())
let $date := fn:current-date()
let $sdate := substring-before($date, "+")
let $resource_name := 'jfb_' || $type || '_' || $sdate || '.xml'
let $transform := export:output-transformation($type)
let $output :=
       if ($transform) then
            let $response := response:set-header("Content-Disposition", "attachment; filename=" || $resource_name)
            return $transform
       else
       ()
    return
        $output

 
