xquery version "3.0";

(:
: Module Name: xqdocs
: Module Version: 
: Date: 
: License: GNU-LGPL
: 
: XQuery Specification : XQuery v3.0
: Module Overview: Inspects modules and stores documentation as xqdoc
:)

(:~ Inspects modules and stores documentation as xqdoc
:)

import module namespace inspect="http://exist-db.org/xquery/inspection" at "java:org.exist.xquery.functions.inspect.InspectionModule";
import module namespace config="http://exist-db.org/xquery/apps/blume/config" at "config.xqm";
import module namespace xdb="http://exist-db.org/xquery/xmldb";
import module namespace dbutil="http://exist-db.org/xquery/dbutil";

declare namespace xqdocs="http://exist-db.org/xquery/xqdocs";
declare namespace xqdoc="http://www.xqdoc.org/1.0";

declare %private function xqdocs:load-stored($path as xs:anyURI, $store as function(xs:string, element()) as empty()) {
    let $meta := inspect:inspect-module($path)
    return
        if ($meta) then
            let $xml := xqdocs:generate-xqdoc($meta)
            let $moduleURI := $xml//xqdoc:module/xqdoc:uri
            return
                $store($path, $xml)
        else
            ()
};

declare %private function xqdocs:load-external-modules($store as function(xs:string, element()) as empty()) {
    for $path in dbutil:find-by-mimetype(xs:anyURI("/db/apps/blumenbach/modules"), "application/xquery")
    return
        try {
            xqdocs:load-stored($path, $store)
        } catch * {
            (: Expected to fail if XQuery file is not a library module :)
            ()
        }
};

declare function xqdocs:load-fundocs($target as xs:string) {
    let $dataColl := xdb:create-collection($target, "xqdocs")
    let $store := function($moduleURI as xs:string, $data as element()) {
        let $name := util:hash($moduleURI, "md5") || ".xml"
        return
        (
            xdb:store($dataColl, $name, $data),
            sm:chmod(xs:anyURI($dataColl || "/" || $name), "rw-rw-r--")
        )[2]
    }
    return (
    	xqdocs:load-external-modules($store)
    )
};

declare function xqdocs:generate-xqdoc($module as element(module)) {
    <xqdoc:xqdoc xmlns:xqdoc="http://www.xqdoc.org/1.0">
        <xqdoc:control>
            <xqdoc:date>{current-dateTime()}</xqdoc:date>
            <xqdoc:location>{$module/@location/string()}</xqdoc:location>
        </xqdoc:control>
        <xqdoc:module type="library">
            <xqdoc:uri>{$module/@uri/string()}</xqdoc:uri>
            <xqdoc:name>{$module/@prefix/string()}</xqdoc:name>
            <xqdoc:comment>
                <xqdoc:description>{$module/description/string()}</xqdoc:description>
                {
                    if ($module/version) then
                        <xqdoc:version>{$module/version/string()}</xqdoc:version>
                    else
                        ()
                }
                {
                    if ($module/author) then
                        <xqdoc:author>{$module/author/string()}</xqdoc:author>
                    else
                        ()
                }
            </xqdoc:comment>
        </xqdoc:module>
        <xqdoc:functions>
        {
            for $func in $module/function
            return
                <xqdoc:function>
                    <xqdoc:name>{$func/@name/string()}</xqdoc:name>
                    <xqdoc:signature>{xqdocs:generate-signature($func)}</xqdoc:signature>
                    <xqdoc:comment>
                        <xqdoc:description>{$func/description/string()}</xqdoc:description>
                        {
                            for $param in $func/argument
                            return
                                <xqdoc:param>${$param/@var/string()}{xqdocs:cardinality($param/@cardinality)}{" "}{$param/text()}</xqdoc:param>
                        }
                        <xqdoc:return>
                        {$func/returns/@type/string()}{xqdocs:cardinality($func/returns/@cardinality)}{if(empty($func/returns/text())) then "" else " : " || $func/returns/text()}
        
                        </xqdoc:return>
                        {
                            if ($func/deprecated) then
                                <xqdoc:deprecated>{$func/deprecated/string()}</xqdoc:deprecated>
                            else
                                ()
                        }  
                    </xqdoc:comment>
                </xqdoc:function>
        }
        </xqdoc:functions>
    </xqdoc:xqdoc>
};

declare function xqdocs:cardinality($cardinality as xs:string) {
    switch ($cardinality)
        case "zero or one" return "?"
        case "zero or more" return "*"
        case "one or more" return "+"
        default return ()
};

declare function xqdocs:generate-signature($func as element(function)) {
    $func/@name/string() || "(" ||
    string-join(
        for $param in $func/argument
        return
            "$" || $param/@var/string()  || " as " || $param/@type/string() || xqdocs:cardinality($param/@cardinality),
        ", "
    ) || 
    ")" || " as " || $func/returns/@type/string() || xqdocs:cardinality($func/returns/@cardinality)
};

xqdocs:load-fundocs($config:app-root)