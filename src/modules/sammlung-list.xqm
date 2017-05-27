xquery version "3.0";

(:
: Module Name: lists
: Module Version: 
: Date: 
: License: GNU-LGPL
: 
: Module Overview: Functions that return data as rows for tables
:)

(:~
 : Functions that return data as rows for tables
 : 
 :)
 
module namespace sammlung-list="http://exist-db.org/xquery/sammlung-list";

import module namespace templates="http://exist-db.org/xquery/templates";
import module namespace query="http://exist-db.org/xquery/query" at "query.xqm";
import module namespace config="http://exist-db.org/xquery/apps/blume/config" at "config.xqm";
import module namespace detail="http://exist-db.org/xquery/detail" at "detail.xql";
import module namespace functx="http://www.functx.com" at "functx.xqm";
import module namespace werk-view="http://exist-db.org/xquery/werk-view" at "werk-view.xqm";
    
declare namespace gvp="http://vocab.getty.edu/ontology#";
declare namespace wgs="http://www.w3.org/2003/01/geo/wgs84_pos#";
declare namespace skos="http://www.w3.org/2004/02/skos/core#";

declare 
    %templates:wrap 
    %templates:default("mode", "any")
function sammlung-list:objekte-all($node as node(), $model as map(*)) {
   let $collection := collection($config:orbeon-sammlung-collection)
   for $objekt in ($collection//form)
   where exists($objekt//a3/string())
        return
                 let $sak := $objekt//a2
                 let $titel :=     
                      let $title := $objekt//a0
                      let $idpath := substring-after(base-uri($objekt), "/orbeon/fr/blumenbach-sammlung/main/data/" )
                      let $id := substring-before($idpath, "/data.xml")
                      let $href := "/orbeon/fr/blumenbach-sammlung/main/edit/" || $id
                      return
                          <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$title}</a>
                 let $invid := $objekt//a3
                 let $serid := $objekt//b12a
                 let $alter := tokenize($objekt//a12a,'#')
                 order by $invid ascending
                 return   
                                      <tr>
                                          <td>
                                              <span>{$sak}</span>
                                          </td> 
                                          <td>
                                              <span>{$invid}</span>
                                          </td>                             
                                          <td>
                                              <span>{$titel}</span>
                                          </td>
                                           <td>
                                              <span>{$alter[1]}</span>
                                          </td>
                                           <td>
                                              <span>{$alter[2]}</span>
                                          </td>
                                      </tr>                
};

declare 
    %templates:wrap 
    %templates:default("mode", "any")
function sammlung-list:objekte-places($node as node(), $model as map(*)) {
   let $collection := collection($config:orbeon-sammlung-collection)
   for $objekt in ($collection//form)
   where exists($objekt//a13a/text())
        return
                 let $tgnlink := 
                      let $tgnid := $objekt//a13c
                      let $tgnplace := $objekt//skos:prefLabel
                      return
                          <a xmlns="http://www.w3.org/1999/xhtml" href="{$tgnid}">{$tgnplace}</a>
                 let $ort := $objekt//a13a
                 let $invid := $objekt//a3
                 let $objlink :=
                      let $idpath := substring-after(base-uri($objekt), "/orbeon/fr/blumenbach-sammlung/main/data/" )
                      let $id := substring-before($idpath, "/data.xml")
                      let $href := "/orbeon/fr/blumenbach-sammlung/main/edit/" || $id
                      return
                          <a xmlns="http://www.w3.org/1999/xhtml" href="{$href}">{$invid}</a>
                 order by $invid ascending
                 return   
                                      <tr>
                                          <td>
                                              <span>{$objlink}</span>
                                          </td> 
                                          <td>
                                              <span>{$tgnlink}</span>
                                          </td>                             
                                          <td>
                                              <span>{$ort}</span>
                                          </td>                                          
                                      </tr>                
};

