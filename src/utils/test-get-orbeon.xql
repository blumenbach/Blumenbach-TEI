xquery version "3.0";

import module namespace config="http://exist-db.org/apps/blume/config" at "../modules/config.xqm";
import module namespace util = "http://exist-db.org/xquery/util";
import module namespace httpclient = "http://exist-db.org/xquery/httpclient";
    
    let $form-path := 'blumenbach/taxon'
    let $uuid := '746e789e01f6691235286ce9f37a9cde20b350cd'
    let $orbeon-search-uri := $config:orbeon-fr || '/service/persistence/search/'
    let $form-path := $orbeon-search-uri || $form-path
    let $query := <search>
                    <drafts>include</drafts>
                        <page-size>10</page-size>
                        <page-number>1</page-number>
                        <lang>en</lang>
                  </search>
    let $headers := <headers><header name="Content-Type" value="application/xml"/></headers>              
    let $document := httpclient:post($form-path, $query, true(), $headers)
    return
    <orbeon>
        {$document}
    </orbeon>    