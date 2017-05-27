<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="saxon" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="count" select="0" saxon:assignable="yes"/>
    <xsl:template match="/">
        <xsl:for-each select="Bibliographie-1/biblStruct">
            <saxon:assign name="count" select="$count+1"/>
            <xsl:variable name="filename" select="concat(format-number($count, '00000'),'.xml')"/>
            <xsl:value-of select="$filename"/>
            <xsl:result-document href="{$filename}">
                <xsl:processing-instruction name="xml-model">href="./standoff-proposal.rnc" type="application/relax-ng-compact-syntax"</xsl:processing-instruction>
                <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:so="http://standoff.proposal" xml:lang="de-DE">
                    <teiHeader>
                        <fileDesc>
                            <titleStmt>
                                <title type="main">
                                    <xsl:value-of select="./title[@type='meta']"/>
                                </title>
                                <author>
                                    <persName ref="http://viaf.org/viaf/71570755">Blumenbach, Johann Friedrich‏</persName>
                                </author>
                                <editor>
                                    <persName ref="http://viaf.org/viaf/">
                                        <surname/>
                                        <forename/>
                                    </persName>
                                </editor>
                                <respStmt>
                                    <resp key="proj">Projektträger</resp>
                                    <orgName resp="proj">Akademie der Wissenschaften zu Göttingen
                                        <ref target="http://adw-goe.de/"/>
                                    </orgName>
                                </respStmt>
                                <respStmt>
                                    <resp key="enc">Kodiert durch:</resp>
                                    <orgName resp="enc">Bearbeiter des Projekts Johann Friedrich Blumenbach - online</orgName>
                                </respStmt>
                            </titleStmt>
                            <publicationStmt>
                                <publisher/>
                                <idno>
                                    <idno type="URLWeb"/>
                                    <idno type="URLXML">
                                        <xsl:value-of select="$filename"/>
                                    </idno>
                                    <idno type="URLHTML"/>
                                    <idno type="URLText"/>
                                </idno>
                            </publicationStmt>
                            <xsl:if test="note or link">
                                <notesStmt>
                                    <xsl:for-each select="note">
                                        <note type="anm">
                                            <xsl:value-of select="."/>
                                        </note>
                                    </xsl:for-each>
                                    <xsl:if test="link">
                                        <xsl:for-each select="link">
                                            <note type="ref">
                                                <xsl:choose>
                                                    <xsl:when test=".[@type='pdf']">
                                                        <ref type="pdf">
                                                            <xsl:value-of select="."/>
                                                        </ref>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <ref type="html">
                                                            <xsl:value-of select="."/>
                                                        </ref>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </note>
                                        </xsl:for-each>
                                    </xsl:if>
                                </notesStmt>
                            </xsl:if>
                            <sourceDesc>
                                <biblStruct>
                                    <xsl:choose>
                                        <xsl:when test="./title[@level='m']">
                                            <monogr>
                                                <title level="m" type="main">
                                                    <xsl:value-of select="./title[@level='m']"/>
                                                </title>
                                                <xsl:if test="./title[@type='sub']">
                                                    <xsl:for-each select="title[@type='sub']">
                                                        <title level="m" type="sub">
                                                            <xsl:value-of select=".[@type='sub']"/>
                                                        </title>
                                                    </xsl:for-each>
                                                </xsl:if>
                                                <xsl:if test="./title[@type='aut']">
                                                    <title level="m" type="aut">
                                                        <xsl:value-of select="./title[@type='aut']"/>
                                                    </title>
                                                </xsl:if>
                                                <xsl:if test="./title[@type='ed']">
                                                    <title level="m" type="ed">
                                                        <xsl:value-of select="./title[@type='ed']"/>
                                                    </title>
                                                </xsl:if>
                                                <author>
                                                    <persName ref="http://viaf.org/viaf/71570755">Blumenbach, Johann Friedrich‏</persName>
                                                </author>
                                                <xsl:if test="./edition">
                                                    <edition>
                                                        <xsl:value-of select="./edition"/>
                                                    </edition>
                                                </xsl:if>
                                                <xsl:choose>
                                                    <xsl:when test="./editor[@role='translator']">
                                                        <editor role="translator">
                                                            <persName ref="http://viaf.org/viaf">
                                                                <xsl:value-of select="editor"/>
                                                            </persName>
                                                        </editor>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <editor>
                                                            <persName ref="http://viaf.org/viaf">
                                                                <xsl:value-of select="editor"/>
                                                            </persName>
                                                        </editor>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                                <imprint>
                                                    <publisher>
                                                        <name>
                                                            <xsl:value-of select="publisher"/>
                                                        </name>
                                                    </publisher>
                                                    <pubPlace>
                                                        <xsl:value-of select="pubPlace"/>
                                                    </pubPlace>
                                                    <xsl:if test="date[@when]">
                                                        <date type="publication" when="{date/@when}">
                                                            <xsl:value-of select="date"/>
                                                        </date>
                                                    </xsl:if>
                                                </imprint>
                                                <xsl:if test="./biblScope">
                                                    <biblScope>
                                                        <xsl:value-of select="biblScope"/>
                                                    </biblScope>
                                                </xsl:if>
                                            </monogr>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <analytic>
                                                <title level="a" type="main">
                                                    <xsl:value-of select="./title[@level='a']"/>
                                                </title>
                                                <author>
                                                    <persName ref="http://viaf.org/viaf/71570755">Blumenbach, Johann Friedrich‏</persName>
                                                </author>
                                            </analytic>
                                            <monogr>
                                                <xsl:if test="./title[@level='j']">
                                                    <title level="j">
                                                        <xsl:value-of select="./title[@level='j']"/>
                                                    </title>
                                                </xsl:if>
                                                <xsl:if test="./title[@level='ma']">
                                                    <title level="m">
                                                        <xsl:value-of select="./title[@level='ma']"/>
                                                    </title>
                                                </xsl:if>
                                                <xsl:if test="./title[@type='sub']">
                                                    <xsl:for-each select="title[@type='sub']">
                                                        <title level="m" type="sub">
                                                            <xsl:value-of select=".[@type='sub']"/>
                                                        </title>
                                                    </xsl:for-each>
                                                </xsl:if>
                                                <xsl:if test="./title[@type='aut']">
                                                    <title level="m" type="aut">
                                                        <xsl:value-of select="./title[@type='aut']"/>
                                                    </title>
                                                </xsl:if>
                                                <xsl:if test="./title[@type='ed']">
                                                    <title level="m" type="ed">
                                                        <xsl:value-of select="./title[@type='ed']"/>
                                                    </title>
                                                </xsl:if>
                                                <xsl:if test="./edition">
                                                    <edition>
                                                        <xsl:value-of select="./edition"/>
                                                    </edition>
                                                </xsl:if>
                                                <xsl:choose>
                                                    <xsl:when test="./editor[@role='translator']">
                                                        <editor role="translator">
                                                            <persName ref="http://viaf.org/viaf">
                                                                <xsl:value-of select="editor"/>
                                                            </persName>
                                                        </editor>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <editor>
                                                            <persName ref="http://viaf.org/viaf">
                                                                <xsl:value-of select="editor"/>
                                                            </persName>
                                                        </editor>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                                <imprint>
                                                    <publisher>
                                                        <name>
                                                            <xsl:value-of select="publisher"/>
                                                        </name>
                                                    </publisher>
                                                    <pubPlace>
                                                        <xsl:value-of select="pubPlace"/>
                                                    </pubPlace>
                                                    <xsl:if test="date[@when]">
                                                        <date type="publication" when="{date/@when}">
                                                            <xsl:value-of select="date"/>
                                                        </date>
                                                    </xsl:if>
                                                </imprint>
                                                <xsl:if test="./biblScope">
                                                    <biblScope>
                                                        <xsl:value-of select="biblScope"/>
                                                    </biblScope>
                                                </xsl:if>
                                            </monogr>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:if test="./title[@level='s']">
                                        <series>
                                            <xsl:value-of select="title[@level='s']"/>
                                        </series>
                                    </xsl:if>
                                    <xsl:if test="./citedRange">
                                        <citedRange>
                                            <xsl:value-of select="citedRange"/>
                                        </citedRange>
                                    </xsl:if>
                                </biblStruct>
                                <msDesc>
                                    <msIdentifier>
                                        <repository>
                                            <xsl:value-of select="repository"/>
                                        </repository>
                                        <idno>
                                            <xsl:value-of select="idno"/>
                                        </idno>
                                    </msIdentifier>
                                    <physDesc>
                                        <objectDesc>
                                            <supportDesc>
                                                <extent/>
                                            </supportDesc>
                                        </objectDesc>
                                    </physDesc>
                                    <additional>
                                        <adminInfo>
                                            <recordHist>
                                                <source>
                                                    <certainty locus="location">
                                                        <desc>
                                                            <xsl:value-of select="source/certainty"/>
                                                        </desc>
                                                    </certainty>
                                                </source>
                                            </recordHist>
                                            <note>
                                                <p>
                                                    <xsl:for-each select="msDesc">
                                                        <xsl:value-of select="./note"/>
                                                    </xsl:for-each>
                                                </p>
                                            </note>
                                        </adminInfo>
                                    </additional>
                                </msDesc>
                            </sourceDesc>
                        </fileDesc>
                        <profileDesc>
                            <langUsage>
                                <xsl:choose>
                                    <xsl:when test="language[@ident]">
                                        <xsl:for-each select="language">
                                            <language ident="{@ident}"/>
                                        </xsl:for-each>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <language ident="de-DE"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </langUsage>
                            <textDesc>
                                <channel mode="w"/>
                                <constitution type="single"/>
                                <xsl:choose>
                                    <xsl:when test="derivation[@type]">
                                        <xsl:for-each select="derivation">
                                            <derivation type="{@type}"/>
                                        </xsl:for-each>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <derivation/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <domain type="academic"/>
                                <factuality/>
                                <interaction/>
                                <preparedness/>
                                <purpose/>
                            </textDesc>
                            <textClass>
                                <classCode scheme="BiblNr">
                                    <xsl:value-of select="BiblNr"/>
                                </classCode>
                                <xsl:for-each select="category">
                                    <classCode scheme="cat">
                                        <idno>
                                            <xsl:value-of select="@xml:id"/>
                                        </idno>
                                        <xsl:value-of select="./catDesc"/>
                                    </classCode>
                                </xsl:for-each>
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
                            <change>Erstellungsdatum: <xsl:value-of select="current-dateTime()"/>
                            </change>
                        </revisionDesc>
                    </teiHeader>
                    <so:stdf>
                        <so:annotations n="{format-number($count, '00000')}">
                            <spanGrp>
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="concat(concat(name(),'_',generate-id()),'_', format-number($count, '00000'))"/>
                                </xsl:attribute>
                                <xsl:for-each select="annotations/node()/text()">
                                    <span>
                                        <xsl:attribute name="type">
                                            <xsl:value-of select="../name()"/>
                                        </xsl:attribute>
                                        <xsl:choose>
                                            <xsl:when test="../name() = 'title'">
                                                <xsl:attribute name="style">
                                                    <xsl:value-of select="../@level"/>
                                                </xsl:attribute>
                                                <xsl:value-of select="."/>
                                            </xsl:when>
                                            <xsl:when test="../name() = 'reference'">
                                                <xsl:value-of select="format-number(number(.), '00000')"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="."/>
                                            </xsl:otherwise>
                                        </xsl:choose>&#160;</span>
                                </xsl:for-each>
                            </spanGrp>
                        </so:annotations>
                    </so:stdf>
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