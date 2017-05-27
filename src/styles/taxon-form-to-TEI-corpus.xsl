<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:so="http://standoff.proposal" extension-element-prefixes="saxon" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <teiCorpus xmlns="http://www.tei-c.org/ns/1.0" xml:lang="de-DE">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Johann Friedrich Blumenbach. Bibliographie seiner Schriften</title>
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
                        <p/>
                    </publicationStmt>
                    <sourceDesc>
                        <p/>
                    </sourceDesc>
                </fileDesc>
                <profileDesc>
                    <langUsage>
                        <language ident="DE-de"/>
                    </langUsage>
                    <calendarDesc>
                        <calendar style="ISO 8601">
                            <p>Julian calendar (including proleptic)</p>
                        </calendar>
                        <calendar style="ISO 8601">
                            <p>Gregorian calendar</p>
                        </calendar>
                    </calendarDesc>
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
            <xsl:for-each select="//form">
                <xsl:variable name="number" select="./profileDesc-textClass/classCode-scheme.taxon"/>
                <xsl:variable name="filename" select="concat('jfb_taxon_', $number, '.xml')"/>
                <TEI>
                    <teiHeader>
                        <fileDesc>
                            <titleStmt>
                                <xsl:variable name="n" select="./profileDesc-textClass/classCode-biblNr.n"/>
                                <title type="taxon" n="{$n}">
                                    <xsl:value-of select="./titleStmt/title-type.taxon"/>
                                </title>
                                <respStmt>
                                    <resp key="proj">Projektträger</resp>
                                    <orgName resp="proj">Akademie der Wissenschaften zu Göttingen
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
                            <sourceDesc>
                                <biblStruct>
                                    <monogr>
                                        <title level="j">
                                            <xsl:value-of select="./sourceDesc-monograph/title-level.j"/>
                                        </title>
                                        <imprint>
                                            <publisher>
                                                <name>
                                                    <xsl:value-of select="./sourceDesc-imprint/name"/>
                                                </name>
                                            </publisher>
                                            <pubPlace>
                                                <xsl:value-of select="./sourceDesc-imprint/pubPlace"/>
                                            </pubPlace>
                                            <xsl:variable name="when" select="./sourceDesc-imprint/date-when"/>
                                            <date type="publication" when="{$when}">
                                                <xsl:value-of select="./sourceDesc-imprint/date"/>
                                            </date>
                                        </imprint>
                                    </monogr>
                                </biblStruct>
                                <msDesc>
                                    <msIdentifier>
                                        <repository>
                                            <xsl:value-of select="./msDesc/repository"/>
                                        </repository>
                                        <xsl:variable name="idno" select="./msDesc/repository-idno-n"/>
                                        <idno n="{$idno}">
                                            <xsl:value-of select="./msDesc/repository-idno"/>
                                        </idno>
                                    </msIdentifier>
                                    <physDesc>
                                        <objectDesc>
                                            <supportDesc>
                                                <extent>
                                                    <dimensions>
                                                        <dim/>
                                                    </dimensions>
                                                </extent>
                                            </supportDesc>
                                        </objectDesc>
                                    </physDesc>
                                    <additional>
                                        <adminInfo>
                                            <recordHist>
                                                <source>
                                                    <certainty locus="location">
                                                        <desc/>
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
                            <textClass>
                                <xsl:variable name="index" select="./profileDesc-textClass/classCode-biblNr.n"/>
                                <classCode scheme="BiblNr" n="{$index}"/>
                                <classCode scheme="cat">
                                    <idno>
                                        <xsl:value-of select="./profileDesc-textClass/classCode-scheme.cat-idno"/>
                                    </idno>
                                    <rs>
                                        <xsl:value-of select="./profileDesc-textClass/classCode-scheme.cat-text"/>
                                    </rs>
                                </classCode>
                                <classCode scheme="taxon">
                                    <xsl:value-of select="$number"/>
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
            </xsl:for-each>
        </teiCorpus>
    </xsl:template>
</xsl:stylesheet>