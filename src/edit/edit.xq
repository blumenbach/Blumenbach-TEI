xquery version "3.0";

declare namespace edit="edit";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace so="http://standoff.proposal";
declare namespace xf="http://www.w3.org/2002/xforms";

import module namespace config="http://exist-db.org/apps/blume/config" at "../modules/config.xqm";

declare option exist:serialize "method=xhtml media-type=text/xml indent=yes process-xsl-pi=no";

let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')
let $data-collection := '/restxq/annotations'
(: Put in the appropriate file name.  Use new-instance.xml for new forms and get the data
   from the data collection for updates.  :)
let $file := if ($new) then 
        'new-instance.xml'
    else 
        concat($data-collection, $id, '.xml')
        
let $style := 
       <style type="text/css">
       <![CDATA[
       @namespace xf url("http://www.w3.org/2002/xforms");

       body {
           font-family: Helvetica, Ariel, Verdana, sans-serif;
       }

       .term-name .xforms-value {width: 50ex;}
       .definition .xforms-value {
           height: 5em;
           width: 600px;
       }
           
       /* align the labels but not the save label */
       xf|output xf|label, xf|input xf|label, xf|textarea xf|label, xf|select1 xf|label {
           display: inline-block;
           width: 14ex;
           text-align: right;
           vertical-align: top;
           margin-right: 1ex;
           font-weight: bold;
       }

       xf|input, xf|select1, xf|textarea, xf|ouptut {
           display: block;
           margin: 1ex;
       }
       ]]>
       </style>
       
let $model := 
    <xf:model>
        <xf:instance xmlns="" id="all">
            <annotations/>
        </xf:instance>
        <xf:instance xmlns="" id="template">
            <span type=""/>
        </xf:instance>
        <xf:instance xmlns="" id="search">
            <parameters>
                <query/>
                <field>name</field>
            </parameters>
        </xf:instance>
        <!-- 
            $restxq contains the restxq endpoint, usually /exist/restxq on a default instance.
            It is set as an URL parameter by the controller.
            While it could be hardcoded, we want to make sure it always works if the context changes, e.g. to
            /exist-test/restxq.
        -->
        <xf:bind id="address-id" nodeset="//tei:spanGrp/@id" relevant="true()"/>
        <xf:submission id="load" resource="{$data-collection}/{$bgid}" method="get" replace="instance">
            <xf:message ev:event="xforms-submit-done" level="ephemeral">Annotations list loaded.</xf:message>
        </xf:submission>
        <xf:submission id="save" resource="{$data-collection}" method="put" replace="instance" ref="//tei:spanGrp[index('address-repeat')]">
            <xf:message ev:event="xforms-submit-done" level="ephemeral">Annotations saved.</xf:message>
            <xf:message ev:event="xforms-submit-error" level="ephemeral">An error occurred.</xf:message>
        </xf:submission>
        <xf:submission id="delete" resource="{$data-collection}/{instance('all')//tei:spanGrp[index('address-repeat')]/@id}" method="delete" replace="instance">
            <xf:message ev:event="xforms-submit-done" level="ephemeral">Annotations deleted.</xf:message>
            <xf:message ev:event="xforms-submit-error" level="ephemeral">An error occurred.</xf:message>
        </xf:submission>
        <xf:submission id="search" resource="{$data-collection}search" method="get" serialization="application/x-www-form-urlencoded" ref="instance('search')" targetref="instance('all')" replace="instance"/>
        <xf:action ev:event="xforms-ready">
            <xf:send submission="load"/>
        </xf:action>
    </xf:model>
       
let $content :=
            <div class="content">
                    <h3>Edit Annotations</h3>           
                    <xf:textarea ref="//tei:title" class="definition">
                       <xf:label>Title:</xf:label>
                    </xf:textarea>         
                    <xf:submit submission="save">
                        <xf:label>Save</xf:label>
                    </xf:submit>
              </div>  
let $form := 
<html xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xf="http://www.w3.org/2002/xforms" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ev="http://www.w3.org/2001/xml-events" >
    <head>
       <title>Edit Item</title>
        {$style}
        {$model}
    </head>
    <body>
            <div class="container">
            {$content}
            </div>
    </body>
</html>
            
let $xslt-pi := processing-instruction xml-stylesheet {'type="text/xsl" href="/exist/rest/db/xforms/xsltforms/xsltforms.xsl"'}
            
return ($xslt-pi, $form)

