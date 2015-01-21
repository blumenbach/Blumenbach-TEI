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
                <calendar>
                    <p>Julian calendar (including proleptic)</p>
                </calendar>
                <calendar>
                    <p>ISO 8601 calendar</p>
                </calendar>
            </calendarDesc>
        </profileDesc>
        <revisionDesc>
            <change who="#BjfbO">Erstellungsdatum: 2015-01-12 (Mo, 12. Jan 2015)</change>
        </revisionDesc>
    </teiHeader>
    <text>
        <body>
            <list>
              <xsl:for-each select="BR/record">
                  <saxon:assign name="count" select="$count+1"/>
                  <xsl:variable name="xmlrecordid" select="concat('briefregesten/',$count,'')" />
                <item xml:id="JFB_BRIEFREGEST_{RegNr}" n="{RegNr}" sortKey="einfügen"><bibl>
                        <title type="desc"><xsl:value-of select="title"/></title>
                        <respStmt>
                            <resp>Absender</resp>
                            <persName><xsl:value-of select="author"/></persName>
                        </respStmt>
                        <respStmt>
                            <resp>Empfänger</resp>
                            <persName><xsl:value-of select="receiver"/></persName>
                        </respStmt>
                <xsl:if test="altdate">
                <listEvent>
                    <event type="iso-origin" datingMethod="#ISO-{$count}" sortKey="{altdate}" when="{altdate}" where="#orgplc-{$count}">
                        <date type="Abfassungsdatum" when="{altdate}"><xsl:value-of select="date"/></date>
                    </event>                                  
                </listEvent>  
                </xsl:if>
                <xsl:if test="notbefore">
                <listEvent>
                    <event type="iso-origin" datingMethod="#ISO-{$count}" sortKey="{notbefore}" notBefore="{notbefore}" where="#orgplc-{$count}">
                         <date type="Abfassungsdatum" when="{notbefore}"><xsl:value-of select="date"/></date>
                    </event>
                 </listEvent>    
                 </xsl:if>
                
                 <xsl:if test="notafter">
                 <listEvent>
                     <event type="iso-origin" datingMethod="#ISO-{$count}" sortKey="{notafter}" notAfter="{notafter}" where="#orgplc-{$count}">
                          <date type="Abfassungsdatum" when="{notafter}"><xsl:value-of select="date"/></date>
                     </event>
                 </listEvent>
                 </xsl:if>  
                <xsl:if test="julian">
                    <listEvent>
                        <event type="julian-origin" datingMethod="#julian-{$count}" when="{julian}" where="#orgplc">
                            <date type="Abfassungsdatum" when="{julian}"><xsl:value-of select="date"/></date>
                        </event>
                    </listEvent>
                </xsl:if>  
                        <placeName type="Abfassungsort"><xsl:value-of select="place"/></placeName>
                        <note type="Überlieferung"><xsl:value-of select="biblScope"/></note>
                        <note type="Drucke"><xsl:value-of select="bibl"/></note>
                        <note type="Edition"><xsl:value-of select="Zusatzdaten"/><xsl:value-of select="edition"/>
                        <xsl:for-each select="ref">
                            <xsl:if test ="@type">
                            <ref type="pdf" target="{@target}"></ref>
                        </xsl:if>
                        </xsl:for-each>
                        </note>
                        <note type="Werke"><xsl:value-of select="Lit_in_Zusatzdaten"/>
                        <xsl:for-each select="ref">
                            <xsl:if test ="not(@type)">
                            <ref target="{@target}"></ref>
                        </xsl:if>
                        </xsl:for-each>
                        </note>
                        <note type="Objekte"><xsl:value-of select="object"/></note>
                        <note type="Anmerkung"><xsl:value-of select="bibl"/></note>
                        <note> <rs type="item"><xsl:value-of select="relatedItem"/></rs></note>
                        <note><rs type="span"><xsl:value-of select="span"/></rs></note>
                        <note><rs type="link"><xsl:value-of select="link"/></rs></note>
                    </bibl>
                </item>
              </xsl:for-each>
            </list>
        </body>
    </text>
</TEI>

</xsl:template>  
</xsl:stylesheet>
