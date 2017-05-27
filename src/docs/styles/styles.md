There are several transformation scenarios in the Blumenbach Application.

* TEI to HTML
* TEI to TEI Corpus
* XForm XML to TEI

<br/>
The stylesheets that are included in the Blumenbach application for these scenarios can be grouped by function as follows:

### HTML Präsentation Stylesheets

The requirements of the project specify that the original static HTML styles be transcribed to XML and that an output consistent with the static files be accurately rendered.

* The presentation stylesheets manipulate the data from an XML nodeset.
    * The nodeset is first created by a FLOWR expression from an XQuery function.  The expression orders and sequences the individual collection TEI headers.

<br/>    
* The formatting of the "style type" data elements in the TEI that need to be represented in the HTML is generated with **style rules** in the stylesheets.
    * For example, the representation of *italics*, encoded in the TEI as an
     
```
<emph>
```
 element, is outputted as an HTML `<em>` tag with an identity transformation.  See the `werke-identity.xsl` stylesheet code [here]( /exist/rest/db/apps/blumenbach/pages/external/xslt/werke-identity.html)
 
other TEI style-related elements include:
 
```
<hi>, <lb>, <pc>, <ref>, <ptr> and <span>
```
 
* Supplementary typography and layout formatting is also done with CSS.
    
#### **Bibliographie Annotations**

* A complex implementation of stylesheet formatting rules was required for the standoff annotations.  A basic standoff annotation structure may look like this:

```xml
\<stdf xmlns="http://standoff.proposal">
    \<annotations n="00076">
        \<spanGrp xmlns="http://www.tei-c.org/ns/1.0" xml:id="biblStruct\_d1e6769_00076">
            \<span type="note">Angezeigt von Blumenbach in</span>
            \<span type="title" style="j">GgA</span>
            \<span type="meta">
                \<metamark>
                    \<pc unit="space"/>
                \</metamark>
            \</span>
            \<span type="biblScope">1818 (172. Stück, 26. Oktober)</span>
            \<span type="citedRange">S. 1713-1715; „London“</span>
            \<span type="reference">00584</span>
        \</spanGrp>
    \</annotations>
\</stdf>
```
The standoff annotation schema relies on the `<span>` element.
  
    * Serialization of these annotations as XHTML, then, allows for literal node copies which appear in the HTML as `<tei:span type=$type>`
  
    * For consistency with the TEI schema, the `@type` attribute value is generally assigned to TEI element Qnames where applicable.
    * See [Bibliographie TEI Specification](../tei/tei-bibl-design) for details.
    
The intent of the standoff annotation  is to represent the data individually as metadata elements that are **sequence neutral**.  
Since delimiting punctuation always implies a syntactic data context, it should not begin or end the element value.

    * Interstitial element punctuation is generally retained
      
_The punctuation is therefore understood as the product of a `style rule` that interprets the preceding and following delimiters of the data element based on its type and relationship within the sequence of other elements._ 

The output of the above XML as HTML looks like this:

<span style="color: black">
Angezeigt von Blumenbach in *GgA* 1818 (172. Stück, 26. Oktober), S. 1713-1715; „London“ [[->584]](/apps/blumenbach/view-work.html?id=00584).</span>

<br/> 
#### Style Rules Explanation:
    * the stylesheet interprets that when a `citedRange` type is preceded by a `biblScope`, then a comma and a space should precede it.
 
```xml
  \<xsl:when test="./@type='citedRange'">
    \<xsl:if test="preceding-sibling::span\[@type='biblScope']\[1] or preceding-sibling::span\[@type='date']\[1] 
        or preceding-sibling::\span[@type='title']\[1]">, </xsl:if>
    \<xsl:copy-of select="."/>
  \</xsl:when>
```
 
* the title style "j" is always italicized.  
    * Sometimes, the application of style rules overlaps, so this requires recursive application.  
    * For example, it is possible for a part of the title type "j" to also have a highlight (encoded with the `<hi>` element),

```xml
\<xsl:template match="span[@style='j']">
  \<xsl:element name="em" namespace="http://www.w3.org/1999/xhtml">
    \<xsl:choose>
      \<xsl:when test=".//hi">
        \<xsl:call-template name="rend-green-sm"/>
      \</xsl:when>
      \<xsl:otherwise>
        \<xsl:value-of select="."/>
      \</xsl:otherwise>
    \</xsl:choose>
  \</xsl:element>
\</xsl:template>
```

