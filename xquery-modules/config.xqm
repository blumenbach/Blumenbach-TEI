xquery version "3.0";

(:
: Module Name: config
: Module Version: 
: Date: 
: License: GNU-LGPL
: 
: Module Overview: Functions and variables for accessing application context
:)

(:~
 : A set of helper functions to access the application context from
 : within a module.
 :)
 
module namespace config="http://exist-db.org/apps/blume/config";

import module namespace theme="http://exist-db.org/xquery/theme" at "theme.xqm";
import module namespace templates="http://exist-db.org/xquery/templates";

declare namespace repo="http://exist-db.org/xquery/repo";
declare namespace expath="http://expath.org/ns/pkg";
declare namespace atom="http://www.w3.org/2005/Atom";

declare variable $config:base-url :=
    let $path := collection(repo:get-root())//expath:package[@name = "http://exist-db.org/apps/blumenbach"]
    let $relPath := substring-after(util:collection-name($path), repo:get-root())
    return
        request:get-context-path() || request:get-attribute("$exist:prefix") || "/" || $relPath
;

(: 
    Determine the application root collection from the current module load path.
:)
declare variable $config:app-root := 
    let $rawPath := system:get-module-load-path()
    let $modulePath :=
        (: strip the xmldb: part :)
        if (starts-with($rawPath, "xmldb:exist://")) then
            if (starts-with($rawPath, "xmldb:exist://embedded-eXist-server")) then
                substring($rawPath, 36)
            else
                substring($rawPath, 15)
        else
            $rawPath
    return
        substring-before($modulePath, "/modules")
;

declare variable $config:orbeon-fr := 'http://localhost:8080' || '/orbeon/fr/';
declare variable $config:orbeon-bb := 'http://localhost:8080' || '/orbeon/fr/blumenbach';
declare variable $config:orbeon-brief-collection := "/db/orbeon/fr/blumenbach/brief/data";
declare variable $config:orbeon-werk-collection := "/db/orbeon/fr/blumenbach/werk/data";
declare variable $config:orbeon-taxon-collection := "/db/orbeon/fr/blumenbach/taxon/data";
declare variable $config:orbeon-publish := "/db/apps/blumenbach/data/publish";
declare variable $config:restxq := request:get-context-path() || '/restxq';
declare variable $config:theme-root := theme:get-default();
declare variable $config:resources := '/apps/blumenbach/resources';
declare variable $config:themes := concat($config:app-root, "/pages");
declare variable $config:theme-config := concat($config:themes, "/configuration.xml");
declare variable $config:cat-config := "/db/apps/blumenbach/data/taxons";
declare variable $config:admin-config := concat($config:themes, "/admin-functions.xml");
declare variable $config:query-config := concat($config:themes, "/queries.xml");
declare variable $config:data-root := $config:app-root || "/data";
declare variable $config:brief-collection := "/db/apps/blumenbach/data/br";
declare variable $config:werke-collection := "/db/apps/blumenbach/data/werke";
declare variable $config:repo-descriptor := doc(concat($config:app-root, "/repo.xml"))/repo:meta;
declare variable $config:expath-descriptor := doc(concat($config:app-root, "/expath-pkg.xml"))/expath:package;
declare variable $config:data := $config:app-root || '/data';
declare variable $config:app-data := $config:app-root || "/data/annotations";
declare variable $config:wiki-config := doc(concat($config:app-root, "/configuration.xml"));
declare variable $config:wiki-root := 
    let $root := $config:wiki-config/configuration/docroot/string()
    return
      concat($config:app-root, "/", $root)
;
declare variable $config:items-per-page := 10;
declare variable $config:app-abbrev := $config:expath-descriptor/@abbrev;

(:~
 : Resolve the given path using the current application context.
 : If the app resides in the file system,
 :)
declare function config:resolve($relPath as xs:string) {
    if (starts-with($config:app-root, "/db")) then
        doc(concat($config:app-root, "/", $relPath))
    else
        doc(concat("file://", $config:app-root, "/", $relPath))
};

