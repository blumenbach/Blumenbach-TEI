<br/>
#### **Orbeon Wiki** 
Reference the [Orbeon Wiki] (https://github.com/orbeon/orbeon-forms/wiki) for comprehensive information about all aspects of configuration.

<br/>
#### **Change eXist db Port**
* If running from the same machine, and eXist running with jetty, change jetty default port from 8080 (e.g. 8081) 

-- in `/srv/exist2.2/tools/jetty/etc/jetty.xml`

```xml
\<Set name="port">
    \<SystemProperty name="jetty.port" default="8081"/>
\</Set>
```
<br/>
#### **Install Oracle Java8**
* add-apt-repository ppa:webupd8team/java
* apt-get update
* apt-get install oracle-java8-installer

<br/>
#### **Install Tomcat 7**
* apt-get install tomcat7

<br/>
#### **Download and Install Orbeon Forms 4.9**
* cd /tmp
* wget https://github.com/orbeon/orbeon-forms/releases/download/tag-release-4.9-ce/orbeon-4.9.0.201505052329-CE.zip 
* unzip orbeon-4.9.0.201505052329-CE.zip
* mv orbeon-4.9.0.201505052329-CE orbeon
* cp ./orbeon/orbeon.war /var/lib/tomcat7/webapps
* cd /var/lib/tomcat7/webapps
* mkdir orbeon
* cd orbeon
* jar xvf orbeon.war

<br/>
#### **Add Blumenbach Application**
* cd /var/lib/tomcat7/webapps/orbeon/WEB-INF/resources/apps
* git clone https://github.com/christopher-johnson/orbeon-bb.git blumenbach

<br/>
#### **Deploy orbeon-auth.war from Blumenbach repository**

* Authorization in Orbeon Forms is discussed [here] (https://github.com/orbeon/orbeon-forms/wiki/Controller-~-Authorization-of-Pages-and-Services)
* The Blumenbach Application uses the basic authentication methods provided by the simple authorization service `orbeon-auth`

To enable this:

* cp /var/lib/tomcat7/webapps/orbeon/WEB-INF/resources/apps/blumenbach/src/orbeon-auth.war /var/lib/tomcat7/webapps/
* cd /var/lib/tomcat7/webapps/
* jar xvf orbeon-auth.war

Note that this requires **localization** described in [Localize Installation] (localize)

<br/>
#### **Setup Reverse Proxy for Apache**
    
* apt-get install apache2    
* a2enmod proxy_http 
   
*** orbeon.conf ***
    
```xml
    <VirtualHost *:80>      
          ServerName orbeon.wmflabs.org       
          ServerAlias *.wmflabs.org     
          ProxyRequests off     
          ProxyPreserveHost on      
          ProxyPass / http://localhost:8080/      
          ProxyPassReverse / http://localhost:8080/          
    </VirtualHost>    
      LogLevel debug
```
*** end orbeon.conf ***
    
* a2ensite orbeon.conf

<br/>

#### **Localize**

Next Step 4: [Localize Installation] (orbeon-localize)