The original data for the TEI was sourced from two static HTML web pages developed by the Blumenbach Online project.

* [Johann Friedrich Blumenbach. Bibliographie seiner Schriften] (http://www.blumenbach-online.de/fileadmin/wikiuser/Daten_Digitalisierung/Bibliographie/Bibliographie.html)
* [Regesten zum Briefwechsel Johann Friedrich Blumenbachs] (http://www.blumenbach-online.de/fileadmin/wikiuser/Daten_Digitalisierung/Briefregesten/Blumenbach_Briefregesten.html)

Within these pages are bibliographic data and annotations regarding the writings of Johann Friedrich Blumenbach.  
The difficulty in maintaining and organizing this data as static HTML provided a solid justification for migration to an XML database application.

#### **Data Migration**
The migration of this data to TEI posed several challenges including:

* character encoding
* sequencing and indexing
* punctuation
* referencing
* formatting

The intention of the Blumenbach TEI Datenbank project is a literal **transcription** of the HTML presentation while also providing the benefits of a dynamic XML architecture.

<br/>
For example, these benefits include:

* Queries and granular data extraction
* Flexibility in presentation and formatting
* Extensibility and portability to other data provider frameworks, including existing TEI texts.
* Dynamic data views and sorting
* Archiving and versioning
* Full UTF-8 compliance
 
A "divide and conquer" strategy was used to a large extent to encode the Bibliographie data.  Basically, this meant that monolithic syntax was divided into the smallest possible elements.
The Briefregesten, in contrast, had already been divided into formal data structures, so preserving this organization meant that the encoding was less flexible.

#### **TEI Design Specifications**

* [Briefregesten TEI Specification] (tei-br-design)
* [Bibliographie TEI Specification] (tei-bibl-design)

Next: [TEI Schema](tei-schema)