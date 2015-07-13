xquery version "3.0";

import module namespace templates="http://exist-db.org/xquery/templates" at "templates.xql";
import module namespace render="http://exist-db.org/render/" at "render.xqm";
import module namespace werk-view="http://exist-db.org/werk-view/" at "werk-view.xqm";
import module namespace brief-view="http://exist-db.org/werk-view/" at "brief-view.xqm";
import module namespace taxon-view="http://exist-db.org/werk-view/" at "taxon-view.xqm";
import module namespace docs="http://exist-db.org/xquery/docs" at "docs.xqm";
import module namespace list="http://exist-db.org/lists/" at "lists.xqm";
import module namespace list-forms="http://exist-db.org/list-forms/" at "list-forms.xqm";
import module namespace query="http://exist-db.org/query/" at "query.xqm";
import module namespace taxon-detail="http://exist-db.org/xquery/taxon-detail" at "taxon-detail.xqm";
import module namespace detail="http://exist-db.org/xquery/detail" at "detail.xql";
import module namespace site="http://exist-db.org/apps/site-utils";
import module namespace config="http://exist-db.org/apps/blume/config" at "config.xqm";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "html5";
declare option output:media-type "text/html";

let $config := map {
    $templates:CONFIG_APP_ROOT := $config:app-root,
    $templates:CONFIG_STOP_ON_ERROR := true()
}
let $lookup := function($functionName as xs:string, $arity as xs:int) {
    try {
        function-lookup(xs:QName($functionName), $arity)
    } catch * {
        ()
    }
}
let $content := request:get-data()
return
    templates:apply($content, $lookup, (), $config)