#### **Install** 
 
* add-apt-repository ppa:webupd8team/java           
* apt-get update              
* apt-get install oracle-java8-installer         
* export JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre/            
* export EXIST_HOME=/srv/exist          
* apt-get upgrade           
* apt-get install ant           
* cd /srv           
* git clone https://github.com/eXist-db/exist.git
* cd /exist               
* git checkout master               
* ./build.sh           
* ./build.sh -f build/scripts/jarsigner.xml      
* lsof -i:8080 (or 8088 if standalone)      
* kill $pid of tomcat (if active)      
* sudo update-alternatives --config java          
* java -version  (should match java8)      
* cd /srv/exist/bin      
* ./startup.sh --jmx 1099 (loads full server, for standalone run ./server.sh instead)        

<br/>
#### **Java Admin Client**

For webstart java admin client: add localhost to site list in oracle config panel

Alternate for webstart admin: Use the client located in /bin/client.sh 

<br/>
#### **Setup Reverse Proxy for Apache**
    
* apt-get install apache2    
* a2enmod proxy_http
    
*** exist.conf ***
    
```xml
    <VirtualHost *:80>      
      ServerName exist.wmflabs.org       
      ServerAlias *.wmflabs.org     
      ProxyRequests off     
      ProxyPreserveHost on      
      ProxyPass / http://localhost:8080/ (or 8088 if standalone)      
      ProxyPassReverse / http://localhost:8080/ (or 8088 if standalone)         
    </VirtualHost>    
      LogLevel debug
```
*** end exist.conf ***
    
* a2ensite exist.conf

<br/>
#### **Starting server from ssh remote**    

* apt-get install tmux    
* tmux    
* $basedir/bin/startup.sh        
* ctrl-B then D  

<br/>
Next Step 2: [Configure eXist] (exist-config) 