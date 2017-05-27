<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="count" select="0" saxon:assignable="yes"/>
    <xsl:template match="/">
        <xsl:for-each select="TEI/text/body/list/item">
            <saxon:assign name="count" select="$count+1"/>
            <xsl:variable name="filename" select="concat('jfb_br_',concat(format-number($count, '00000'),'.xml'))"/>
            <xsl:value-of select="$filename"/>
            <xsl:result-document href="{$filename}">
                <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="de-DE">
                    <teiHeader>
                        <fileDesc>
                            <titleStmt>
                                <title type="main">
                                    <xsl:value-of select="bibl/note[@type='title']/title"/>
                                </title>
                                <author>
                                    <persName>
                                        <xsl:choose>
                                            <xsl:when test="bibl/respStmt/persName[@resp='abs']/forename or bibl/respStmt/persName[@resp='abs']/surname">
                                                <forename>
                                                    <xsl:value-of select="bibl/respStmt/persName[@resp='abs']/forename"/>
                                                </forename>
                                                <surname>
                                                    <xsl:value-of select="bibl/respStmt/persName[@resp='abs']/surname"/>
                                                </surname>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="bibl/respStmt/persName[@resp='abs']"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </persName>
                                </author>
                                <respStmt>
                                    <resp key="proj">Projektträger</resp>
                                    <orgName resp="proj">
                                        <name>Akademie der Wissenschaften zu Göttingen</name>
                                        <ref target="http://adw-goe.de/"/>
                                    </orgName>
                                </respStmt>
                                <respStmt>
                                    <resp key="enc">Kodiert durch:</resp>
                                    <persName resp="enc">Christopher Hanna Johnson</persName>
                                </respStmt>
                            </titleStmt>
                            <publicationStmt>
                                <publisher>
                 </publisher>
                                <idno>
                                    <idno type="RegNr">
                                        <xsl:value-of select="format-number($count, '00000')"/>
                                    </idno>
                                    <idno type="URLXML">
                                        <xsl:value-of select="$filename"/>
                                    </idno>
                                    <idno type="URLHTML"/>
                                    <idno type="URLText"/>
                                </idno>
                            </publicationStmt>
                            <notesStmt>
                                <note type="Überlieferung">
                                    <xsl:value-of select="bibl/note[@type='Überlieferung']"/>
                                </note>
                                <xsl:if test="bibl/note[@type='Drucke']">
                                    <note type="Drucke">
                                        <xsl:choose>
                                            <xsl:when test="bibl/note[@type='Drucke']/bibl/emph">
                                                <xsl:copy-of copy-namespaces="no" select="bibl/note[@type='Drucke']/bibl"/>
                                                <xsl:text>
</xsl:text>
                                                <xsl:for-each select="bibl/note[@type='Drucke']/bibl/emph">
                                                    <title level="m" type="bibl">
                                                        <xsl:value-of select="."/>
                                                    </title>
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
                                            <xsl:text>
</xsl:text>
                                            <xsl:for-each select="bibl/note[@type='Edition']/bibl/edition//emph">
                                                <title level="m" type="bibl">
                                                    <xsl:value-of select="."/>
                                                </title>
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
                                                    <xsl:text>
</xsl:text>
                                                    <xsl:for-each select="./bibl/emph">
                                                        <title level="m" type="bibl">
                                                            <xsl:value-of select="."/>
                                                        </title>
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
                                            <xsl:copy-of copy-namespaces="no" select="."/>
                                        </xsl:for-each>
                                        <xsl:for-each select="bibl/note[@type='ref']/rs">
                                            <xsl:copy-of copy-namespaces="no" select="."/>
                                        </xsl:for-each>
                                    </note>
                                </xsl:if>
                                <xsl:if test="bibl/note[@type='Objekte']">
                                    <note type="Objekte">
                                        <xsl:choose>
                                            <xsl:when test="bibl/note[@type='Objekte']/rs/emph">
                                                <xsl:copy-of copy-namespaces="no" select="bibl/note[@type='Objekte']/rs"/>
                                                <xsl:text>
</xsl:text>
                                                <xsl:for-each select="bibl/note[@type='Objekte']/rs/emph">
                                                    <title level="m" type="bibl">
                                                        <xsl:value-of select="."/>
                                                    </title>
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
                                                <xsl:text>
</xsl:text>
                                                <xsl:for-each select="bibl/note[@type='Anmerkung']/note/emph">
                                                    <title level="m" type="bibl">
                                                        <xsl:value-of select="."/>
                                                    </title>
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
                                <bibl type="brief"/>
                                <biblFull>
                                    <titleStmt>
                                        <xsl:for-each select="bibl/note[@type='title']">
                                            <xsl:choose>
                                                <xsl:when test="./title/emph">
                                                    <xsl:copy-of copy-namespaces="no" select="./title"/>
                                                    <xsl:text>
