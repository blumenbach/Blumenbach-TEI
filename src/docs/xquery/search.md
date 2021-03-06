The Blumenbach TEI Datenbank depends on the [Lucene-based Full Text Index](http://exist-db.org/exist/apps/doc/lucene.xml) provided by the eXist-db

A form-based search is included in every [Data View](views)

* The form accepts **free text input** in the [Lucene Query Parser Syntax](https://lucene.apache.org/core/2_9_4/queryparsersyntax.html)
    * For details about different search options see [Search Help]( /apps/blumenbach/search-help.html)
* A **date** or **date range** is also accepted (only year entry currently supported)
    * The date range should be in the format (xxxx-xxxx)
    
The `collection.xconf` file defines indexes for the module [`query.xqm`]( /apps/blumenbach/xqdocs-view.html?uri=http://exist-db.org/xquery/query&location=/db/apps/blumenbach/modules/query.xqm)    

```xml
<collection xmlns="http://exist-db.org/collection-config/1.0">
    <index xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xlink="http://www.w3.org/1999/xlink">
        <fulltext default="none" attributes="false"/>
        <lucene>
            <analyzer class="org.apache.lucene.analysis.standard.StandardAnalyzer">
                <param name="stopwords" type="org.apache.lucene.analysis.util.CharArraySet"/>
            </analyzer>
            <text qname="tei:TEI"/>
            <text qname="tei:teiHeader"/>
            <text qname="tei:fileDesc"/>
            <text qname="tei:titleStmt"/>
            <text field="title" qname="tei:title[@type='main']"/>
            <text qname="tei:placeName"/>
            <text qname="tei:persName"/>
            <text qname="//tei:event[@when]"/>
        </lucene>
        <ngram qname="tei:TEI"/>
    </index>
</collection>
```
* The search form scopes are defined based on the Data View context

    * The [Home View]( /apps/blumenbach/index.html) searches **all** collections (Werke and Briefregesten)
        * The form box indicates the search scope in <span style="color:gray">gray letters</span>
         
![Search Form](/apps/blumenbach/resources/images/docs/search-form.png) 

Next: [Editing](eXide)       