xquery version "3.0";

(:
: Module Name: render
: Module Version: 
: Date: 
: License: GNU-LGPL
: 
: XQuery Specification : XQuery v3.0
: Module Overview: Functions that abstract the UI with configuration variables
:)

(:~ Functions that abstract the UI with configuration variables 
:)

module namespace render="http://exist-db.org/xquery/render";

import module namespace templates="http://exist-db.org/xquery/templates";
import module namespace config="http://exist-db.org/xquery/apps/blume/config" at "config.xqm";

(:~
 : Returns a restxq link with base path for a view.
 :)
declare %templates:wrap function render:restxq-briefe($node as node(), $model as map(*)) {
    <a href="{$config:restxq}/briefe">Briefe Präsentation</a>
};

(:~
 : Returns a restxq link with base path for a view.
 :)
declare %templates:wrap function render:restxq-werke($node as node(), $model as map(*)) {
    <a href="{$config:restxq}/werke">Werke Präsentation</a>
};

(:~
 : Returns orbeon context (and port) with base path for a view.
 :)
declare %templates:wrap function render:orbeon-fr($node as node(), $model as map(*)) {
    <a href="{$config:orbeon-fr}">Forms Home</a>
};

declare %templates:wrap function render:orbeon-new-objekt($node as node(), $model as map(*)) {
    <a href="{$config:orbeon-fr}/blumenbach-sammlung/main/new">New Objekt</a>
};

declare %templates:wrap function render:orbeon-new-taxon($node as node(), $model as map(*)) {
    <a href="{$config:orbeon-bb}/taxon/new">New Taxon</a>
};

declare %templates:wrap function render:orbeon-new-brief($node as node(), $model as map(*)) {
    <a href="{$config:orbeon-bb}/brief/new">New Brief</a>
};

declare %templates:wrap function render:orbeon-new-werk($node as node(), $model as map(*)) {
    <a href="{$config:orbeon-bb}/werk/new">New Werk</a>
};

declare %templates:wrap function render:logout($node as node(), $model as map(*)) {
    if (exists(request:get-attribute("org.exist.login.user"))) then
        <a href="{$config:app-abbrev}/login?logout=true">Logout</a>
    else
    () 
};
