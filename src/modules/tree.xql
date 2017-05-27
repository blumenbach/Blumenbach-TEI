xquery version "3.0";

(:
: Module Name: tree
: Module Version: 
: Date: 
: License: GNU-LGPL
: 
: XQuery Specification : XQuery v3.0
: Module Overview: Functions to create category tree from JSON
:)

(:~ Functions to create category tree from JSON
:)

module namespace tree="http://exist-db.org/xquery/tree";

import module namespace templates="http://exist-db.org/xquery/templates";
import module namespace config="http://exist-db.org/xquery/apps/blume/config" at "config.xqm";

declare function tree:cat-nodes ($node as node()*) {
    typeswitch ($node)
        case element(category) 
            return
                let $category :=
                    if ($node[@level="parent"]) then
                        let $child := $node/child::classCode
                        for $d in $child
                        return
                        let $desc := $d/text()  
                        let $id := data($d/@n)
                        let $key := data($d/@key)             
                        return (
                        <isFolder json:literal="true">true</isFolder>,
                        <title>{concat($id, ' : ', $desc)}</title>,
                        <key>{$key}</key>,
                        <children json:array="true">
                            {for $desc in $d/descendant::classCode
                            let $label := $d/text()  
                            let $id := data($desc/@n)
                            let $key := data($desc/@key)             
                            return (
                                <title>{concat($id, ' : ', $desc)}</title>,
                                <key>{$key}</key>)}
                         </children>)                   
                 else ()
                return $category    
        default return tree:passthru-cats($node)    
 };
 
 declare function tree:passthru-cats($nodes as node()*) as item()* {
    for $node in $nodes/node() return tree:cat-nodes($node)
};

declare function tree:sub-categories($categories as node()*, $root as xs:string, $children as node()*) {
    for $child in $children/classCode
    let $link := concat(data($child/@n), ' : ', $child/text())
    return
        <children json:array="true">
       { tree:categories($categories, concat($root, '/', $child/text()), $child) }        
    </children>
};

declare function tree:cat-item() {
   let $categories := doc($config:cat-config)
   let $output := 
            for $cat in $categories/categories/classCode
               let $desc := $cat/text()  
               let $id := data($cat/@n)
               return
                <li id="{data($cat/@key)}"><a href="./work-list-cat.html?cat={$id}" target="_self">{$desc}</a></li>            
  return $output
};

declare 
    %templates:wrap 
function tree:cat-tree($node as node(), $model as map(*)) {
    let $output :=
        <ul>
        {tree:cat-item()}
        </ul>
    return $output              
}; 

declare function tree:categories($categories as node()*, $root as xs:string, $child as node()*) {
   let $children := $categories/categories/classCode/descendant::*
   return (
        <title>{$categories/categories/classCode/text()}</title>,
        <isFolder json:literal="true">true</isFolder>,
        <key>{$root}</key>,
        if (exists($children)) then
            tree:sub-categories($categories, $root, $children)
        else
            ()
   )         
};
 