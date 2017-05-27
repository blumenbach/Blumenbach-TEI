xquery version "1.0";
module namespace browse-books="http://exist-db.org/xquery/apps/blume/browse-books";

declare namespace anno="http://exist-db.org/xquery/annotate";
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare default element namespace "http://www.tei-c.org/ns/1.0";
declare copy-namespaces no-preserve, no-inherit;
declare boundary-space strip;

import module namespace config="http://exist-db.org/apps/blume/config" at "config.xqm";
import module namespace browse-data="http://exist-db.org/xquery/apps/blume/browse-data" at "browse_data.xqm";


declare function browse-books:data-all( $context-nodes as node()*, $level as node(),  $root as xs:boolean ){
    if( $root or $level/pos = 1 ) then 
        collection($config:brief-collection)/tei:TEI        
   else $context-nodes/ancestor-or-self::tei:TEI
};

declare function browse-books:title-extract( $title as node(), $root as node(),  $URIs as node()* ){     
     let 
         $uri := document-uri( $root )     
         (: $title := $root//tei:fileDesc/tei:sourceDesc/tei:biblFull/tei:titleStmt :)
     
     return 
        element title {
            if( $uri = $URIs/uri ) then attribute {'selected'}{'true'} else (),
            attribute {'language'}{ string($root/text/@xml:lang)  },     
            attribute {'value'} { $uri },            
            attribute {'uri'} { $uri },
            
            if( exists($title/title[@type='main']) ) then
                 $title/title[@type="main"]   
            else if( string($title[empty(@type)][1]) = 'Title' or empty($title/title) or fn:string-join($title/title,'') = '' ) then 
                 concat('[',  util:document-name($root), ']') 
            else $title/title
         } 
};

declare function browse-books:titles-list( $nodes as element()*,  $level as node()?, $URIs as node()*, $Categories as element(category)* ){
    element titles {
         attribute {'name'}{ 'uri' },
         attribute {'count'}{ count($nodes)},
         attribute {'title'}{ $level/@title },
         element {'group'}{
             for $title in $nodes//tei:fileDesc/tei:titleStmt       (:              :)
             let $title2 := browse-books:title-extract($title,  root($title),$URIs )
             order by string($title2)
             return $title2
         }
    }    
};