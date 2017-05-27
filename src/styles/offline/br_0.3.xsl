<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="de-DE">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Regesten zum Briefwechsel Johann Friedrich Blumenbachs</title>
                        <editor>Projekt „Johann Friedrich Blumenbach - online“ der Akademie der
                    Wissenschaften zu Göttingen</editor>
                        <respStmt>
                            <resp key="proj">Projektträger:</resp>
                            <orgName resp="proj">Akademie der Wissenschaften zu Göttingen</orgName>
                        </respStmt>
                        <respStmt>
                            <resp key="enc">Kodiert durch:</resp>
                            <orgName resp="enc">Bearbeiter des Projekts Johann Friedrich Blumenbach - online</orgName>
                        </respStmt>
                    </titleStmt>
                    <publicationStmt>
                        <p>XML-Version der vom Projekt „Johann Friedrich Blumenbach - online“ erstellten
                    Regesten zum Briefwechsel Johann Friedrich Blumenbachs, online verfügbar über
                    die Homepage des Projekts:
                    http://www.blumenbach-online.de/fileadmin/wikiuser/Daten_Digitalisierung/
                    Briefregesten/Blumenbach_Briefregesten.html</p>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Erstellt auf Basis der im Projekt „Johann Friedrich Blumenbach - online“
                   erstellten Regesten zum Briefwechsel Johann Friedrich Blumenbachs. Online
                   verfügbar über die Homepage des Projekts.</p>
                    </sourceDesc>
                </fileDesc>
                <profileDesc>
                    <langUsage>
                        <language ident="DE-de"/>
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
                <encodingDesc>
                    <projectDesc>
                        <p>Projekt „Johann Friedrich Blumenbach - online“ der Akademie der
                   Wissenschaften zu Göttingen
                   CH Johnson Werkvertrag 2014-11-01 to 2015-06-01</p>
                    </projectDesc>
                </encodingDesc>
                <revisionDesc>
                    <change>Erstellungsdatum: <xsl:value-of select="current-dateTime()"/>
                    </change>
                </revisionDesc>
            </teiHeader>
            <text>
                <body>
                    <list>
                        <xsl:for-each select="//TEI/teiHeader">
                            <xsl:variable name="regnr" select="fileDesc/publicationStmt/idno/idno[@type='RegNr']"/>
                            <xsl:element name="item">
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="concat(name(),'_',generate-id())"/>
                                </xsl:attribute>
                                <xsl:attribute name="n">
                                    <xsl:value-of select="$regnr"/>
                                </xsl:attribute>
                                <bibl>
                                    <xsl:for-each select="fileDesc/sourceDesc/biblFull/titleStmt/title[@type='source']">
                                        <xsl:choose>
                                            <xsl:when test="./emph">
                                                <note type="title">
                                                    <xsl:copy-of copy-namespaces="no" select="."/>
                                                </note>
                                                <xsl:text/>
                                                <xsl:for-each select="./emph">
                                                    <title level="m" type="bibl">
                                                        <xsl:value-of select="."/>
                                                    </title>
                                                </xsl:for-each>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <note type="title">
                                                    <title type="source">
                                                        <xsl:value-of select="."/>
                                                    </title>
                                                </note>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>
                                    <respStmt>
                                        <resp key="abs">Absender</resp>
                                        <persName resp="abs">
                                            <xsl:choose>
                                                <xsl:when test="fileDesc/titleStmt/author/persName/forename or fileDesc/titleStmt/author/persName/surname">
                                                    <forename>
                                                        <xsl:value-of select="fileDesc/titleStmt/author/persName/forename"/>
                                                    </forename>
                                                    <surname>
                                                        <xsl:value-of select="fileDesc/titleStmt/author/persName/surname"/>
                                                    </surname>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="fileDesc/titleStmt/author/persName"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </persName>
                                    </respStmt>
                                    <respStmt>
                                        <resp key="emp">Empfänger</resp>
                                        <persName resp="emp">
                                            <xsl:choose>
                                                <xsl:when test="profileDesc/creation/persName/forename or profileDesc/creation/persName/surname">
                                                    <forename>
                                                        <xsl:value-of select="profileDesc/creation/persName/forename"/>
                                                    </forename>
                                                    <surname>
                                                        <xsl:value-of select="profileDesc/creation/persName/surname"/>
                                                    </surname>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="profileDesc/creation/persName"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </persName>
                                    </respStmt>
                                    <note type="Abfassungsevent">
                                        <xsl:if test="profileDesc/creation/origDate/note/listEvent/event[@type='origin']">
                                            <listEvent>
                                                <event type="iso-origin" datingMethod="#ISO" sortKey="{profileDesc/creation/origDate/note/listEvent/event[@type='origin']/@sortKey}" when="{profileDesc/creation/origDate/note/listEvent/event[@type='origin']/@when}" where="#orgplc-{$regnr}">
                                                    <tei:label xmlns:tei="http://www.tei-c.org/ns/1.0">Abfassungsdatum</tei:label>
                                                    <note type="Abfassungsdatum">
                                                        <date when="{profileDesc/creation/origDate/note/listEvent/event[@type='origin']/@when}">
                                                            <xsl:value-of select="profileDesc/creation/origDate/note/listEvent/event[@type='origin']/note/date"/>
                                                            <xsl:if test="profileDesc/creation/origDate/note/listEvent/event[@type='origin']/note/date/precision">
                                                                <precision precision="unknown"/>
                                                            </xsl:if>
                                                        </date>
                                                    </note>
                                                </event>
                                            </listEvent>
                                        </xsl:if>
                                        <xsl:if test="profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-nb']">
                                            <listEvent>
                                                <event type="iso-origin-nb" datingMethod="#ISO" notBefore="{profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-nb']/@notBefore}" where="#orgplc-{$regnr}">
                                                    <tei:label xmlns:tei="http://www.tei-c.org/ns/1.0">Abfassungsdatum (not before):</tei:label>
                                                    <note type="Abfassungsdatum">
                                                        <date when="{profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-nb']/@notBefore}">
                                                            <xsl:value-of select="profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-nb']/note/date"/>
                                                            <xsl:if test="profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-nb']/note/date/precision">
                                                                <precision precision="unknown"/>
                                                            </xsl:if>
                                                        </date>
                                                    </note>
                                                </event>
                                            </listEvent>
                                        </xsl:if>
                                        <xsl:if test="profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-na']">
                                            <listEvent>
                                                <event type="iso-origin-na" datingMethod="#ISO" notAfter="{profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-na']/@notAfter}" where="#orgplc-{$regnr}">
                                                    <tei:label xmlns:tei="http://www.tei-c.org/ns/1.0">Abfassungsdatum (not after):</tei:label>
                                                    <note type="Abfassungsdatum">
                                                        <date when="{profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-na']/@notAfter}">
                                                            <xsl:value-of select="profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-na']/note/date"/>
                                                            <xsl:if test="profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-na']/note/date/precision">
                                                                <precision precision="unknown"/>
                                                            </xsl:if>
                                                        </date>
                                                    </note>
                                                </event>
                                            </listEvent>
                                        </xsl:if>
                                        <xsl:if test="profileDesc/creation/origDate/note/listEvent/event[@type='julian-origin']">
                                            <listEvent>
                                                <event type="julian-origin" datingMethod="#julian" when="{profileDesc/creation/origDate/note/listEvent/event[@type='julian-origin']/@when}" where="#orgplc-{$regnr}">
                                                    <tei:label xmlns:tei="http://www.tei-c.org/ns/1.0">Abfassungsdatum (julian):</tei:label>
                                                    <note type="Abfassungsdatum">
                                                        <date when="{profileDesc/creation/origDate/note/listEvent/event[@type='julian-origin']/@when}">
                                                            <xsl:value-of select="profileDesc/creation/origDate/note/listEvent/event[@type='julian-origin']/note/date"/>
                                                            <xsl:if test="profileDesc/creation/origDate/note/listEvent/event[@type='julian-origin']/note/date/precision">
                                                                <precision precision="unknown"/>
                                                            </xsl:if>
                                                        </date>
                                                    </note>
                                                </event>
                                            </listEvent>
                                        </xsl:if>
                                    </note>
                                    <xsl:element name="placeName">
                                        <xsl:attribute name="xml:id">
                                            <xsl:value-of select="concat('orgplc-', $regnr)"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="type">Abfassungsort</xsl:attribute>
                                        <xsl:value-of select="profileDesc/creation/placeName"/>
                                    </xsl:element>
                                    <note type="Überlieferung">
                                        <xsl:value-of select="fileDesc/notesStmt/note[@type='Überlieferung']"/>
                                    </note>
                                    <xsl:if test="fileDesc/notesStmt/note[@type='Drucke']">
                                        <note type="Drucke">
                                            <xsl:choose>
                                                <xsl:when test="fileDesc/notesStmt/note[@type='Drucke']/bibl/emph">
                                                    <xsl:copy-of copy-namespaces="no" select="fileDesc/notesStmt/note[@type='Drucke']/bibl"/>
                                                    <xsl:text/>
                                                    <xsl:for-each select="fileDesc/notesStmt/note[@type='Drucke']/bibl/emph">
                                                        <title level="m" type="bibl">
                                                            <xsl:value-of select="."/>
                                                        </title>
                                                    </xsl:for-each>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:copy-of copy-namespaces="no" select="fileDesc/notesStmt/note[@type='Drucke']/bibl"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </note>
                                    </xsl:if>
                                    <xsl:if test="fileDesc/notesStmt/note[@type='Edition']">
                                        <note type="Edition">
                                            <xsl:choose>
                                                <xsl:when test="fileDesc/notesStmt/note/bibl/edition/emph">
                                                    <bibl>
                                                        <xsl:copy-of copy-namespaces="no" select="fileDesc/notesStmt/note/bibl/edition"/>
                                                    </bibl>
                                                    <xsl:text/>
                                                    <xsl:for-each select="fileDesc/notesStmt/note/bibl/edition/emph">
                                                        <title level="m" type="bibl">
                                                            <xsl:value-of select="."/>
                                                        </title>
                                                    </xsl:for-each>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:copy-of copy-namespaces="no" select="fileDesc/notesStmt/note/bibl/edition"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </note>
                                    </xsl:if>
                                    <xsl:if test="fileDesc/notesStmt/note[@type='Werke']">
                                        <note type="Werke">
                                            <xsl:choose>
                                                <xsl:when test="fileDesc/notesStmt/note[@type='Werke']/bibl/relatedItem">
                                                    <xsl:for-each select="fileDesc/notesStmt/note[@type='Werke']/bibl/relatedItem">
                                                        <xsl:choose>
                                                            <xsl:when test="./bibl/emph">
                                                                <bibl>
                                                                    <xsl:copy-of copy-namespaces="no" select="."/>
                                                                </bibl>
                                                                <xsl:text/>
                                                                <xsl:for-each select="./bibl/emph">
                                                                    <title level="m" type="bibl">
                                                                        <xsl:value-of select="."/>
                                                                    </title>
                                                                </xsl:for-each>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:copy-of copy-namespaces="no" select="./bibl"/>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:for-each>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:for-each select="fileDesc/notesStmt/note[@type='Werke']/bibl">
                                                        <bibl>
                                                            <relatedItem>
                                                                <xsl:copy-of copy-namespaces="no" select="."/>
                                                            </relatedItem>
                                                        </bibl>
                                                    </xsl:for-each>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </note>
                                    </xsl:if>
                                    <xsl:if test="fileDesc/notesStmt/note[@type='ref']">
                                        <note type="ref">
                                            <xsl:for-each select="fileDesc/notesStmt/note/ref">
                                                <xsl:copy-of copy-namespaces="no" select="."/>
                                            </xsl:for-each>
                                            <xsl:for-each select="fileDesc/notesStmt/note/rs">
                                                <xsl:copy-of copy-namespaces="no" select="."/>
                                            </xsl:for-each>
                                        </note>
                                    </xsl:if>
                                    <xsl:if test="fileDesc/notesStmt/note[@type='Objekte']">
                                        <note type="Objekte">
                                            <xsl:choose>
                                                <xsl:when test="fileDesc/notesStmt/note/rs[@type='obj']/emph">
                                                    <xsl:copy-of copy-namespaces="no" select="fileDesc/notesStmt/note/rs[@type='obj']"/>
                                                    <xsl:text/>
                                                    <xsl:for-each select="fileDesc/notesStmt/note/rs[@type='obj']/emph">
                                                        <title level="m" type="bibl">
                                                            <xsl:value-of select="."/>
                                                        </title>
                                                    </xsl:for-each>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:copy-of copy-namespaces="no" select="fileDesc/notesStmt/note/rs[@type='obj']"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </note>
                                    </xsl:if>
                                    <xsl:if test="fileDesc/notesStmt/note[@type='Anmerkung']">
                                        <note type="Anmerkung">
                                            <xsl:choose>
                                                <xsl:when test="fileDesc/notesStmt/note[@type='Anmerkung']/note/emph">
                                                    <xsl:copy-of copy-namespaces="no" select="fileDesc/notesStmt/note[@type='Anmerkung']/note"/>
                                                    <xsl:text/>
                                                    <xsl:for-each select="fileDesc/notesStmt/note[@type='Anmerkung']/note/emph">
                                                        <title level="m" type="bibl">
                                                            <xsl:value-of select="."/>
                                                        </title>
                                                    </xsl:for-each>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:copy-of copy-namespaces="no" select="fileDesc/notesStmt/note[@type='Anmerkung']/note"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </note>
                                    </xsl:if>
                                </bibl>
                            </xsl:element>
                        </xsl:for-each>
                    </list>
                </body>
            </text>
        </TEI>
    </xsl:template>
</xsl:stylesheet>