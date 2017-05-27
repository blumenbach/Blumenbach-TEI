<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="saxon" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="count" select="0" saxon:assignable="yes"/>
    <xsl:template match="/">
        <xsl:for-each select="categories/classCode">
            <saxon:assign name="count" select="$count+1"/>
            <xsl:variable name="filename" select="concat('jfb_werke_taxon_',concat(format-number($count, '000'),'.xml'))"/>
            <xsl:value-of select="$filename"/>
            <xsl:result-document href="{$filename}">
                <xsl:variable name="level">
                    <xsl:value-of select="./@level"/>
                </xsl:variable>
                <xsl:variable name="idno">
                    <xsl:value-of select="./idno"/>
                </xsl:variable>
                <xsl:variable name="name">
                    <xsl:value-of select="./text()"/>
                </xsl:variable>
                <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="de-DE">
                    <teiHeader>
                        <fileDesc>
                            <titleStmt>
                                <title type="taxon" level="{$level}">
                                    <xsl:value-of select="$name"/>
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
                                <p/>
                            </publicationStmt>
                            <sourceDesc>
                                <bibl/>
                            </sourceDesc>
                        </fileDesc>
                        <profileDesc>
                            <langUsage>
                                <language ident="de-DE"/>
                            </langUsage>
                            <textClass>
                                <classCode scheme="BiblNr" n="00000.{$count}"/>
                                <classCode scheme="cat">
                                    <idno>
                                        <xsl:value-of select="$idno"/>
                                    </idno>
                                    <xsl:value-of select="$name"/>
                                </classCode>
                            </textClass>
                        </profileDesc>
                        <encodingDesc>
                            <projectDesc>
                                <p>Projekt „Johann Friedrich Blumenbach - online“ der Akademie der Wissenschaften zu Göttingen</p>
                            </projectDesc>
                        </encodingDesc>
                        <revisionDesc>
                            <change>Erstellungsdatum: 2015-04-23T00:34:05.553+02:00</change>
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