* the pc unit "space" inserts a space after the title to separate it from the `biblScope`.  
    * This is done explicitly because the "GgA" is an atypical title that is **not** followed by a comma.
    * Explicitly encoded punctuation in the TEI is typically wrapped in the `<metamark>` element
    
* the hyperlink is created from the `<span type="reference>"`.
* Every `<spanGrp>` ends with a period by default.  The `<spanGrp>` defines a syntactic statement or sentence.
        
<br/>
* This is a basic example of the punctuation rules implementation.  
For more details, see the präsentation stylesheet documentation:

* [`werke.xsl`]( /rest/db/apps/blumenbach/pages/external/xslt/werke.html)
* [`werke-identity.xsl`]( /rest/db/apps/blumenbach/pages/external/xslt/werke-identity.html)
* [`briefs.xsl`]( /rest/db/apps/blumenbach/pages/external/xslt/briefs.html)
* [`briefs-identity.xsl`]( /rest/db/apps/blumenbach/pages/external/xslt/briefs-identity.html)


### XML to XML Transformation Stylesheets

In addition to transforming TEI to HTML, XSLT also facilitates XML to XML transformations.


#### **Export**
* The [Export](/apps/blumenbach/export-bibl.html) function serializes a complete collection of TEI and exports it as a TEI Corpus.
        * The entire Bibliographie TEI Corpus file is 148,000+ lines of TEI, made of 1082 individual TEI files.
        * The entire Briefregesten TEI Corpus file is 208,000+ lines of TEI, made of 1665 individual TEI files.

The stylesheet used for this is [`workcorpus.xsl`]( /rest/db/apps/blumenbach/pages/external/xslt/workcorpus.html) which simply creates a `<teiCorpus>` root element with a `<teiHeader>` 
and then copies each individual TEI in the ordered nodeset provided by the FLOWR expression.  

<br/>
#### **XForm to TEI** 
The XForm entered data (referred to as an `instance`) is not saved in TEI format.  The brief instance XML looks like this:

```xml
    <form>
        <textClass>
            <classCode-scheme.RegNr-idno/>
            <classCode-n/>
        </textClass>
        <titleStmt>
            <title-type.meta/>
        </titleStmt>
        <sourceDesc>
            <title-type.source/>
            <author-forename/>
            <author-surname/>
        </sourceDesc>
        <notesStmt>
            <note-type.Überlieferung/>
            <note-type.Drucke/>
            <note-type.Edition/>
            <note-type.Werke/>
            <note-type.Objekte-rs/>
            <note-type.Anmerkung-note/>
        </notesStmt>
        <profileDesc>
            <creation-persName-forename/>
            <creation-persName-surname/>
            <event-type.origin-when/>
            <event-type.origin-note-type.abfassungsdatum-date/>
            <event-type.julian-origin-when/>
            <event-type.julian-origin-note-type.abfassungsdatum-date/>
            <placeName-type.Abfassungsort/>
        </profileDesc>
        <notesStmt\_refs>
            <grid-26>
                <grid-26-iteration>
                    <note-type.ref/>
                    \<ref-type\>pdf\</ref-type\>
                    <note-type.ref-rs/>
                </grid-26-iteration>
            </grid-26>
        </notesStmt\_refs>
    </form>
```
  
The design intention is to use [XForms](../xforms/) to facilitate the creation and publication of TEI.
 
* In the [`publication process`](../xforms/xforms-usage) these form fields are mapped to TEI elements and the data values copied using XSLT.

These stylesheets perform this function:

    * [brief-form-to-TEI.xsl] ( /rest/db/apps/blumenbach/pages/external/xslt/brief-form-to-TEI.html)
    * [werk-form-to-TEI.xsl] ( /rest/db/apps/blumenbach/pages/external/xslt/werk-form-to-TEI.html)
    * [taxon-form-to-TEI.xsl] ( /rest/db/apps/blumenbach/pages/external/xslt/taxon-form-to-TEI.html)    

<br/>
#### **Offline Utilities**

In the TEI development process, XSLT stylesheets are also used for offline manipulation of the TEI.

* For example, if a bulk change is made in the TEI Corpus file, then new collection files need to be regenerated.
    * These transformations are always done on the client, (e.g. using Oxygen).  
        * Stylesheets for this type of purpose are located in the `styles/offline` directory.      
 