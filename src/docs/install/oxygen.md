<br/>
The Oxygen XML Editor is a valuable tool for managing and developing XQuery applications with eXist.

To connect the Oxygen Editor with an eXist database:

In Preferences > Data Sources

    * create a new datasource with type "eXist"
    * add these files:

```xml
$exist/exist.jar
$exist/lib/core/xmldb.jar
$exist/lib/core/xmlrpc-client-3.1.3.jar
$exist/lib/core/xmlrpc-common-3.1.3.jar
$exist/lib/core/ws-commons-util-1.0.2.jar
```

See the eXist [Using Oxygen] (http://exist-db.org/exist/apps/doc/oxygen.xml) page for more details.