(:~
 : Returns the repo.xml descriptor for the current application.
 :)
declare function config:repo-descriptor() as element(repo:meta) {
    $config:repo-descriptor
};

(:~
 : Returns the expath-pkg.xml descriptor for the current application.
 :)
declare function config:expath-descriptor() as element(expath:package) {
    $config:expath-descriptor
};

declare %templates:wrap function config:app-title($node as node(), $model as map(*)) as text() {
    $config:expath-descriptor/expath:title/text()
};

declare function config:app-meta($node as node(), $model as map(*)) as element()* {
    <meta xmlns="http://www.w3.org/1999/xhtml" name="description" content="{$config:repo-descriptor/repo:description/text()}"/>,
    for $author in $config:repo-descriptor/repo:author
    return
        <meta xmlns="http://www.w3.org/1999/xhtml" name="creator" content="{$author/text()}"/>
};

declare function config:app-styles($node as node(), $model as map(*)) as element()* {
        <link rel="shortcut icon" type="image/png" href="{$config:resources}/images/schädel.png"/>,
        <link rel="stylesheet" type="text/css" href="{$config:resources}/css/font/font-awesome.css"/>,
        <link rel="stylesheet" type="text/css" href="{$config:resources}/css/style.css"/>,
        <link rel="stylesheet" type="text/css" href="{$config:resources}/css/dataTables.css"/>
};

declare function config:doc-styles($node as node(), $model as map(*)) as element()* {
        <link rel="shortcut icon" type="image/png" href="{$config:resources}/images/schädel.png"/>,
        <link rel="stylesheet" type="text/css" href="{$config:resources}/css/font/font-awesome.css"/>,
        <link rel="stylesheet" type="text/css" href="{$config:resources}/css/docs.css"/>
};

declare function config:app-scripts($node as node(), $model as map(*)) as element()* {
        <script type="text/javascript" src="{$config:resources}/scripts/jquery/jquery-1.11.2.min.js"/>,
        <script type="text/javascript" src="{$config:resources}/scripts/bootstrap-3.0.3.min.js"/>,
        <script type="text/javascript" src="{$config:resources}/scripts/jquery/jquery.dataTables.min.js"/>
};
(:~
 : For debugging: generates a table showing all properties defined
 : in the application descriptors.
 :)
declare function config:app-info($node as node(), $model as map(*)) {
    let $expath := config:expath-descriptor()
    let $repo := config:repo-descriptor()
    return
        <table class="app-info">
            <tr>
                <td>app collection:</td>
                <td>{$config:app-root}</td>
            </tr>
            {
                for $attr in ($expath/@*, $expath/*, $repo/*)
                return
                    <tr>
                        <td>{node-name($attr)}:</td>
                        <td>{$attr/string()}</td>
                    </tr>
            }
            <tr>
                <td>Controller:</td>
                <td>{ request:get-attribute("$exist:controller") }</td>
            </tr>
        </table>
};

declare function config:access-allowed($path as xs:string, $user as xs:string) as xs:boolean {
    if (sm:is-dba($user)) then
        true()
    else
        let $deny := config:get-configuration()/restrictions/deny
        return
            if ($deny) then
                not(
                    some $denied in $deny/@collection
                    satisfies starts-with($path, $denied)
                )
            else
                true()
};

declare function config:get-configuration() as element(configuration) {
    doc(concat($config:app-root, "/configuration.xml"))/configuration
};

declare function config:resolve-feed($path as xs:string) {
    let $feed := substring-after($path, "/")
    let $path := concat($config:wiki-root, "/", $feed)
    return
        xmldb:xcollection($path)/atom:feed
        (: config:resolve-feed-helper($path, false()) :)
};

declare %private function config:resolve-feed-helper($path as xs:string, $recurse as xs:boolean) {
    let $feed := xmldb:xcollection($path)/atom:feed
    return
        if ($feed) then
            $feed
        else if ($path != $config:wiki-root and $recurse) then
            config:resolve-feed-helper(replace($path, "^(.*)/[^/]+$", "$1"), $recurse)
        else
            ()
};