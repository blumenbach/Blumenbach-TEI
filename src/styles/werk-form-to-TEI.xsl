<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:so="http://standoff.proposal" extension-element-prefixes="saxon" version="3.0">
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <p>Extracts data from a Werk XForm Instance and outputs it as TEI</p>
        </desc>
    </doc>
    <xsl:template match="form">
        <!-- 
        <xsl:processing-instruction name="xml-model">href="./standoff-proposal.rnc" type="application/relax-ng-compact-syntax"</xsl:processing-instruction>
         -->
        <xsl:variable name="number" select="./profileDesc-textClass/classCode-scheme.BiblNr"/>
        <xsl:variable name="filename" select="concat('jfb_werke_', $number, '.xml')"/>
        <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="de-DE">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title type="meta">
                            <xsl:value-of select="./titleStmt/title-type.meta"/>
                        </title>
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
                        <xsl:for-each select="./notesStmt_refs/grid-39">
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
                        <biblStruct>
                            <xsl:if test="./sourceDesc-analytic/analytic-title-level.a/text()">
                                <analytic>
                                    <title level="a" type="main">
                                        <xsl:value-of select="./sourceDesc-analytic/analytic-title-level.a"/>
                                    </title>
                                </analytic>
                            </xsl:if>
                            <monogr>
                                <xsl:if test="./sourceDesc-analytic/monograph-title-level.j/text()">
                                    <title level="j">
                                        <xsl:value-of select="./sourceDesc-analytic/monograph-title-level.j"/>
                                    </title>
                                </xsl:if>
                                <xsl:if test="./sourceDesc-monograph/title-type.main/text()">
                                    <title level="m" type="main">
                                        <xsl:value-of select="./sourceDesc-monograph/title-type.main"/>
                                    </title>
                                </xsl:if>
                                <xsl:if test="./sourceDesc-monograph/title-type.aut/text()">
                                    <title level="m" type="main">
                                        <xsl:value-of select="./sourceDesc-monograph/title-type.aut"/>
                                    </title>
                                </xsl:if>
                                <xsl:if test="./sourceDesc-monograph/title-type.sub/text()">
                                    <xsl:for-each select="./sourceDesc-monograph/title-type.sub">
                                        <title level="m" type="sub">
                                            <xsl:value-of select="./sourceDesc-monograph/title-type.sub"/>
                                        </title>
                                    </xsl:for-each>
                                </xsl:if>
                                <xsl:if test="./sourceDesc-monograph/edition/text()">
                                    <edition>
                                        <xsl:value-of select="./sourceDesc-monograph/edition"/>
                                    </edition>
                                </xsl:if>
                                <imprint>
                                    <publisher>
                                        <name>
                                            <xsl:value-of select="./sourceDesc-imprint/imprint-publisher-name"/>
                                        </name>
                                    </publisher>
                                    <pubPlace>
                                        <xsl:value-of select="./sourceDesc-imprint/imprint-pubPlace"/>
                                    </pubPlace>
                                    <xsl:variable name="when" select="./sourceDesc-imprint/imprint-date-when"/>
                                    <date type="publication" when="{$when}">
                                        <xsl:value-of select="./sourceDesc-imprint/imprint-date"/>
                                    </date>
                                </imprint>
                                <xsl:if test="./sourceDesc-analytic/monograph-biblScope/text()">
                                    <biblScope>
                                        <xsl:value-of select="./sourceDesc-analytic/monograph-biblScope"/>
                                    </biblScope>
                                </xsl:if>
                            </monogr>
                            <xsl:if test="./sourceDesc-monograph/series/text()">
                                <edition>
                                    <xsl:value-of select="./sourceDesc-monograph/series"/>
                                </edition>
                            </xsl:if>
                            <xsl:if test="./sourceDesc-analytic/citedRange/text()">
                                <citedRange>
                                    <xsl:value-of select="./sourceDesc-analytic/citedRange"/>
                                </citedRange>
                            </xsl:if>
                        </biblStruct>
                        <msDesc>
                            <msIdentifier>
                                <repository>
                                    <xsl:value-of select="./msDesc/msidentifier-repository"/>
                                </repository>
                                <xsl:variable name="idno" select="./msDesc/msidentifier-idno-n"/>
                                <idno n="{$idno}">
                                    <xsl:value-of select="./msDesc/msidentifier-idno"/>
                                </idno>
                            </msIdentifier>
                            <physDesc>
                                <objectDesc>
                                    <supportDesc>
                                        <xsl:if test="./msDesc/extent/text()">
                                            <extent>
                                                <xsl:value-of select="./msDesc/extent"/>
                                                <xsl:if test="./msDesc/dimensions-dim/text()">
                                                    <dimensions>
                                                        <dim>
                                                            <xsl:value-of select="./msDesc/dimensions-dim"/>
                                                        </dim>
                                                    </dimensions>
                                                </xsl:if>
                                            </extent>
                                        </xsl:if>
                                    </supportDesc>
                                </objectDesc>
                            </physDesc>
                            <additional>
                                <adminInfo>
                                    <recordHist>
                                        <source>
                                            <certainty locus="location">
                                                <desc>
                                                    <xsl:if test="not(./msDesc/source-certainty-desc/text())">no autopsy</xsl:if>
                                                </desc>
                                            </certainty>
                                        </source>
                                    </recordHist>
                                    <note>
                                        <p/>
                                    </note>
                                </adminInfo>
                            </additional>
                        </msDesc>
                    </sourceDesc>
                </fileDesc>
                <profileDesc>
                    <langUsage>
                        <language ident="de-DE"/>
                    </langUsage>
                    <textDesc>
                        <channel mode="w"/>
                        <constitution type="single"/>
                        <derivation/>
                        <domain type="academic"/>
                        <factuality/>
                        <interaction/>
                        <preparedness/>
                        <purpose/>
                    </textDesc>
                    <textClass>
                        <xsl:variable name="index" select="./profileDesc-textClass/classCode-n"/>
                        <classCode scheme="BiblNr" n="{$index}">
                            <xsl:value-of select="$number"/>
                        </classCode>
                        <xsl:for-each select="./profileDesc-textClass/categories">
                            <xsl:variable name="classid" select="substring-before(./taxon-lookup, '.')"/>
                            <xsl:variable name="classCode">
                                <xsl:value-of select="concat('cat_',$classid)"/>
                            </xsl:variable>
                            <xsl:element name="xi:include">
                                <xsl:attribute name="href">/db/apps/blumenbach/data/taxons/categories.xml</xsl:attribute>
                                <xsl:attribute name="xpointer">
                                    <xsl:value-of select="$classCode"/>
                                </xsl:attribute>
                            </xsl:element>
                        </xsl:for-each>
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
            <so:stdf>
                <so:annotations n="{$number}">
                    <xsl:for-each select="./stdf-annotations/so-annotations">
                        <xsl:variable name="spangrp" select="./spanGrp"/>
                        <spanGrp>
                            <xsl:value-of select="$spangrp"/>
                        </spanGrp>
                    </xsl:for-each>
                </so:annotations>
            </so:stdf>
            <text>
                <body>
                    <p/>
                </body>
            </text>
        </TEI>
    </xsl:template>
</xsl:stylesheet>