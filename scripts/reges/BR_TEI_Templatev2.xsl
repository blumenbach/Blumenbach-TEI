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
                <calendar xml:id="julian">
                    <p>Julian calendar (including proleptic)</p>
                </calendar>
                <calendar xml:id="ISO">
                    <p>ISO 8601 calendar</p>
                </calendar>
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
                        <note type="langdesc"><p><xsl:value-of select="."/></p></note>
                    </xsl:for-each>   
                        <respStmt>
                            <resp key="abs">Absender</resp>
                            <persName>
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
                            <persName>
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
                        <note type="Überlieferung"><p><xsl:value-of select="biblScope"/></p></note>
                        <xsl:if test="bibl">
                            <note type="Drucke"><p><xsl:value-of select="bibl"/></p></note>
                        </xsl:if>    
                        <note type="Edition"><xsl:value-of select="Zusatzdaten"/><xsl:value-of select="edition"/>
                            <xsl:for-each select="ref">
                                <xsl:if test="@type">
                                    <ref target="{@target}"></ref>
                                </xsl:if>
                        </xsl:for-each>
                        </note>
                        <xsl:if test="Lit_in_Zusatzdaten">
                            <note type="Werke"><xsl:value-of select="Lit_in_Zusatzdaten"/></note> 
                        </xsl:if>    
                        <xsl:for-each select="ref">
                            <xsl:if test="not(@type)">
                                <note type="ref"><ref target="{@target}"></ref></note>
                            </xsl:if>
                        </xsl:for-each>
                        
                        <xsl:if test="object">
                            <note type="Objekte"><p><xsl:value-of select="object"/></p></note>
                        </xsl:if>    
                        <xsl:if test="note">
                            <note type="Anmerkung"><p><xsl:value-of select="note"/></p></note>
                        </xsl:if>    
                        <xsl:if test="relatedItem">
                            <note type="item"><xsl:value-of select="relatedItem"/></note>
                        </xsl:if>
                        <xsl:if test="span">
                            <note type="span"><xsl:value-of select="span"/></note>
                        </xsl:if>
                        <xsl:if test="link">
                           <note><ref type="link"><xsl:value-of select="link"/></ref></note>
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
