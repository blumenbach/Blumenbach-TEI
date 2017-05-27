<br/>
#### **Bibliographie**

The Bibliographie schema has been modified to include "standoff" elements as proposed during the standoff-workshop in January 2014:

* [minutes of the meeting] ( /exist/rest/db/apps/blumenbach/pages/external/standoff-minutesBerlin2014.docx)
* [stdfSpec on GitHub] (https://github.com/laurentromary/stdfSpec)

The validation of the TEI dataset with the standoff schema takes these forms:

* If the data is a single TEI (not a corpus), validation can be done by including processing instruction (1) in the XML file.

Instruction #1:

```xsl
<?xml-model href="./standoff-proposal.rnc" type="application/relax-ng-compact-syntax"?>
 ```

* The schema is in the Relax NG Compact syntax, but can easily be converted to other formats (e.g. W3C XML) if required. 
 
                * Download the [standoff-proposal.rnc] ( /exist/rest/db/apps/blumenbach/data/werke/standoff-proposal.rnc)
                * The schema should be saved in the same directory as the TEI.
 
<br/>         
*  If the data is a TEI corpus (i.e. exported), validation can be done by including this processing instruction (2) in the XML file.        
        
Instruction #2:

```xsl
<?xml-model href="./bb-schema-corpus.rnc" type="application/relax-ng-compact-syntax"?>
 ```
 * Download the [bb-schema-corpus.rnc] ( /exist/rest/db/apps/blumenbach/data/werke/bb-schema-corpus.rnc)
 
 <br/>
#### **Briefregesten** 

The single Briefregesten TEI file can be validated using the default TEI namespace catalog and does not require special processing.

To validate the Briefregesten TEI Corpus, follow Instruction #2. 

<br/>
#### **Schema Customization**

There is a schema generation tool offered on the TEI website called [Roma] (http://www.tei-c.org/Roma/) that allows TEI schema manipulation.

If for some reason new TEI elements need to be added to these schema, you should use the customization files below:

* [standoff-proposal ODD] ( /exist/rest/db/apps/blumenbach/pages/external/standoff-proposal.xml)
* [bb-schema-corpus ODD] ( /exist/rest/db/apps/blumenbach/pages/external/bb-schema-corpus.xml)

Next: [TEI Design Description](tei-design)