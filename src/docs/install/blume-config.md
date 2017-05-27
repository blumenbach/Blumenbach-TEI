<br/>
#### **Configuration Variables**
The Blumenbach Application Configuration is set with configuration variables:

* Edit [`modules/config.xqm`] (/apps/eXide/index.html?open=/db/apps/blumenbach/modules/config.xqm) 
    * The link above uses eXide to edit the local instance and requires authentication.
    * To connect and edit files with Oxygen, see [Oxygen Guide] (oxygen)
    
To link to Orbeon Forms:

* Two variables need to be assigned to the Orbeon Forms instance URI:

```xquery
declare variable $config:orbeon-fr := 'http://localhost:8080' || '/orbeon/fr/';
declare variable $config:orbeon-bb := 'http://localhost:8080' || '/orbeon/fr/blumenbach';
```

* Change "http://localhost:8080" to the URI of the Orbeon Forms Instance

    **No other configuration changes** are required to use the application.

Other important configuration variables are:

```xquery
declare variable $config:restxq := request:get-context-path() || '/restxq';
declare variable $config:resources := '/apps/blumenbach/resources';
declare variable $config:themes := concat($config:app-root, "/pages");
declare variable $config:theme-config := concat($config:themes, "/configuration.xml");
declare variable $config:cat-config := "/db/apps/blumenbach/data/taxons";
declare variable $config:admin-config := concat($config:themes, "/admin-functions.xml");
declare variable $config:query-config := concat($config:themes, "/queries.xml");
declare variable $config:brief-collection := "/db/apps/blumenbach/data/br";
declare variable $config:werke-collection := "/db/apps/blumenbach/data/werke";
declare variable $config:repo-descriptor := doc(concat($config:app-root, "/repo.xml"))/repo:meta;
declare variable $config:expath-descriptor := doc(concat($config:app-root, "/expath-pkg.xml"))/expath:package;
declare variable $config:data := $config:app-root || '/data';
declare variable $config:wiki-config := doc(concat($config:app-root, "/configuration.xml"));
```
<br/>
#### **Adding the RESTXQ Registry**
As indicated in Step 2, the file `restxq.registry` should be copied manually from the Blumenbach application root to `$exist/webapp/WEB-INF/data`


<br/>
#### **Security and Permissions**
The Blumenbach Application has two main security contexts:

* Guest
* Administrator

<br/>
* Note: the `configuration.xml` in the root directory contains elements for a "system-user" and "system-password".
    * the values are encrypted with base64 encoding.
    * a new installation **must** add new base64 encoded values to match a _dba_ level account to run the `filesize` module.
    * See the `/utils/encode.xql` script for the method to create a new entry.
    
All data can be read freely without restriction by the anonymous user (Guest).

Administrative functions at [Administration](/apps/blumenbach/admin/index.html) require authentication.

To edit an XML file in eXide requires **write** permissions on the file.  Guest does not have this permission!

* For a complete overview of Security in eXist see [Security] (http://exist-db.org/exist/apps/doc/security.xml)