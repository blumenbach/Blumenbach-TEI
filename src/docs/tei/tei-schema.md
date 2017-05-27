There are different TEI schema used for the Bibliographie and the Briefregesten.

Both are based on TEI P5 version 2.8.0 and contain these modules:

* core
* tei
* textstructure
* header
* analysis
* msdescription
* namesdates
* corpus
* certainty
* transcr
* linking

<br/>
#### TEI Header

The bibliographic data for each type of entry is encoded in the TEI Header element.

See the [Text Encoding Initiative](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/HD.html) for specifics about the TEI Header layout.

<br/>
#### Validation

The TEI encoded data format can be validated against TEI standards using a validation engine like Xalan or Saxon EE, both included in the Oxygen XML Editor.

* See the [Validation Guide] (tei-valid) for details.

While the schema is entirely consistent with TEI, unique attribute values actually define the data.
  
* For example, the `@type` attribute is widely used in different elements to specify XHTML output rendering methods.
    * See [Stylesheet Docs] (../styles/) for details.
        
    
<hr/>
See the [Technical Schema Documentation] ( /rest/db/apps/blumenbach-html-docs/schema-docs/bb-schema-corpus.html) for a complete overview of the TEI Schema.

* Note: this requires that the Blumenbach HTML Documentation application has been installed.  
    * To install, see [Install Application Archive] (../install/xar).

Next: [TEI Validation Guide](tei-valid)
    
        

