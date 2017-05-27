<br/>

#### **Download Latest Build**

To download the latest build of the Blumenbach application:

* git clone https://github.com/christopher-johnson/Blumenbach-TEI.git 
* cd /Blumenbach-TEI/src

In this directory, the builds are incremented.

<br/>
#### **Package Manager**

* The eXist db includes a tool called `Package Manager`
* Assuming that you are able to connect to the eXistdb dashboard, you will see this tool.
* Follow instructions for "Uploading Your Own Packages" in the [Dashboard Documentation] (http://exist-db.org/exist/apps/doc/dashboard.xml)

The Blumenbach Application has two dependencies that should install automatically.

Note that these are described in the `expath-pkg.xml` file:

```xml
\<dependency package="http://exist-db.org/apps/shared"/>
\<dependency package="http://exist-db.org/apps/markdown"/>
```

* While not a dependency, the Blumenbach HTML Documentation application can also be installed. 
    * See `blume-docs-0.1.xar` in the [blume-html-docs](https://github.com/christopher-johnson/blume-html-docs) repository.
        * Note: This is a **large file**

<br/>

Next Step 6: [Configure Blumenbach] (blume-config) 