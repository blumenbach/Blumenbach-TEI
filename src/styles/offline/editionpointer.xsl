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
    <xsl:template match="//notesStmt/note/bibl/edition">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
        <xsl:variable name="id" select="../../../note[@type='ref']/ref[@type='pdf']/@xml:id"/>
        <xsl:if test="exists($id)">
            <ptr target="{$id}"/>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>