<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="saxon" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <p>Extracts data from a Brief XForm Instance and outputs it as TEI</p>
        </desc>
    </doc>
    <xsl:template match="form">
        <xsl:variable name="number" select="./textClass/classCode-scheme.RegNr-idno"/>
        <xsl:variable name="filename" select="concat('jfb_br_', $number, '.xml')"/>
        <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="de-DE">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title type="meta">
                            <xsl:value-of select="./titleStmt/title-type.meta"/>
                        </title>
                        <author>
                            <persName>
                                <forename>
                                    <xsl:value-of select="./sourceDesc/author-forename"/>
                                </forename>
                                <surname>
                                    <xsl:value-of select="./sourceDesc/author-surname"/>
                                </surname>
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
                        <publisher/>
                        <idno>
                            <xsl:value-of select="$filename"/>
                        </idno>
                    </publicationStmt>
                    <notesStmt>
                        <note type="Überlieferung">
                            <xsl:value-of select="./notesStmt/note-type.Überlieferung"/>
                        </note>
                        <note type="Drucke">
                            <bibl>
                                <xsl:value-of select="./notesStmt/note-type.Drucke"/>
                            </bibl>
                        </note>
                        <note type="Edition">
                            <bibl>
                                <edition>
                                    <xsl:value-of select="./notesStmt/note-type.Edition"/>
                                </edition>
                            </bibl>
                        </note>
                        <note type="Werke">
                            <bibl>
                                <relatedItem>
                                    <bibl>
                                        <xsl:value-of select="./notesStmt/note-type.Werke"/>
                                    </bibl>
                                </relatedItem>
                            </bibl>
                        </note>
                        <note type="Objekte">
                            <rs type="obj">
                                <xsl:value-of select="./notesStmt/note-type.Objekte-rs"/>
                            </rs>
                        </note>
                        <note type="Anmerkung">
                            <note>
                                <xsl:value-of select="./notesStmt/note-type.Anmerkung-note"/>
                            </note>
                        </note>
                        <xsl:for-each select="./notesStmt_refs/grid-26">
                            <note type="ref">
                                <xsl:variable name="ref" select="./note-type.ref"/>
                                <xsl:variable name="rs" select="./note-type.ref-rs"/>
                                <xsl:variable name="uid" select="generate-id()"/>
                                <xsl:variable name="xml_id" select="concat('ref','_',$uid,'_',$number)"/>
                                <xsl:choose>
                                    <xsl:when test="./ref-type = 'pdf'">
                                        <ref>
                                            <xsl:attribute name="type">pdf</xsl:attribute>
                                            <xsl:attribute name="xml:id">
                                                <xsl:value-of select="$xml_id"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="$ref"/>
                                        </ref>
                                        <rs type="pdf">
                                            <xsl:value-of select="$rs"/>
                                        </rs>
                                    </xsl:when>
                                    <xsl:when test="./ref-type = 'html'">
                                        <ref>
                                            <xsl:attribute name="type">html</xsl:attribute>
                                            <xsl:attribute name="xml:id">
                                                <xsl:value-of select="$xml_id"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="$ref"/>
                                        </ref>
                                        <rs type="html">
                                            <xsl:value-of select="$rs"/>
                                        </rs>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <ref>
                                            <xsl:attribute name="type">other</xsl:attribute>
                                            <xsl:attribute name="xml:id">
                                                <xsl:value-of select="$xml_id"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="$ref"/>
                                        </ref>
                                        <rs type="other">
                                            <xsl:value-of select="$rs"/>
                                        </rs>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </note>
                        </xsl:for-each>
                    </notesStmt>
                    <sourceDesc>
                        <bibl type="brief"/>
                        <biblFull>
                            <titleStmt>
                                <title type="source">
                                    <xsl:value-of select="./sourceDesc/title-type.source"/>
                                </title>
                                <author>
                                    <persName>
                                        <forename>
                                            <xsl:value-of select="./sourceDesc/author-forename"/>
                                        </forename>
                                        <surname>
                                            <xsl:value-of select="./sourceDesc/author-surname"/>
                                        </surname>
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
                            <msIdentifier/>
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
                        <calendar style="ISO 8601">
                            <p>Julian calendar (including proleptic)</p>
                        </calendar>
                        <calendar style="ISO 8601">
                            <p>Gregorian calendar</p>
                        </calendar>
                    </calendarDesc>
                    <creation>
                        <persName resp="emp">
                            <forename>
                                <xsl:value-of select="./profileDesc/creation-persName-forename"/>
                            </forename>
                            <surname>
                                <xsl:value-of select="./profileDesc/creation-persName-surname"/>
                            </surname>
                        </persName>
                        <xsl:variable name="where" select="concat('orgplc_', $number)"/>
                        <origDate>
                            <note type="Abfassungsevent">
                                <xsl:if test="./profileDesc/event-type.origin-when">
                                    <xsl:variable name="when" select="./profileDesc/event-type.origin-when"/>
                                    <listEvent>
                                        <event type="origin" sortKey="{$when}" when="{$when}" where="#{$where}">
                                            <tei:label xmlns:tei="http://www.tei-c.org/ns/1.0">Abfassungsdatum</tei:label>
                                            <note type="Abfassungsdatum">
                                                <date when="{$when}">
                                                    <xsl:value-of select="./profileDesc/event-type.origin-note-type.abfassungsdatum-date"/>
                                                </date>
                                            </note>
                                        </event>
                                    </listEvent>
                                </xsl:if>
                                <xsl:if test="./profileDesc/event-type.julian-origin-when/text()">
                                    <xsl:variable name="when" select="./profileDesc/event-type.julian-origin-when"/>
                                    <listEvent>
                                        <event type="julian-origin" sortKey="{$when}" when="{$when}" where="#{$where}">
                                            <tei:label xmlns:tei="http://www.tei-c.org/ns/1.0">Abfassungsdatum</tei:label>
                                            <note type="Abfassungsdatum">
                                                <date when="{$when}">
                                                    <xsl:value-of select="./profileDesc/event-type.julian-origin-note-type.abfassungsdatum-date"/>
                                                </date>
                                            </note>
                                        </event>
                                    </listEvent>
                                </xsl:if>
                            </note>
                        </origDate>
                        <placeName>
                            <xsl:attribute name="type">Abfassungsort</xsl:attribute>
                            <xsl:attribute name="xml:id">
                                <xsl:value-of select="$where"/>
                            </xsl:attribute>
                            <xsl:value-of select="./profileDesc/placeName-type.Abfassungsort"/>
                        </placeName>
                    </creation>
                    <textClass>
                        <xsl:variable name="index" select="./textClass/classCode-n"/>
                        <classCode scheme="RegNr" n="{$index}">
                            <idno>
                                <xsl:value-of select="$number"/>
                            </idno>
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
    </xsl:template>
</xsl:stylesheet>