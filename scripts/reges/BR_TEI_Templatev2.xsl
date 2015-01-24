<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:saxon="http://saxon.sf.net/"
    extension-element-prefixes="saxon"
    version="2.0">
<xsl:output method="xml" indent="yes"/>
<xsl:variable name="count" select="0" saxon:assignable="yes"/>    
<xsl:template match="/">   
      <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="de-DE">
    <teiHeader>
            <fileDesc>
            <titleStmt>
                <title>Regesten zum Briefwechsel Johann Friedrich Blumenbachs</title>
                <editor>Projekt „Johann Friedrich Blumenbach - online“ der Akademie der
                    Wissenschaften zu Göttingen</editor>
                <respStmt>
                    <resp>Projektträger:</resp>
                    <orgName>Akademie der Wissenschaften zu Göttingen</orgName>
                </respStmt>
                <respStmt>
                    <resp>Kodiert durch:</resp>
                    <orgName xml:id="BjfbO">Bearbeiter des Projekts Johann Friedrich Blumenbach -
                        online</orgName>
                </respStmt>
            </titleStmt>
            <publicationStmt>
                <p>XML-Version der vom Projekt „Johann Friedrich Blumenbach - online“ erstellten
                    Regesten zum Briefwechsel Johann Friedrich Blumenbachs, online verfügbar über
                    die Homepage des Projekts:
                    http://www.blumenbach-online.de/fileadmin/wikiuser/Daten_Digitalisierung/
                    Briefregesten/Blumenbach_Briefregesten.html
                </p>
            </publicationStmt>
            <sourceDesc>
                <p>Erstellt auf Basis der im Projekt „Johann Friedrich Blumenbach - online“
                    erstellten Regesten zum Briefwechsel Johann Friedrich Blumenbachs. Online
                    verfügbar über die Homepage des Projekts.</p>  
            </sourceDesc>
        </fileDesc>
        <encodingDesc>
            <p/>
        </encodingDesc>
        <profileDesc>
            <langUsage>
                <language ident="DE-de"></language>
            </langUsage>
            <calendarDesc>
                <calendar xml:id="julian"><p>Julian calendar (including proleptic)</p></calendar>
                <calendar xml:id="ISO"><p>ISO 8601 calendar</p></calendar>
            </calendarDesc>
        </profileDesc>
        <revisionDesc>
            <change who="#BjfbO">Erstellungsdatum: <xsl:value-of select="current-dateTime()"/></change>
        </revisionDesc>
    </teiHeader>
    <text>
        <body>
            <list>                
              <xsl:for-each select="BR/record">
                  <saxon:assign name="count" select="$count+1"/>
                  <xsl:variable name="xmlrecordid" select="concat('briefregesten/',$count,'')" />
                  
                
                  <item xml:id="JFB_BRIEFREGEST_{$count}" n="{RegNr}" sortKey="einfügen"><bibl>
                    <xsl:for-each select="title">
                        <title type="kurzdesc"><xsl:value-of select="substring(., 0, 80)"/>...</title>
                        <note type="langdesc">  
                        <xsl:choose>                             
                                <xsl:when test="./emph"><title level="m" type="sub"><xsl:value-of select="./emph"/></title>
                                    <xsl:value-of select="."/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="."/>  
                                </xsl:otherwise>                    
                         </xsl:choose>
                        </note>    
                    </xsl:for-each>   
                        <respStmt>
                            <resp key="abs">Absender</resp>
                            <persName resp="abs">
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
                        </respStmt>
                        <respStmt>
                            <resp key="emp">Empfänger</resp>
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
                        </respStmt>
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
                        <placeName xml:id="orgplc-{$count}" type="Abfassungsort"><xsl:value-of select="place"/></placeName>
                        <note type="Überlieferung"><xsl:value-of select="biblScope"/></note>
                        <xsl:if test="bibl">
                            <note type="Drucke">
                                <xsl:choose>
                                     <xsl:when test="bibl/emph"> 
                                      <title level="m" type="main"><xsl:value-of select="bibl/emph"/></title>   
                                        <xsl:value-of select="bibl"/>
                                     </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:value-of select="bibl"/>
                                    </xsl:otherwise>   
                                </xsl:choose>
                            </note>    
                         </xsl:if>    
                        <note type="Edition">
                            <xsl:choose>
                                 <xsl:when test="edition/emph"> 
                                  <title level="m" type="main"><xsl:value-of select="edition/emph"/></title>   
                                    <xsl:value-of select="edition"/>
                                 </xsl:when>
                                <xsl:otherwise>
                                  <xsl:value-of select="edition"/>
                                </xsl:otherwise>   
                            </xsl:choose>
                        </note>
                        <xsl:if test="Lit_in_Zusatzdaten">
                            <note type="Werke">
                                <xsl:choose>
                                    <xsl:when test="Lit_in_Zusatzdaten/emph">
                                        <title level="m" type="main"><xsl:value-of select="Lit_in_Zusatzdaten/emph"/></title>
                                        <xsl:value-of select="Lit_in_Zusatzdaten"/>
                                    </xsl:when> 
                                    <xsl:otherwise>
                                        <xsl:value-of select="Lit_in_Zusatzdaten"/>    
                                    </xsl:otherwise>
                                </xsl:choose>    
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
                        <xsl:if test="object">
                            <note type="Objekte">
                               <xsl:choose>
                                    <xsl:when test="object/emph">
                                        <xsl:for-each select="object/emph">
                                            <title level="m" type="main"><xsl:value-of select="."/></title>
                                         </xsl:for-each>   
                                        <xsl:value-of select="object"/>
                                    </xsl:when> 
                                    <xsl:otherwise>
                                        <xsl:value-of select="object"/>    
                                    </xsl:otherwise>
                               </xsl:choose>
                            </note>
                        </xsl:if>    
                        <xsl:if test="note">
                            <note type="Anmerkung">
                               <xsl:choose>
                                    <xsl:when test="note/emph">
                                        <xsl:for-each select="note/emph">
                                            <title level="m" type="main"><xsl:value-of select="."/></title>
                                         </xsl:for-each>   
                                        <xsl:value-of select="note"/>
                                    </xsl:when> 
                                    <xsl:otherwise>
                                        <xsl:value-of select="note"/>    
                                    </xsl:otherwise>
                               </xsl:choose>                                
                                <xsl:value-of select="note"/></note>
                        </xsl:if>    
                        <xsl:if test="relatedItem">
                            <note type="item">
                                <xsl:choose>
                                    <xsl:when test="relatedItem/emph">
                                        <title level="m" type="main"><xsl:value-of select="relatedItem/emph"/></title>
                                    <xsl:value-of select="relatedItem"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="Lit_in_Zusatzdaten"/>    
                                    </xsl:otherwise>
                                </xsl:choose>    
                            </note>
                        </xsl:if> 
                    </bibl>
                </item>
                  
              </xsl:for-each>                
            </list>
        </body>
    </text>
</TEI>

</xsl:template>  
</xsl:stylesheet>
