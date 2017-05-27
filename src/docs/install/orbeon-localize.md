
<br/>
#### **Orbeon Forms Localize**
* cd /var/lib/tomcat7/webapps/orbeon/WEB-INF/resources/apps/blumenbach/config
* Change variables (username, password and hostname) to match eXistdb:
    * Default is orbeon:orbeon@localhost:8081 (username:password@hostname)
    * user must have dba permissions
    
-- in `properties-local.xml` lines 11-14 :

```xml
\<property
    as="xs:anyURI"
    name="oxf.fr.persistence.exist.exist-uri"
    value="http://orbeon:orbeon@localhost:8081/rest/db/orbeon/fr"/>
```

-- also set hostname lines 51-54

```xml
\<property 
    as="xs:string"  
    name="oxf.fr.detail.process.exit.*.*"
    value='navigate("http://localhost:8081/apps/blumenbach/index.html")'/>
```

Orbeon Auth is enabled lines 77-81:

```xml
<property
    as="xs:anyURI"
    processor-name="oxf:page-flow"
    name="authorizer"
    value="/orbeon-auth"/>
```
 
* cp properties-local.xml /var/lib/tomcat7/webapps/orbeon/WEB-INF/resources/config

<br/>
#### Change default eXist REST context
    
* mv /var/lib/tomcat7/webapps/orbeon/WEB-INF/web.xml web.org

Changes are:

-- in  new `web.xml` lines 338-340

```xml
\<servlet-mapping>
    \<servlet-name>exist-rest-servlet</servlet-name>
    \<url-pattern>/rest/*</url-pattern>
\</servlet-mapping>
```

and lines 351-353

```xml
\<servlet-mapping>
    \<servlet-name>exist-xmlrpc-servlet</servlet-name>
    \<url-pattern>/xmlrpc</url-pattern>
\</servlet-mapping>
```
    
* cp web.xml /var/lib/tomcat7/webapps/orbeon/WEB-INF
* service tomcat7 restart

<br/>
#### **Add Form Data to eXist**

* cd /srv/exist2.2/bin
* ./backup.sh -r /var/lib/tomcat7/webapps/orbeon/WEB-INF/resources/apps/blumenbach/exist-db/$backup-date.zip -ouri=xmldb:exist:///xmlrpc -u admin -p password

This creates a new collection `/db/orbeon` with the permissions of the import user.

* **Important** : The user must be a dba and match the user name specified in `properties-local.xml`

Next Step 5: [Add Blumenbach Application Archive] (xar) 