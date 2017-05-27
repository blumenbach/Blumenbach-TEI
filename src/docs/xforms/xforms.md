"Because XForms makes it easy to edit complex XML data there are many advantages to using XForms with native XML databases that frequently leverage REST interfaces. The combination of three technologies (XForms on the client, REST interfaces and XQuery on the server) is collectively known as XRX application development. XRX is known for its simple architecture that uses XML both on the client and in the database and avoids the transformations to object or relational data structures."

* From the Wikipedia article [XForms](https://en.wikipedia.org/wiki/XForms)

The Blumenbach application integrates [Orbeon Forms](http://wiki.orbeon.com/forms/doc) in order to facilitate the user creation of TEI.

#### **Form Runner**
The Orbeon application [Form Runner](/apps/blumenbach/redirect-orbeon.xml) provides an interface to the three main XForm use cases:

* [Werk Form](/apps/blumenbach/redirect-orbeon.xml?page=blumenbach/werk/summary)
* [Brief Form](/apps/blumenbach/redirect-orbeon.xml?page=blumenbach/brief/summary)
* [Taxon Form](/apps/blumenbach/redirect-orbeon.xml?page=blumenbach/taxon/summary)

From this interface, the form entered data can be administered directly.

* Administration functions include:
    * New Form entry
    * Editing of existing entry
    * Viewing as PDF
    * Deletion
    * Duplication
    
#### **Orbeon Forms Integration with eXist**
Orbeon Forms runs in a separate servlet served by [Apache Tomcat 7.0](https://tomcat.apache.org/download-70.cgi)

* See [Orbeon Installation](../install/orbeon) for details

The data collection for Orbeon Forms, however, is in the eXist-db.  By default, the collection is `/db/orbeon`

* data entered in the Blumenbach application forms is saved in `/db/orbeon/fr/blumenbach`

Next: [Using XForms](xforms-usage)
