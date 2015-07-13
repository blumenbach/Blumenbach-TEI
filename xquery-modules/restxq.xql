xquery version "3.0";

(: 
 : Defines all the RestXQ endpoints used by the XForms.
 :)
module namespace restxq="http://exist-db.org/apps/restxq";

import module namespace config="http://exist-db.org/apps/blume/config" at "config.xqm";
import module namespace transform = "http://exist-db.org/xquery/transform";

declare namespace util="http://exist-db.org/xquery/util";
declare namespace so="http://standoff.proposal";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";

declare variable $restxq:annotations := $config:app-root || "/data/annotations";


(:~
 : List all briefs and return them as HTML.
 :)
declare
    %rest:GET
    %rest:path("/briefe")
    %rest:produces("text/html")
    %output:method("html5")    
function restxq:briefs() {
    let $briefs := collection($config:brief-collection)/tei:TEI
    let $html :=
        for $brief in $briefs
        let $regnr := xs:decimal(data($brief/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/@n))
        order by xs:decimal($regnr) ascending
        return
                if ($brief) then       
                    let $xsl1 := doc("/db/apps/blumenbach/styles/emph-to-em.xsl")
                    let $retro := transform:transform($brief, $xsl1, ())
                    let $xsl2 := doc("/db/apps/blumenbach/styles/briefs.xsl")
                    let $output2 := transform:transform($retro, $xsl2, ())               
                    return
                    $output2
                else ()
     return
        <html>
            <head>
                <title class="config:app-title">Blumenbach TEI Datenbank</title>
                <link rel="stylesheet" type="text/css" href="/apps/blumenbach/resources/css/br-stylesheet.css"/>
                <link rel="shortcut icon" type="image/png" href="/apps/blumenbach/resources/images/schädel.png"/>            
            </head>
            <body>
            {$html}
            </body>
        </html>
};

(:~
 : List all werke and return them as HTML.
 :)
declare
    %rest:GET
    %rest:path("/werke")
    %rest:produces("text/html")
    %output:method("html5")    
function restxq:werke() {
    let $werke := collection($config:werke-collection)/tei:TEI
    let $menu := doc(concat($config:themes, "/default/werke-menu.html"))
    let $html :=
        for $work in $werke
        let $dsort := xs:decimal(data($work/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='BiblNr']/@n))
        order by $dsort ascending
        return
            if ($work) then       
                let $xsl1 := doc("/db/apps/blumenbach/styles/werke-annotations.xsl")
                let $retro := transform:transform($work, $xsl1, ())
                let $xsl2 := doc("/db/apps/blumenbach/styles/werke.xsl")
                let $output2 := transform:transform($retro, $xsl2, ())
                return
                $output2
            else ()
     return
        <html xmlns="http://www.tei-c.org/ns/1.0">
            <head>
                <title>Blumenbach TEI Datenbank</title>
                <link rel="stylesheet" type="text/css" href="/apps/blumenbach/resources/css/werke-stylesheet.css"/>
                <link rel="shortcut icon" type="image/png" href="/apps/blumenbach/resources/images/schädel.png"/>            
            </head>
            <body>
            {$menu}
            {$html}
            </body>
        </html>

};

(:~
 : List all werke and return them as XML.
 :)
declare
    %rest:GET
    %rest:path("/werke-x")
    %rest:produces("application/xml", "text/xml")
    %output:method("xml")    
function restxq:werke-x() {
    <werke>
    {
        let $werke := collection($config:werke-collection)//tei:TEI
        for $work in ($werke//tei:teiHeader)
        let $dsort := for $date in $work/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date[@type="publication"]
                return data($date/@when)
        order by $dsort ascending
        return
            $work
    }
    </werke>
};

(:~
 : List work contents by id and return them as HTML.
 :)
declare
    %rest:GET
    %rest:path("/werke/{$wgid}")
    %rest:produces("text/html")
    %output:method("html5")
function restxq:get-work-html($wgid as xs:string*) {
    let $werke := collection($config:werke-collection)/tei:TEI
    let $html := 
        for $work in $werke
        where $work/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme="BiblNr"] = $wgid
        return
                if ($work) then
                    let $xsl1 := doc("/db/apps/blumenbach/styles/work.xsl") 
                    let $output1 := transform:transform($work, $xsl1, ())
                    let $xsl2 := doc("/db/apps/blumenbach/styles/work-ck-format.xsl")
                    let $output2 := transform:transform($output1, $xsl2, ())
                    return 
                       $output2
                else ()
     return
        <html>
            <head>
                <title>Blumenbach TEI Datenbank</title>
                <link rel="stylesheet" type="text/css" href="/apps/blumenbach/resources/css/werke-stylesheet.css"/>
                <link rel="shortcut icon" type="image/png" href="/apps/blumenbach/resources/images/schädel.png"/>            
            </head>
            <body class="restxq">
            {$html}
            </body>
        </html>
};

(:~
 : List brief contents by id and return them as HTML.
 :)
declare
    %rest:GET
    %rest:path("/briefe/{$bgid}")
    %rest:produces("text/html")
    %output:method("html5")
