<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:saxon="http://saxon.sf.net/"
    extension-element-prefixes="saxon"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">    
<xsl:output method="xml" indent="yes"/>
<xsl:variable name="count" select="0" saxon:assignable="yes"/>    
<xsl:template match="/">
<xsl:for-each select="TEI/text/body/list/item">
<saxon:assign name="count" select="$count+1"/>
<xsl:variable name="filename" select="concat('jfb_br_',concat(format-number($count, '00000'),'.xml'))"/>
<xsl:value-of select="$filename" />  
<xsl:result-document href="{$filename}">    
      <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="de-DE">
    <teiHeader>
            <fileDesc>
            <titleStmt>                
                       <title type="main"><xsl:value-of select="bibl/note[@type='title']/title"/></title>  
                <author>
                    <persName>
                            <xsl:choose>
                            <xsl:when test="bibl/respStmt/persName[@resp='abs']/forename or bibl/respStmt/persName[@resp='abs']/surname" >
                                <forename><xsl:value-of select="bibl/respStmt/persName[@resp='abs']/forename"/></forename>
                                <surname><xsl:value-of select="bibl/respStmt/persName[@resp='abs']/surname"/></surname>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="bibl/respStmt/persName[@resp='abs']"/>  
                            </xsl:otherwise>    
                            </xsl:choose>                          
                    </persName>
                </author>
                <respStmt>
                    <resp key="proj">Projektträger</resp>
                    <orgName resp="proj">Akademie der Wissenschaften zu Göttingen
                    <ref target="http://adw-goe.de/"/>
                    </orgName>    
                </respStmt>
                <respStmt>
                    <resp key="enc">Kodiert durch:</resp>
                    <orgName xml:id="BjfbO" resp="enc">Bearbeiter des Projekts Johann Friedrich Blumenbach - online</orgName>                    
                </respStmt>
            </titleStmt>
            <publicationStmt>
                <publisher>
                 </publisher>                
                <idno>
                    <idno type="RegNr"><xsl:value-of select="format-number($count, '00000')"/></idno>
                    <idno type="URLXML"><xsl:value-of select="$filename"/></idno>
                    <idno type="URLHTML"></idno>
                    <idno type="URLText"></idno>
                </idno>
            </publicationStmt>
            <notesStmt>
                        <note type="Überlieferung"><xsl:value-of select="bibl/note[@type='Überlieferung']"/></note>
                        <xsl:if test="bibl/note[@type='Drucke']">
                            <note type="Drucke">
                                <xsl:choose>
                                     <xsl:when test="bibl/note[@type='Drucke']/bibl/emph">
                                         <xsl:copy-of copy-namespaces="no" select="bibl/note[@type='Drucke']/bibl"/>
                                         <xsl:text>&#xa;</xsl:text>
                                        <xsl:for-each select="bibl/note[@type='Drucke']/bibl/emph">  
                                            <title level="m" type="bibl"><xsl:value-of select="."/></title>
                                        </xsl:for-each>    
                                     </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:copy-of copy-namespaces="no" select="bibl/note[@type='Drucke']/bibl"/>
                                    </xsl:otherwise>   
                                </xsl:choose>
                            </note>    
                         </xsl:if>                 
                        <note type="Edition">
                            <xsl:choose>
                                 <xsl:when test="bibl/note[@type='Edition']/bibl/edition/emph">                                    
                                  <bibl>
                                    <xsl:copy-of copy-namespaces="no" select="bibl/note[@type='Edition']/bibl/edition"/> 
                                  </bibl> 
                                  <xsl:text>&#xa;</xsl:text>
                                  <xsl:for-each select="bibl/note[@type='Edition']/bibl/edition//emph">   
                                        <title level="m" type="bibl"><xsl:value-of select="."/></title>
                                   </xsl:for-each>   
                                 </xsl:when>
                                <xsl:otherwise>
                                  <xsl:copy-of copy-namespaces="no" select="bibl/note[@type='Edition']/bibl/edition"/>
                                </xsl:otherwise>   
                            </xsl:choose>
                        </note>                
                        <xsl:if test="bibl/note[@type='Werke']">
                            <note type="Werke">
                                <xsl:for-each select="bibl/note[@type='Werke']/bibl/relatedItem">
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
                                        <bibl>
                                            <xsl:copy-of copy-namespaces="no" select="."/>
                                        </bibl>                                                    
                                   </xsl:otherwise>
                                </xsl:choose>
                                </xsl:for-each>    
                            </note>
                        </xsl:if>                 
                        <xsl:if test="bibl/note[@type='ref']">
                        <note type="ref">                             
                                <xsl:for-each select="bibl/note[@type='ref']/ref">
                                    <xsl:if test="./@type='html'">   
                                    <ref type="html">
                                       <xsl:attribute name="xml:id">
                                            <xsl:value-of select="concat(concat(name(),'_',generate-id()),'_', format-number($count, '00000'))"/>
                                       </xsl:attribute>
                                        <xsl:value-of select="./@target"/>                                        
                                    </ref>                                        
                                    </xsl:if>                                
                                    <xsl:if test="./@type='pdf'">
                                        <ref type="pdf">
                                       <xsl:attribute name="xml:id">
                                            <xsl:value-of select="concat(concat(name(),'_',generate-id()),'_', format-number($count, '00000'))"/>
                                       </xsl:attribute>
                                        <xsl:value-of select="./@target"/>                                            
                                        </ref>                                             
                                    </xsl:if>                                            
                                </xsl:for-each>
                                <xsl:for-each select="bibl/note[@type='ref']/rs">
                                    <xsl:if test="./@type='html'">                                        
                                        <rs type="html"><xsl:value-of select="."/></rs>                                                                       
                                    </xsl:if>
                                    <xsl:if test="./@type='pdf'">                                        
                                        <rs type="pdf"><xsl:value-of select="."/></rs>                                                                       
                                    </xsl:if>
                                </xsl:for-each>   
                        </note>
                        </xsl:if> 
                        <xsl:if test="bibl/note[@type='Objekte']">
                            <note type="Objekte">
                               <xsl:choose>
                                    <xsl:when test="bibl/note[@type='Objekte']/rs/emph">
                                        <xsl:copy-of copy-namespaces="no" select="bibl/note[@type='Objekte']/rs"/>
                                        <xsl:text>&#xa;</xsl:text> 
                                        <xsl:for-each select="bibl/note[@type='Objekte']/rs/emph">                                            
                                            <title level="m" type="bibl"><xsl:value-of select="."/></title>
                                         </xsl:for-each>   
                                    </xsl:when> 
                                    <xsl:otherwise>
                                        <xsl:copy-of copy-namespaces="no" select="bibl/note[@type='Objekte']/rs"/>   
                                    </xsl:otherwise>
                               </xsl:choose>
                            </note>
                        </xsl:if>
                        <xsl:if test="bibl/note[@type='Anmerkung']">
                            <note type="Anmerkung">
                               <xsl:choose>
                                    <xsl:when test="bibl/note[@type='Anmerkung']/note/emph">
                                        <xsl:copy-of copy-namespaces="no" select="bibl/note[@type='Anmerkung']/note"/>
                                        <xsl:text>&#xa;</xsl:text> 
                                        <xsl:for-each select="bibl/note[@type='Anmerkung']/note/emph">
                                            <title level="m" type="bibl"><xsl:value-of select="."/></title>
                                         </xsl:for-each>                                        
                                    </xsl:when> 
                                    <xsl:otherwise>
                                        <xsl:copy-of copy-namespaces="no" select="bibl/note[@type='Anmerkung']/note"/>    
                                    </xsl:otherwise>
                               </xsl:choose>                                
                            </note>
                        </xsl:if>              
            </notesStmt>
            <sourceDesc>
                <bibl type="brief"></bibl>
                <biblFull>
                    <titleStmt>
                    <xsl:for-each select="bibl/note[@type='title']">                     
                        <xsl:choose>                             
                                <xsl:when test="./title/emph">
                                	<xsl:copy-of copy-namespaces="no" select="./title"/>                                       
                                    <xsl:text>&#xa;</xsl:text>
                                    <xsl:for-each select="./title/emph">
                                        <title level="m" type="bibl"><xsl:value-of select="."/></title>
                                    </xsl:for-each>    
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:copy-of copy-namespaces="no" select="./title"/>  
                                </xsl:otherwise>                    
                         </xsl:choose>
                    </xsl:for-each>                         
                        <author>
                            <persName>
                                <xsl:choose>
                                <xsl:when test="bibl/respStmt/persName[@resp='abs']/forename or bibl/respStmt/persName[@resp='abs']/surname" >
                                    <forename><xsl:value-of select="bibl/respStmt/persName[@resp='abs']/forename"/></forename>
                                    <surname><xsl:value-of select="bibl/respStmt/persName[@resp='abs']/surname"/></surname>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="bibl/respStmt/persName[@resp='abs']"/>  
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
               <xsl:if test="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='julian-origin']">                
                <calendar>
                     <xsl:attribute name="xml:id">
                         <xsl:value-of select="concat('julian','-',$count)"/>
                     </xsl:attribute>   
                    <p>Julian calendar (including proleptic)</p>
                </calendar>
               </xsl:if>   
                <calendar>
                     <xsl:attribute name="xml:id">
                         <xsl:value-of select="concat('ISO','-',$count)"/>
                     </xsl:attribute>                    
                    <p>ISO 8601 calendar</p>
                </calendar>
            </calendarDesc>
            <creation>
                <persName resp="emp">                
                   <xsl:choose>
                       <xsl:when test="bibl/respStmt/persName[@resp='emp']/forename or bibl/respStmt/persName[@resp='emp']/surname" >
                           <forename><xsl:value-of select="bibl/respStmt/persName[@resp='emp']/forename"/></forename>
                           <surname><xsl:value-of select="bibl/respStmt/persName[@resp='emp']/surname"/></surname>
                       </xsl:when>
                       <xsl:otherwise>
                           <xsl:value-of select="bibl/respStmt/persName[@resp='emp']"/>  
                       </xsl:otherwise>    
                   </xsl:choose> 
                </persName>                
                <origDate>
                <note type="Abfassungsevent"> 
                  <xsl:if test="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin']">
                    <listEvent>
                        <event type="iso-origin" datingMethod="#ISO" sortKey="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin']/@sortKey}" when="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin']/@when}" where="#orgplc-{$count}">
                            <label>Abfassungsdatum</label>
                            <note type="Abfassungsdatum"><date when="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin']/@when}"><xsl:value-of select="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin']/note/date"/>
                            <xsl:if test="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin']/note/date/precision"><precision precision="unknown"/></xsl:if>
                            </date></note> 
                        </event>                                  
                    </listEvent>
                  </xsl:if>                                
                <xsl:if test="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-nb']">
                <listEvent>
                    <event type="iso-origin-nb" datingMethod="#ISO" notBefore="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-nb']/@notBefore}" where="#orgplc-{$count}">
                        <label>Abfassungsdatum (not before):</label>
                        <note type="Abfassungsdatum"><date when="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-nb']/@when}"><xsl:value-of select="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-nb']/note/date"/>
                        <xsl:if test="precision"><precision precision="unknown"/></xsl:if>
                        </date></note>                         
                    </event>
                 </listEvent>                    
                 </xsl:if>                
                 <xsl:if test="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-na']">
                 <listEvent>
                     <event type="iso-origin-na" datingMethod="#ISO" notAfter="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-na']/@notAfter}" where="#orgplc-{$count}">
                         <label>Abfassungsdatum (not after):</label>
                        <note type="Abfassungsdatum"><date when="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-na']/@when}"><xsl:value-of select="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-na']/note/date"/>
                        <xsl:if test="precision"><precision precision="unknown"/></xsl:if>
                        </date></note>                          
                     </event>                     
                 </listEvent>                  
                 </xsl:if>  
                <xsl:if test="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='julian-origin']">
                    <listEvent>
                        <event type="julian-origin" datingMethod="#julian" when="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='julian-origin']/@when}" where="#orgplc">
                            <label>Abfassungsdatum (julian):</label>
                        <note type="Abfassungsdatum"><date when="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='julian-origin']/@when}"><xsl:value-of select="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='julian-origin']/note/date"/>
                        <xsl:if test="precision"><precision precision="unknown"/></xsl:if>
                        </date></note>                            
                        </event>
                    </listEvent>                   
                </xsl:if>
                </note>
                </origDate>
                <placeName type="Abfassungsort">
                     <xsl:attribute name="xml:id">
                         <xsl:value-of select="concat('orgplc','-',$count)"/>
                     </xsl:attribute> 
                    <xsl:value-of select="bibl/placeName[@type='Abfassungsort']"/></placeName>
            </creation>
            <textClass>
                <classCode scheme="RegNr"><xsl:value-of select="./@n"/></classCode>
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