</xsl:text>
                                                    <xsl:for-each select="./title/emph">
                                                        <title level="m" type="bibl">
                                                            <xsl:value-of select="."/>
                                                        </title>
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
                                                    <xsl:when test="bibl/respStmt/persName[@resp='abs']/forename or bibl/respStmt/persName[@resp='abs']/surname">
                                                        <forename>
                                                            <xsl:value-of select="bibl/respStmt/persName[@resp='abs']/forename"/>
                                                        </forename>
                                                        <surname>
                                                            <xsl:value-of select="bibl/respStmt/persName[@resp='abs']/surname"/>
                                                        </surname>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="bibl/respStmt/persName[@resp='abs']"/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </persName>
                                        </author>
                                    </titleStmt>
                                    <publicationStmt>
                                        <publisher>
                                            <name/>
                                        </publisher>
                                        <pubPlace/>
                                        <date type="publication"/>
                                    </publicationStmt>
                                </biblFull>
                                <msDesc>
                                    <msIdentifier>
                    </msIdentifier>
                                    <physDesc>
                                        <typeDesc>
                                            <p/>
                                        </typeDesc>
                                    </physDesc>
                                </msDesc>
                            </sourceDesc>
                        </fileDesc>
                        <profileDesc>
                            <langUsage>
                                <language ident="de-DE"/>
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
                                        <xsl:when test="bibl/respStmt/persName[@resp='emp']/forename or bibl/respStmt/persName[@resp='emp']/surname">
                                            <forename>
                                                <xsl:value-of select="bibl/respStmt/persName[@resp='emp']/forename"/>
                                            </forename>
                                            <surname>
                                                <xsl:value-of select="bibl/respStmt/persName[@resp='emp']/surname"/>
                                            </surname>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="bibl/respStmt/persName[@resp='emp']"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </persName>
                                <origDate>
                                    <note type="Abfassungsevent">
                                        <xsl:if test="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='origin']">
                                            <listEvent>
                                                <event type="iso-origin" datingMethod="#ISO" sortKey="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='origin']/@sortKey}" when="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='origin']/@when}" where="#orgplc-{$count}">
                                                    <tei:label xmlns:tei="http://www.tei-c.org/ns/1.0">Abfassungsdatum</tei:label>
                                                    <note type="Abfassungsdatum">
                                                        <date when="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='origin']/@when}">
                                                            <xsl:value-of select="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='origin']/note/date"/>
                                                            <xsl:if test="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='origin']/note/date/precision">
                                                                <precision precision="unknown"/>
                                                            </xsl:if>
                                                        </date>
                                                    </note>
                                                </event>
                                            </listEvent>
                                        </xsl:if>
                                        <xsl:if test="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-nb']">
                                            <listEvent>
                                                <event type="iso-origin-nb" datingMethod="#ISO" notBefore="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-nb']/@notBefore}" where="#orgplc-{$count}">
                                                    <tei:label xmlns:tei="http://www.tei-c.org/ns/1.0">Abfassungsdatum (not before):</tei:label>
                                                    <note type="Abfassungsdatum">
                                                        <date when="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-nb']/@notBefore}">
                                                            <xsl:value-of select="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-nb']/note/date"/>
                                                            <xsl:if test="precision">
                                                                <precision precision="unknown"/>
                                                            </xsl:if>
                                                        </date>
                                                    </note>
                                                </event>
                                            </listEvent>
                                        </xsl:if>
                                        <xsl:if test="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-na']">
                                            <listEvent>
                                                <event type="iso-origin-na" datingMethod="#ISO" notAfter="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-na']/@notAfter}" where="#orgplc-{$count}">
                                                    <tei:label xmlns:tei="http://www.tei-c.org/ns/1.0">Abfassungsdatum (not after):</tei:label>
                                                    <note type="Abfassungsdatum">
                                                        <date when="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-na']/@notAfter}">
                                                            <xsl:value-of select="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='iso-origin-na']/note/date"/>
                                                            <xsl:if test="precision">
                                                                <precision precision="unknown"/>
                                                            </xsl:if>
                                                        </date>
                                                    </note>
                                                </event>
                                            </listEvent>
                                        </xsl:if>
                                        <xsl:if test="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='julian-origin']">
                                            <listEvent>
                                                <event type="julian-origin" datingMethod="#julian" when="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='julian-origin']/@when}" where="#orgplc">
                                                    <tei:label xmlns:tei="http://www.tei-c.org/ns/1.0">Abfassungsdatum (julian):</tei:label>
                                                    <note type="Abfassungsdatum">
                                                        <date when="{bibl/note[@type='Abfassungsevent']/listEvent/event[@type='julian-origin']/@when}">
                                                            <xsl:value-of select="bibl/note[@type='Abfassungsevent']/listEvent/event[@type='julian-origin']/note/date"/>
                                                            <xsl:if test="precision">
                                                                <precision precision="unknown"/>
                                                            </xsl:if>
                                                        </date>
                                                    </note>
                                                </event>
                                            </listEvent>
                                        </xsl:if>
                                    </note>
                                </origDate>
                                <placeName type="Abfassungsort">
                                    <xsl:attribute name="xml:id">
                                        <xsl:value-of select="concat('orgplc','-',$count)"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="bibl/placeName[@type='Abfassungsort']"/>
                                </placeName>
                            </creation>
                            <textClass>
                                <classCode scheme="RegNr" xml:id="cat_">
                                    <xsl:value-of select="./@n"/>
                                </classCode>
                            </textClass>
                        </profileDesc>
                        <encodingDesc>
                            <projectDesc>
                                <p>Projekt „Johann Friedrich Blumenbach - online“ der Akademie der Wissenschaften zu Göttingen</p>
                            </projectDesc>
                        </encodingDesc>
                        <revisionDesc>
                            <change>Erstellungsdatum: <xsl:value-of select="current-dateTime()"/>
                            </change>
                        </revisionDesc>
                    </teiHeader>
                    <text>
                        <body>
                            <p/>
                        </body>
                    </text>
                </TEI>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>