function restxq:get-brief-html($bgid as xs:string*) {
    let $briefs := collection($config:brief-collection)/tei:TEI
    let $html := 
        for $brief in $briefs
        where $brief/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/tei:idno = $bgid
        return
                if ($brief) then
                    let $xsl := doc("/db/apps/blumenbach/styles/brief.xsl")        
                    return 
                       transform:transform($brief, $xsl, ())
                else ()
         return
            <html>
                <head>  
                    <title>Blumenbach TEI Datenbank</title>
                    <link rel="stylesheet" type="text/css" href="/apps/blumenbach/resources/css/br-stylesheet.css"/>
                    <link rel="shortcut icon" type="image/png" href="/apps/blumenbach/resources/images/schädel.png"/>            
                </head>
                <body class="restxq">
                {$html}
                </body>
            </html>
};

(:~
 : List work contents by id and return them as XML.
 :)
declare
    %rest:GET
    %rest:path("/werke/{$wgid}")
    %rest:produces("application/xml", "text/xml")
    %output:method("xml")    
function restxq:get-work-xml($wgid as xs:string*) {
    let $werke := collection($config:werke-collection)/tei:TEI
    for $work in $werke
    where $work/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme="BiblNr"] = $wgid
    return
        <work n="{$wgid}">
        {$work}
        </work>      
};

(:~
 : List brief contents by id and return them as XML.
 :)
declare
    %rest:GET
    %rest:path("/briefe/{$bgid}")
    %rest:produces("application/xml", "text/xml")
    %output:method("xml")    
function restxq:get-brief-xml($bgid as xs:string*) {
    let $briefs := collection($config:brief-collection)/tei:TEI
    for $brief in $briefs
    where $brief/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/tei:idno = $bgid
    return
        <brief n="{$bgid}">
        {$brief}
        </brief>      
};

(:~
 : List work contents by id and return them as JSON.
 :)
declare
    %rest:GET
    %rest:path("/werke/{$wgid}")
    %rest:produces("application/json")
    %output:method("json")    
function restxq:get-work-json($wgid as xs:string*) {
    let $werke := collection($config:werke-collection)/tei:TEI
    for $work in $werke
    where $work/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme="BiblNr"] = $wgid
    return
        $work   
};

(:~
 : List brief contents by id and return them as JSON.
 :)
declare
    %rest:GET
    %rest:path("/briefe/{$bgid}")
    %rest:produces("application/json")
    %output:method("json")    
function restxq:get-brief-json($bgid as xs:string*) {
    let $briefs := collection($config:brief-collection)/tei:TEI
    for $brief in $briefs
    where $brief/tei:teiHeader/tei:profileDesc/tei:textClass/tei:classCode[@scheme='RegNr']/tei:idno = $bgid
    return
        $brief   
};

(:~
 : List all werke annotations and return them as XML.
 :)
declare
    %rest:GET
    %rest:path("/annotations")
    %rest:produces("application/xml", "text/xml")
function restxq:annotations() {
    <annotations>
    {
        let $annotations := collection($config:werke-collection)//so:annotations
        for $groups in $annotations
        order by data($groups/@n)
        return
            $groups
    }
    </annotations>
};

(:~
 : List all werke annotations from file and return them as XML.
 :)
declare
    %rest:GET
    %rest:path("/annotations/{$wgid}")
    %rest:produces("application/xml", "text/xml")
function restxq:get-annotations($wgid as xs:string*) {
    <annotations>
    {
        for $groups in collection($config:werke-collection)//so:annotations[@n = $wgid]
        return
            $groups
    }
    </annotations>
};

(:~
 : Search collections using a given field and a (lucene) query string.
 :)
declare 
    %rest:GET
    %rest:path("/search")
    %rest:query-param("query", "{$query}")
    %rest:query-param("field", "{$field}")
function restxq:search-annotations($query as xs:string*, $field as xs:string*) {
    <JFB_TEI>
    {
        if ($query != "") then
            switch ($field)
                case "all" return
                    collection($config:data)//tei:TEI[ngram:contains(., $query)]
                case "werke" return
                    collection($config:werke-collection)//tei:TEI[ngram:contains(., $query)]
                case "briefs" return
                    collection($config:brief-collection)//tei:TEI[ngram:contains(., $query)]
                case "notes" return
                    collection($config:werke-collection)//so:annotations[ngram:contains(., $query)]                     
                default return
                    collection($config:data)//tei:TEI[ngram:contains(., $query)]
        else
            collection($config:data)//tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title
    }
    </JFB_TEI>
};

(:~
 : Update an existing address or store a new one. The address XML is read
 : from the request body.
 :)
declare
    %rest:PUT("{$content}")
    %rest:path("/annotations")
function restxq:create-or-edit-annotation($content as node()*) {
    let $id := ($content//tei:spanGrp/@id, util:uuid())[1]
    let $data :=
        <annotations id="{$id}">
        { $content//tei:spanGrp/* }
        </annotations>
    let $log := util:log("DEBUG", "Storing data into " || $restxq:data)
    let $stored := xmldb:store($restxq:data, $id || ".xml", $data)
    return
        restxq:annotations()
};

(:~
 : Delete an address identified by its uuid.
 :)
declare
    %rest:DELETE
    %rest:path("/annotations/{$id}")
function restxq:delete-annotation($id as xs:string*) {
    xmldb:remove($restxq:data, $id || ".xml"),
    restxq:annotations()
};