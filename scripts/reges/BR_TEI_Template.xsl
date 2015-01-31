<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:saxon="http://saxon.sf.net/"
    extension-element-prefixes="saxon"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">    
<xsl:output method="xml" indent="yes"/>
<xsl:variable name="count" select="0" saxon:assignable="yes"/>    
<xsl:template match="/">
<xsl:for-each select="BR/record">
<saxon:assign name="count" select="$count+1"/>
<xsl:variable name="filename" select="concat('jfb_briefregesten_',$count,'.xml')" />
<xsl:value-of select="$filename" />  
<xsl:result-document href="{$filename}">    
      <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="de-DE">
    <teiHeader>
            <fileDesc>
            <titleStmt>
                <title type="main"><xsl:value-of select="title"/></title>
                <author>
                    <persName>
                           <forename><xsl:value-of select="author/forename"/></forename>
                           <surname><xsl:value-of select="author/surname"/></surname>
                    </persName>
                </author>
                <editor>
                    <persName>
                        <surname></surname>
                        <forename></forename>
                    </persName>
                </editor>
                <respStmt>
                    <orgName>Akademie der Wissenschaften zu Göttingen</orgName>
                    <resp>
                        <note type="remarkResponsibility">Projektträger</note>
                        <ref target="http://adw-goe.de/"/>
                    </resp>
                </respStmt>
                <respStmt>
                    <resp>Kodiert durch:</resp>
                    <orgName xml:id="BjfbO">Bearbeiter des Projekts Johann Friedrich Blumenbach - online</orgName>                    
                </respStmt>
            </titleStmt>
            <publicationStmt>
                <publisher>
                    <email></email>
                    <orgName></orgName>
                    <address>
                        <addrLine></addrLine>
                        <country></country>
                    </address>
                </publisher>
                <pubPlace></pubPlace> 
                <date></date>
                <availability>
                    <licence>
                        <p></p>
                    </licence>
                </availability>
                <idno>
                    <idno type="RegNr"><xsl:value-of select="$count"/></idno>
                    <idno type="URLXML"><xsl:value-of select="$filename"/></idno>
                    <idno type="URLHTML"></idno>
                    <idno type="URLText"></idno>
                </idno>
            </publicationStmt>
            <notesStmt>
                        <note type="Überlieferung"><xsl:value-of select="biblScope"/></note>
                        <xsl:if test="bibl">
                            <note type="Drucke">
                                <xsl:choose>
                                     <xsl:when test="bibl/emph">
                                         <xsl:copy-of copy-namespaces="no" select="bibl"/>
                                         <xsl:text>&#xa;</xsl:text>
                                        <xsl:for-each select="bibl/emph">  
                                            <title level="m" type="bibl"><xsl:value-of select="."/></title>
                                        </xsl:for-each>    
                                     </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:copy-of copy-namespaces="no" select="bibl"/>
                                    </xsl:otherwise>   
                                </xsl:choose>
                            </note>    
                         </xsl:if>                 
                        <note type="Edition">
                            <xsl:choose>
                                 <xsl:when test="edition/emph">                                    
                                  <bibl>
                                    <xsl:copy-of copy-namespaces="no" select="edition"/> 
                                  </bibl> 
                                  <xsl:text>&#xa;</xsl:text>
                                  <xsl:for-each select="edition/emph">   
                                        <title level="m" type="bibl"><xsl:value-of select="."/></title>
                                   </xsl:for-each>   
                                 </xsl:when>
                                <xsl:otherwise>
                                  <xsl:copy-of copy-namespaces="no" select="edition"/>
                                </xsl:otherwise>   
                            </xsl:choose>
                        </note>                
                        <xsl:if test="relatedItem">
                            <note type="Werke">
                                <xsl:for-each select="relatedItem">
                                <xsl:choose>
                                    <xsl:when test="./bibl/emph">
                                        <bibl>
                                            <xsl:copy-of copy-namespaces="no" select="."/>
                                        </bibl>    
                                        <xsl:text>&#xa;</xsl:text> 
                                        <xsl:for-each select="./bibl/emph">
                                            <title level="m" type="bibl"><xsl:value-of select="."/></title> 
                                        </xsl:for-each>    
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:copy-of copy-namespaces="no" select="./bibl"/>    
                                    </xsl:otherwise>
                                </xsl:choose>
                                </xsl:for-each>    
                            </note>
                        </xsl:if>                 
                        <xsl:if test="ref">
                        <note type="ref">
                               <xsl:attribute name="xml:id">
                                    <xsl:value-of select="concat(name(),'_',generate-id())"/>
                               </xsl:attribute>
                                        <xsl:for-each select="ref">
                                            <xsl:if test="not(@type)">   
                                            <ref type="html" target="{@target}"></ref>
                                            </xsl:if>                                
                                            <xsl:if test="@type">
                                                <ref type="pdf" target="{@target}"></ref>    
                                            </xsl:if>  
                                        </xsl:for-each>
                                        <xsl:for-each select="link">
                                            <xsl:if test="not(./emph)">                                        
                                                <rs type="html"><xsl:value-of select="."/></rs>                                                                       
                                            </xsl:if>
                                            <xsl:if test="./emph">                                        
                                                <rs type="pdf"><xsl:value-of select="."/></rs>                                                                       
                                            </xsl:if>
                                        </xsl:for-each>   
                        </note>
                        </xsl:if> 
                        <xsl:if test="rs">
                            <note type="Objekte">
                               <xsl:choose>
                                    <xsl:when test="rs/emph">
                                        <xsl:copy-of copy-namespaces="no" select="rs"/>
                                        <xsl:text>&#xa;</xsl:text> 
                                        <xsl:for-each select="rs/emph">                                            
                                            <title level="m" type="bibl"><xsl:value-of select="."/></title>
                                         </xsl:for-each>   
                                    </xsl:when> 
                                    <xsl:otherwise>
                                        <xsl:copy-of copy-namespaces="no" select="rs"/>   
                                    </xsl:otherwise>
                               </xsl:choose>
                            </note>
                        </xsl:if>
                        <xsl:if test="note">
                            <note type="Anmerkung">
                               <xsl:choose>
                                    <xsl:when test="note/emph">
                                        <xsl:copy-of copy-namespaces="no" select="note"/>
                                        <xsl:text>&#xa;</xsl:text> 
                                        <xsl:for-each select="note/emph">
                                            <title level="m" type="bibl"><xsl:value-of select="."/></title>
                                         </xsl:for-each>                                        
                                    </xsl:when> 
                                    <xsl:otherwise>
                                        <xsl:copy-of copy-namespaces="no" select="note"/>    
                                    </xsl:otherwise>
                               </xsl:choose>                                
                            </note>
                        </xsl:if>              
            </notesStmt>
            <sourceDesc>
                <bibl type="brief"></bibl>
                <biblFull>
                    <titleStmt>
                    <xsl:for-each select="title">                     
                        <xsl:choose>                             
                                <xsl:when test="./emph">
                                	<xsl:copy-of copy-namespaces="no" select="."/>                                       
                                    <xsl:text>&#xa;</xsl:text>
                                    <xsl:for-each select="./emph">
                                        <title level="m" type="bibl"><xsl:value-of select="."/></title>
                                    </xsl:for-each>    
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:copy-of copy-namespaces="no" select="."/>  
                                </xsl:otherwise>                    
                         </xsl:choose>
                    </xsl:for-each>                         
                        <author>
                            <persName ref="http://d-nb.info/gnd/">
                                <xsl:choose>
                                <xsl:when test="author/forename or author/surname" >
                                    <forename><xsl:value-of select="author/forename"/></forename>
                                    <surname><xsl:value-of select="author/surname"/></surname>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="author"/>  
                                </xsl:otherwise>    
                                </xsl:choose>  
                            </persName>
                        </author>
                    </titleStmt>
                    <publicationStmt>
                        <publisher><name></name></publisher>
                        <pubPlace></pubPlace>
                        <date type="publication"></date>
                    </publicationStmt>
                </biblFull>                
                <msDesc>
                    <msIdentifier>
                    </msIdentifier>
                    <physDesc>
                        <typeDesc>
                            <p></p>
                        </typeDesc>
                    </physDesc>
                </msDesc>
            </sourceDesc>
        </fileDesc>
        <profileDesc>
            <langUsage>
                <language ident="de-DE"></language>
            </langUsage>
            <calendarDesc>
               <xsl:if test="julian">                
                <calendar xml:id="julian-{$count}">
                    <p>Julian calendar (including proleptic)</p>
                </calendar>
               </xsl:if>   
                <calendar xml:id="ISO-{$count}">
                    <p>ISO 8601 calendar</p>
                </calendar>
            </calendarDesc>
            <creation>
                <persName resp="emp">                
                   <xsl:choose>
                       <xsl:when test="receiver/forename or receiver/surname" >
                           <forename><xsl:value-of select="receiver/forename"/></forename>
                           <surname><xsl:value-of select="receiver/surname"/></surname>
                       </xsl:when>
                       <xsl:otherwise>
                           <xsl:value-of select="receiver"/>  
                       </xsl:otherwise>    
                   </xsl:choose> 
                </persName>                
                <origDate>
                <note type="Abfassungsevent"> 
              <xsl:if test="altdate">
                <listEvent>
                    <event type="iso-origin" datingMethod="#ISO" sortKey="{altdate}" when="{altdate}" where="#orgplc-{$count}">
                        <label>Abfassungsdatum</label>
                        <note type="Abfassungsdatum"><date when="{altdate}"><xsl:value-of select="date"/>
                        <xsl:if test="precision"><precision precision="unknown"/></xsl:if>
                        </date></note> 
                    </event>                                  
                </listEvent>
                </xsl:if>
                <xsl:if test="notbefore">
                <listEvent>
                    <event type="iso-origin" datingMethod="#ISO" sortKey="{notbefore}" notBefore="{notbefore}" where="#orgplc-{$count}">
                        <label>Abfassungsdatum (not before):</label>
                        <note type="Abfassungsdatum"><date when="{notbefore}"><xsl:value-of select="date"/>
                        <xsl:if test="precision"><precision precision="unknown"/></xsl:if>
                        </date></note>                         
                    </event>
                 </listEvent>                    
                 </xsl:if>                
                 <xsl:if test="notafter">
                 <listEvent>
                     <event type="iso-origin" datingMethod="#ISO" sortKey="{notafter}" notAfter="{notafter}" where="#orgplc-{$count}">
                         <label>Abfassungsdatum (not after):</label>
                        <note type="Abfassungsdatum"><date when="{notafter}"><xsl:value-of select="date"/>
                        <xsl:if test="precision"><precision precision="unknown"/></xsl:if>
                        </date></note>                          
                     </event>                     
                 </listEvent>                  
                 </xsl:if>  
                <xsl:if test="julian">
                    <listEvent>
                        <event type="julian-origin" datingMethod="#julian" when="{julian}" where="#orgplc">
                            <label>Abfassungsdatum (julian):</label>
                        <note type="Abfassungsdatum"><date when="{julian}"><xsl:value-of select="date"/>
                        <xsl:if test="precision"><precision precision="unknown"/></xsl:if>
                        </date></note>                            
                        </event>
                    </listEvent>                   
                </xsl:if>
                </note>
                </origDate>
                <placeName xml:id="orgplc-{$count}" type="Abfassungsort"><xsl:value-of select="place"/></placeName>
            </creation>
            <textClass>
                <classCode scheme="RegNr"><xsl:value-of select="RegNr"/></classCode>
                <classCode scheme="anchor"><xsl:value-of select="anchor"/></classCode>
                <classCode scheme=""></classCode>
            </textClass>
        </profileDesc>
        <encodingDesc>
            <projectDesc>
                <p>Projekt „Johann Friedrich Blumenbach - online“ der Akademie der
                   Wissenschaften zu Göttingen
                   CH Johnson Werkvertrag 2014-11-01 to 2015-06-01</p>
            </projectDesc>  
        </encodingDesc>
        <revisionDesc>
            <change who="#BjfbO">Erstellungsdatum: <xsl:value-of select="current-dateTime()"/></change>
        </revisionDesc>        
    </teiHeader>
        <text>
            <body>
                <p></p>
            </body>
        </text>
</TEI>
</xsl:result-document>
</xsl:for-each>
</xsl:template>  
</xsl:stylesheet>
