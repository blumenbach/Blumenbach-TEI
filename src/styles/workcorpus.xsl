<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <xsl:processing-instruction name="xml-model">href="./bb-schema-corpus.rnc" type="application/relax-ng-compact-syntax"</xsl:processing-instruction>
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
            <xsl:for-each select="//TEI">
                <xsl:copy-of copy-namespaces="no" select="."/>
            </xsl:for-each>
        </teiCorpus>
    </xsl:template>
</xsl:stylesheet>