The Bibliographie TEI Design can be visualized using a grid format:

#### **TEI Divisions**

![Bibliographie TEI Design](/apps/blumenbach/resources/images/docs/bibl-tei-design.png)

In this grid, the primary TEI Header divisions (`<fileDesc>`,`<profileDesc>`, `<encodingDesc>`, and `<revisionDesc>`) are clear.

* The supplementary "standoff annotations" schema is declared in the prolog with the inclusion of the processing instruction
    * the element `<stdf xmlns="http://standoff.proposal">` defines the beginning of the standoff element data.  

```xml
<?xml-model href="./standoff-proposal.rnc" type="application/relax-ng-compact-syntax"?>
```
* For details about the standoff schema, see [Validation Guide](tei-valid)

* While not used currently, the `<text><body>` division is also present as a requirement of the TEI schema.

<br/>
#### **Monograph Title**

![Bibliographie TEI Design](/apps/blumenbach/resources/images/docs/bibl-tei-design-title.png)

A complication in the encoding of monograph titles is the use of interstitial punctuation delimiters by the author.

* Semantically, the _slash_ `/` has an ambiguous meaning, but usually indicates a **subtitle**
* The ellipsis `…` indicates abbreviation or omission
* The bindestrich `–` indicates an editorial or **supplementary title** addition

The encoding of these title segments uses the following typology:

* `@type` : main, aut, ed, and sub

    * The stylesheet rules determine the sequence of the title segments based on the type assignment.
    
For example, the above title is rendered like this in the presentation:

    * <span style="color: black">Io. Frid. Blumenbachii … de generis humani varietate nativa liber : cum figuris aeri incisis. – Editio altera longe auctior et emendatior</span>

<br/>
#### **Bibliographic Structure**

The data model for the Bibliographie uses the `<biblStruct>` TEI element with the ancestors `<fileDesc><sourceDesc>` 

    * The formality of this element ensures the proper classification of Werk entry types **monograph** and **analytic**
 
 ![Bibliographie TEI Design](/apps/blumenbach/resources/images/docs/bibl-tei-design-biblStruct.png)
 
 * The `@level` attribute generally defines the `<title>` element _style_ in the rendering.
 * The `<imprint>` child element of `<monograph>` formally defines the three required components of the publication reference, **publisher**, **pubPlace** and **date**.
 * The `<biblScope>` and `<citedRange>` elements are typically present only with an `<analytic>` type entry. 
 
 <br/>
#### **Manuscript Description**

An important child of `<sourceDesc>` is the `<msDesc>` element.
![Bibliographie TEI Design](/apps/blumenbach/resources/images/docs/bibl-tei-design-msDesc.png)

* The repository and idno for the source are defined.
    * `<idno>` contains an `@n` attribute that is used as the _href_ for the hyperlink in the rendering
        * This is **not** equivalent to the text value of the idno which may contain special (non-URL encodable) characters
        
* Also, the `<physDesc>` of the manuscript is defined:
    * the `<extent>` element typically contains the volumetric data about the manuscript.

* If the manuscript has not been "autopsied" by the author, the `<certainty><desc>` element is used to indicate this.
    * The certainty style was created by the author and is represented in the rendering with an `*` before the title. 
    
 <br/>
#### **Text Class**

 ![Bibliographie TEI Design](/apps/blumenbach/resources/images/docs/bibl-tei-design-textclass.png)
 
* The **sequence ID** for the Werk is defined in the `<textClass><classCode>` element.
    * The attribute `@scheme` distinguishes this entry as a **BiblNr**
    * The attribute `@n` of `<classCode>` defines the nodeset sequence returned from the FLOWR expression by appending a **2 digit decimal** index to the idno.
        * this allows for sequential indexing of new entries that may need to be positioned between two existing IDs.

 <br/>
#### **Taxons**

If the attribute `@scheme` has a value of **cat**, this defines a taxon.

* Taxons are groups that the author has created to semantically categorize the Werke.
    * The `<idno>` is used programatically to lookup indexing and text display values in the **taxon registry** located in `/data/taxons/categories.xml`
    
* A taxon registry entry looks like this:

```xml
    <classCode scheme="cat" n="00000.02" xml:id="cat_0002">
        \<idno n="0002.00">I.1\</idno>
        \<rs>De Generis Humani Varietate\</rs>
    </classCode>
```
* Additional metadata for each taxon is encoded in a TEI file as `/data/werke/jfb\_werke\_taxon_xxx`

* The taxons are rendered in different views:
    * In sequence with the [Werke Präsentation](/exist/restxq/werke)
    * As an [Inhaltsverzeichnis](/exist/apps/blumenbach/inhalt-tree.html)
    * As a [Taxon profile](/exist/apps/blumenbach/view-taxon.html?id=0089)
    * As a [Werke Taxon List](/exist/apps/blumenbach/work-list-cat.html?id=0003)
    * As a [Complete Taxon List](/exist/apps/blumenbach/taxons.html)

<br/>    
#### **Standoff Annotations**    

 ![Bibliographie TEI Design](/apps/blumenbach/resources/images/docs/bibl-tei-design-stdf.png)
 
 * The standoff annotations design uses the TEI element `<spanGrp>` to represent a single **statement** 
    * Each `<spanGrp>` consists of multiple `<span>` elements defined with an `@type` attribute value that is generally assigned to a TEI element Qname
    * The `<spanGrp>` may be assigned a _style_ attribute value "n" that renders all values as <span style="color: green">green text</span>
    * A style rule renders a `.` by default as the ending delimiter for each `<spanGrp>`
    * Intersitial `<span>` delimiting punctuation is typically encoded as `@type` **meta**
    
#### _Span Typology_
The following are the types of the annotation `<span>` elements:

* note
* title (@style = "m" or @style ="j")
* meta
* biblScope
* citedRange
* reference
* repository
* idno
* edition
* img
* pubPlace
* publisher
* date
* reference
* msDesc
* extent
* dimensions
* anm (indicates a superscript note reference)

#### **XML File Example**

See [Werk # 0115](../../../../../exist/apps/eXide/index.html?open=/db/apps/blumenbach/data/werke/jfb_werke_00115.xml) 

    
            