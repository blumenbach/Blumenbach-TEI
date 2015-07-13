xquery version "3.0";

module namespace docs="http://exist-db.org/xquery/docs";

declare namespace wiki="http://exist-db.org/xquery/wiki";
declare namespace atom="http://www.w3.org/2005/Atom";
declare namespace html="http://www.w3.org/1999/xhtml";
import module namespace config="http://exist-db.org/apps/blume/config" at "config.xqm";
import module namespace templates="http://exist-db.org/xquery/templates";
import module namespace atomic="http://atomic.exist-db.org/xquery/atomic" at "atomic.xql";

declare function docs:feed($node as node(), $model as map(*)) {
    let $feed := request:get-attribute("feed")
    return
        map { "feed" := $feed }
};

declare function docs:content($node as node(), $model as map(*)) {
    element { node-name($node) } {
        $node/@*,
        attribute id { $model("entry")/atom:id },
        let $summary := $model("entry")/atom:summary
        let $atomContent := $model("entry")/atom:content
        let $content := atomic:get-content($atomContent, true())
        return $content
    }
};

declare function docs:get-or-create-entry($node as node(), $model as map(*), $lock as xs:string?) {
    let $feed := $model("feed")
    let $id := request:get-parameter("id", ())
    let $wikiId := request:get-parameter("wiki-id", ())
    return
        element { node-name($node) } {
            $node/@*,
            if ($id or $wikiId) then
                let $entry := docs:get-entries($feed, $id, $wikiId)
                let $locked := atomic:lock-for-user($entry)[1]
                return
                    if ($locked) then
                        <div class="alert">
                            <h3>Document Locked</h3>
                            <p>The document is currently being edited by another user.</p>
                        </div>
                    else
                        templates:process($node/node(), map:new(($model, map { "entry" := $entry })))
            else
                templates:process($node/node(), map:new(($model, map { "entry" := atomic:create-entry() })))
        }
};

declare function docs:get-entries($feed as element(atom:feed), $id as xs:string?,
    $wikiId as xs:string?) as element(atom:entry)* {
    docs:get-entries($feed, $id, $wikiId, false())
};

declare function docs:get-entries($feed as element(atom:feed), $id as xs:string?,
    $wikiId as xs:string?, $recurse as xs:boolean) as element(atom:entry)* {
    let $entryCollection := 
        if ($recurse) then
            collection(util:collection-name($feed))
        else
            xmldb:xcollection(util:collection-name($feed))
    return
        if ($wikiId) then
            $entryCollection/atom:entry[wiki:id = $wikiId]
        else if ($id) then
            $entryCollection/atom:entry[atom:id = $id]
        else
            $entryCollection/atom:entry
};

declare
    %templates:wrap
    %templates:default("start", 1)
function docs:entries($node as node(), $model as map(*), $count as xs:string?, $id as xs:string?, $wiki-id as xs:string?,
    $start as xs:int) {
    let $feed := $model("feed")
    let $allEntries := docs:get-entries($feed, $id, $wiki-id)
    return
        if (empty($allEntries)) then
            <p class="alert alert-info">{$feed}</p>
        else
            let $entries :=
                if ($allEntries[wiki:is-index = "true"]) then
                    $allEntries[wiki:is-index = "true"][1]
                else
                    atomic:sort($allEntries)
            let $count := if ($count) then number($count) else $config:items-per-page
            return (
                for $entry in subsequence($entries, $start, $count)
                return
                    templates:process($node/*[1], map:new(($model, map { "entry" := $entry, "count" := count($entries) }))),
                templates:process($node/*[2], map:new(($model, map { "count" := count($entries), "perPage" := $count })))
            )
};

declare %private function docs:process-content($type as xs:string?, $content as item()?, $model as map(*)) {
    docs:process-content($type, $content, $model, true())
};

declare function docs:process-content($type as xs:string?, $content as item()?, $model as map(*),
    $expandTemplates as xs:boolean) {
    let $type := if ($type) then $type else "html"
    return
        switch ($type)
            case "html" case "xhtml" case "markdown" return
                let $data := atomic:process-links($content)
                return
                    if ($expandTemplates) then
                        templates:process($data, $model)
                    else
                        $data
            default return
                $content
};

declare
    %templates:wrap
function docs:breadcrumbs($node as node(), $model as map(*)) {
    let $path := substring-after(document-uri(root($model("entry"))), $config:wiki-root)
    let $steps := (reverse(docs:breadcrumbs($path)), $model("entry"))
    for $step in $steps
    return
        if ($step instance of element(atom:feed)) then
            <li><a href="{docs:feed-url($step)}">{$step/atom:title/text()}</a></li>
        else
            <li>{$step/atom:title/text()}</li>
};

declare function docs:breadcrumbs($path as xs:string) {
    let $path := replace($path, "^(.*)/[^/]+/?$", "$1")
    let $feed := xmldb:xcollection($config:wiki-root || $path)/atom:feed
    return (
        $feed,
        if (contains($path, "/")) then
            docs:breadcrumbs($path)
        else
            ()
    )
};

declare function docs:title($node as node(), $model as map(*)) {
    let $entry := $model("entry")
    let $user := request:get-attribute("org.exist.wiki.login.user")
    let $link :=
        if (empty($entry)) then
            "."
        else if ($entry/wiki:id) then
            $entry/wiki:id/string()
        else
            concat("?id=", $entry/atom:id)
    return
        element { node-name($node) } {
            $node/@*,
            let $data := if ($entry) then $entry else $model("feed")
            return
                if ($data/atom:title[@type = "xhtml"]) then
                    $data/atom:title/node()
                else if ($data/atom:title/text()) then (
                    <a class="tree" href="{$link}">{$data/atom:title/string()}</a>
                ) else
                    <a>Untitled</a>
        }
};

declare function docs:feed-url($feed as element(atom:feed)) {
    let $path := substring-after(util:collection-name($feed), $config:base-url || "/")
    let $feed :=
        concat($config:base-url, "/", $path)
    return
        if (ends-with($feed, "/")) then
            $feed
        else
            concat($feed, "/")
};