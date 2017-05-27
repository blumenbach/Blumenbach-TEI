xquery version "3.0";

import module namespace templates="http://exist-db.org/xquery/templates";
import module namespace config="http://exist-db.org/apps/blume/config" at "config.xqm";
import module namespace tei2="http://exist-db.org/xquery/app/tei2html" at "tei2html.xql";
import module namespace kwic="http://exist-db.org/xquery/kwic" at "resource:org/exist/xquery/lib/kwic.xql";
    
declare namespace functx = "http://www.functx.com";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace file = "http://exist-db.org/xquery/file";
declare namespace transform = "http://exist-db.org/xquery/transform";
declare namespace style="style";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:media-type "application/xml";

let $xml := "/tmp/complete-br.xml"
let $xsl := "BR_TEI_Template_0.3.xsl"
return
    transform:stream-transform(doc($xml), doc($xsl), ())     
