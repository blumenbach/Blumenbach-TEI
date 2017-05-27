The Briefregesten TEI Design can be visualized using a grid format:

#### **TEI Divisions**

![Briefregesten TEI Design](/exist/apps/blumenbach/resources/images/docs/br-tei-design.png)

In this grid, the primary TEI Header divisions (`<fileDesc>`,`<profileDesc>`, `<encodingDesc>`, and `<revisionDesc>`) are clear.

* While not used currently, the `<text><body>` division is also present as a requirement of the TEI schema.

<br/>
#### **Brief Creation**
* The unique adaptation of the "correspondence" type bibliographic entry required a definition for the Brief `creation`.
![Briefregesten TEI Design](/exist/apps/blumenbach/resources/images/docs/br-tei-design-creation.png)

<br/>

* Here you can see that role of the "empfanger" is defined under `<creation>` as `<persName resp="emp">`.  
    * The author (i.e. creator) is defined in the `<sourceDesc><biblFull><titleStmt><author>` **and** as a meta element in `<titleStmt><author>`
* The `<creation>` element has two other children. `<origDate>` and `<placename>` where additional information about the letter creation is encoded.
    * `<origDate>` is an important field because it defines the relationship of the correspondence origin to a chronology of events.  

<br/>
#### Event
Since the origin date itself has no semantic meaning without the associated event, the
 
```
\<note><listEvent><event>
```

 field is encoded as a child.

* The place of the event is encoded with a pointer `@where` referencing the `<placeName>` field defined as `@type` "Abfassungsort".
    * The place/event is also assigned a unique value as `@xml:id`.
* other attributes of `<event>` are `@when`, `@type` and `@sortKey`.  
    * There are two values for `<event> @type` in the complete Briefregesten. **origin** and **julian-origin**
    * If **julian-origin** is a type value, then the `@datingMethod="#julian"` attribute follows.
* the Event also has a `<note>` element where the "Abfassungdatum" is specified as both a text field and ISO 8601 @when value.
    * In practice, the `<date when>` value _should be_ equivalent to the `<event when>` value.  
        * However, the relationship between the "event" and the "date" should be loosely coupled and accomodate exceptions.    

<br/>
#### **Calendar Models**              
* Two Calendar models are described in the
 
```
<calendarDesc>
```
element defined like this.  
            
```xml
    <calendarDesc>
        <calendar style="ISO 8601">
            <p>Julian calendar (including proleptic)</p>
        </calendar>
        <calendar style="ISO 8601">
            <p>Gregorian calendar</p>
        </calendar>
    </calendarDesc>
```
    * The default style for all @when attribute values is thus defined as "ISO 8601"

<br/>                  
#### **Notes Statement**
Most of the bibliographic data for the entry is organized in the 

```
<notesStmt>
```
division as follows:

![Briefregesten TEI Design](/exist/apps/blumenbach/resources/images/docs/br-tei-design-notes.png)

There are 7 note types as follows:

1. **Überlieferung** : Defines a manuscript location 
1. **Drucke** : Defines printed versions of the Brief
1. **Edition** : Defines the Bibliographic Edition where the Brief was published
1. **Werke** : Defines the Werke that are relevant to the Brief contents
1. **ref** : Defines references
1. **Objekte** : Defines collection objects that are relevant to the Brief
1. **Anmerkung** : Defines additional notes related to the Brief

<br/>
#### **References and Pointers**

![Briefregesten TEI Design](/exist/apps/blumenbach/resources/images/docs/br-tei-design-refs.png)

* Every reference is assigned an xml:id that is used by `<ptr>` elements in the context of the element data value to create hyperlinks in the rendering.
* Two primary types for a reference are used: **pdf** and **html**.  
* The hyperlink text description is encoded as an `<rs>` child element.  

<br/>
#### **Text Class**

* The **sequence ID** for the Brief is defined in the `<textClass><classCode>` element.
    * The attribute `@scheme` distinguishes this entry as a **RegNr**
    * The attribute `@n` of `<classCode>` defines the nodeset sequence returned from the FLOWR expression by appending a **2 digit decimal** index to the idno.
        * this allows for sequential indexing of new entries that may need to be positioned between two existing IDs.
         
```xml
    <textClass>
        <classCode scheme="RegNr" n="01168.01">
            \<idno>1663\</idno>
        </classCode>
    </textClass>
 ```
This above is an example of a new entry assigned with an ID that is different than the value of the `<idno>`
         
    * The child element `<idno>` of `<classCode>` defines a **4 digit** integer as the ID label used in the presentation view.

<br/>    
#### **XML File Example**

See [Brief # 0693](../../../../../exist/apps/eXide/index.html?open=/db/apps/blumenbach/data/br/jfb_br_0693.xml) 

See also: [Bibliographie TEI Design](tei-bibl-design)   