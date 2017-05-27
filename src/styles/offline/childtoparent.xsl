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
    <xsl:template match="//note[@type='ref']">
        <xsl:copy copy-namespaces="no">
            <xsl:attribute name="type">ref</xsl:attribute>
            <xsl:apply-templates select="child::node()[not(self::ref[@type='html'])]"/>
        </xsl:copy>
        <xsl:apply-templates select="ref[@type='html']"/>
    </xsl:template>
</xsl:stylesheet>