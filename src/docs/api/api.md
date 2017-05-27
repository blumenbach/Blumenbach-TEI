The Blumenbach TEI Datenbank serves its collection data to clients freely using the RESTXQ interface.

<br/>
#### **API Functions**


| Description   | URI   | Link Example |
| ------------- |:-----:| ------------:|
| GET all Briefs return as HTML | `/exist/restxq/briefe` | [all briefs] ( /exist/restxq/briefe) |
| GET a single Brief by ID and return it as $output method | `/exist/restxq/briefe/{$bgid}` | [single brief]( /exist/restxq/briefe/1000) |
| GET all Werke and return as HTML | `/exist/restxq/werke` | [all werke] ( /exist/restxq/werke) |
| GET all Werke and return as XML | `/exist/restxq/werke-x` | [all werke XML] ( /restxq/werke-x) |
| GET a single Werke by ID and return it as $output method | `/exist/restxq/werke/{$wgid}` | [single werke]( /exist/restxq/werke/01001) |
| GET all Werke annotations and return as XML | `/exist/restxq/annotations` | [annotations]( /exist/restxq/annotations) |
| GET Werke annotations for a single Werk and return as XML | `/exist/restxq/annotations/{$wgid}` | [single werk annotations]( /exist/restxq/annotations/00047) |
| GET Query results using an ngram string return as XML| `/exist/restxq/search?query={$ngram}` | [XML query]( /exist/restxq/search?query=Cuvier) |

**Notes on Output Method**

The API will serialize output as HTML, JSON or XML for a single Werk or Brief

* The client must specify the desired format as an "Accept" request-header value.

For example, to GET a Brief as JSON:

```bash
curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://exist-bb.wmflabs.org/restxq/briefe/0009
```

or to retrieve a GET a Werk as XML:

```bash
curl -i -H "Accept: application/xml" -H "Content-Type: application/xml" http://exist-bb.wmflabs.org/restxq/werke/00011"
```

<br/>

#### Still a Work in Progress
If there is a specific data set needed by an external provider, you may submit a [feature request](https://github.com/christopher-johnson/Blumenbach-TEI/issues/new) and it can readily be implemented.
