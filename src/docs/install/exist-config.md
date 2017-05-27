<br/>
#### **Context**
* The default eXist URL context appends /exist and /app before the application context.  
* While the Blumenbach application is context relative, the API integration assumes that the /exist context **is removed**

To remove the /exist context and run from root, edit this file.

`/tools/jetty/etc/jetty.xml`

-- change line 69

```xml 
\<Set name="contextPath">/exist</Set>
```
to 

```xml
\<Set name="contextPath">/</Set>
```

* Optional:
To remove the /apps context, edit this file:

`/webapp/WEB-INF/controller-config.xml`

-- change line 59

```xml
\<root pattern="/apps" path="xmldb:exist:///db/apps"/>
```
 to
  
```xml
\<root pattern="/" path="xmldb:exist:///db/apps"/>
```
<br/>
#### **Security**

Servlets are configured in `/webapp/WEB-INF/web.xml`

The Blumenbach application uses the REST interface without restriction.
  
In order for this to be enabled,
 
-- change lines 123-125

```xml 
\<init-param>
    \<param-name>useDefaultUser</param-name>
    \<param-value>true</param-value>
\</init-param>
```
to

```xml        
\<init-param>
    \<param-name>hidden</param-name>
    \<param-value>false</param-value>
\</init-param>
```

<br/>
#### **Transformation Factory**

The configuration for web applications is in `/conf.xml`

The Blumenbach application **requires** XSLT 2.0.  To use the XSLT 2.0 Saxon Transformer Factory:

-- ensure that the Saxon Transformer is enabled:

```xml
\<transformer class="net.sf.saxon.TransformerFactoryImpl" caching="yes">
    \<attribute name="http://saxon.sf.net/feature/version-warning" value="false" type="boolean"/>
\</transformer>
```

<br/>
#### **Indexer**

The configuration for the indexer is in `/conf.xml`

The `preserve-whitespace-mixed-content` attribute **must** be changed from "no" to "yes" in order to see the Oxygen generated documentation code with indentation

```xml
    <indexer caseSensitive="yes" index-depth="5" preserve-whitespace-mixed-content="yes"
        stemming="no" suppress-whitespace="none"
        tokenizer="org.exist.storage.analysis.SimpleTokenizer" track-term-freq="yes">
```

<br/>
#### **RESTXQ**

The RESTXQ servlet is identified in the Jetty `/webapp/WEB-INF/web.xml` file with these lines:

```xml
\<servlet>
    \<servlet-name>RestXqServlet</servlet-name>
    \<servlet-class>org.exist.extensions.exquery.restxq.impl.RestXqServlet</servlet-class>
\</servlet>
```

The modules are enabled in the eXist `/conf.xml` with these lines:

```xml
 \<module uri="http://exquery.org/ns/restxq" class="org.exist.extensions.exquery.restxq.impl.xquery.RestXqModule"/>
 \<module uri="http://exquery.org/ns/restxq/exist" class="org.exist.extensions.exquery.restxq.impl.xquery.exist.ExistRestXqModule"/>
```

The restxq.registry file is located in `/webapp/WEB-INF/data` and is supposed to be auto-generated with the rest:register-module functions called from the <finish>post-install.xql</finish> section of the repo.xml file on deployment.

* Note: This does not work at the moment, however, because of a namespace prefix collision ('rest') between the RestXqModule and the ExistRestXqModule.

Workaround is to manually create the restxq.registry and add functions as required.

* See Step 6: [Blumenbach Application Configuration] (blume-config)

    **After installation**  
        * copy the restxq.registry file from the root of the Blumenbach application to `/webapp/WEB-INF/data`

Changes require a restart of the server.

* For information on using the RESTXQ API see [API Usage Guide] (api/)

<br/>

Next Step 3: [Install Orbeon] (orbeon) 