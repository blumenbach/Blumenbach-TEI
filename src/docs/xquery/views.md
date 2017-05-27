The Blumenbach Application presents the TEI data in a variety of views.

<br/>
### **Präsentation Views**  
The "Präsentation" views are replicas of the source static HTML. 
 All data is sourced from TEI files in the eXist-db collections and rendered using XSLT via the RESTXQ interface. 

* [Briefe Präsentation] (../../../../restxq/briefe) : The complete Briefregesten rendered as a single page view
* [Werke Präsentation] (../../../../restxq/werke) : The complete Bibliographie rendered as a single page view

See [Stylesheet Docs] (../styles/) for details about the transformation methods.

<br/>
### **Data Views**
The "non-presentation" views are generated with XQuery sourcing XML data directly from the eXist-db collections.

<br/>
#### **Lists**

The primary method of viewing Bibliographic and Briefregesten data in the aggregate is with lists.

* Sequencing of Lists
    * The natural ordering of entries in the list data uses a **sequence ID** to identify an entry in the complete list.
    * The sequencing concept has been developed over time by Blumenbach Online and has been retained in the TEI Datenbank for consistency with the original.

* See the **Text Class** section of the [Bibliographie TEI Specification](../tei/tei-bibl-design) or the [Briefregesten TEI Specification](../tei/tei-br-design) for details about the **sequence ID*.

<br/>
* A List view typically is presented in a tabular format with each row representing a different data entry TEI.
    * These lists are sortable by column, paginated and can be filtered.

The collection list views are:

* [Brief List](/briefs.html) : A list of all briefs in the Briefregesten
* [Werke List](/werke.html) : A list of all works in the Bibliographie
* [Taxon List](/taxons.html) : A list of all taxons in the Bibliographie

Additional list views are provided with [queries](/index.html) that retrieve a selection of data as rows based on some criteria.

* For example, the "Titeln in Briefe" retrieves all titles sorted alphabetically that are indicated in the Briefregesten.
    * [Titeln in Briefe](/emphs.html)

All form based searches will return the results as a tabular list.

<br/>
#### **Profiles**
    * Each individual entry can also be viewed in a Profile page that shows only the data for that record.
    * A single parameter "id" is passed in the URL to fetch the TEI record.
    * Navigation through individual records and searching is also possible from the profile.
    
* [Werk Profile Example]( /exist/apps/blumenbach/view-work.html?id=00047)
* [Brief Profile Example](/exist/apps/blumenbach/view-brief.html?id=1564)

    
<br/>
### **API**

The RESTXQ Interface also serves the TEI data for lists or single entries as either HTML, JSON or XML.  

* See [API Docs](../api/) for details

Next: [Searching](search)