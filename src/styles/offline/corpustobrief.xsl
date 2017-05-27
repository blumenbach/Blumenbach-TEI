<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="count" select="0" saxon:assignable="yes"/>
    <xsl:template match="/">
        <xsl:for-each select="teiCorpus/TEI">
            <xsl:variable name="regnr">
                <xsl:value-of select="teiHeader/profileDesc/textClass/classCode[@scheme='RegNr']/idno"/>
            </xsl:variable>
            <xsl:variable name="filename">
                <xsl:value-of select="concat('jfb_br_', $regnr, '.xml')"/>
            </xsl:variable>
            <xsl:value-of select="$filename"/>
            <xsl:result-document href="{$filename}">
                <xsl:copy-of copy-namespaces="no" select="."/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>