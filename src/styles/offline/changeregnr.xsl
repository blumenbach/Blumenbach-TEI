<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="count" select="0" saxon:assignable="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="node() | @*">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="TEI/teiHeader/fileDesc/publicationStmt/idno/idno[@type='RegNr']"/>
    <xsl:template match="TEI/teiHeader/fileDesc/publicationStmt/idno/idno[@type='URLXML']">
        <xsl:variable name="file" select="."/>
        <idno type="URLXML">
            <xsl:value-of select="concat('jfb_br_', replace($file, '^jfb_br_0{1}([1-9][0-9]*|0)', '$1'))"/>
        </idno>
    </xsl:template>
    <xsl:template match="TEI/teiHeader/profileDesc/textClass/classCode[@scheme='RegNr']">
        <xsl:variable name="regnr" select="."/>
        <classCode scheme="RegNr" n="{concat(replace($regnr, '^0{1}([1-9][0-9]*|0)', '$1'), '.00')}">
            <xsl:choose>
                <xsl:when test="number($regnr) &lt;= 1201">
                    <xsl:value-of select="replace($regnr, '^0{1}([1-9][0-9]*|0)', '$1')"/>
                </xsl:when>
                <xsl:otherwise>00
            </xsl:otherwise>
            </xsl:choose>
        </classCode>
    </xsl:template>
</xsl:stylesheet>