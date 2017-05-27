<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="count" select="0" saxon:assignable="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="TEI/teiHeader/fileDesc/publicationStmt/idno[@type='URLXML']">
        <xsl:attribute name="type">URLXML</xsl:attribute>
        <xsl:variable name="oldurl" select="substring-before(.,'.')"/>
        <idno>
            <xsl:value-of select="concat($oldurl, '0', '.xml')"/>
        </idno>
        <xsl:apply-templates select="TEI/teiHeader/fileDesc/publicationStmt/idno"/>
    </xsl:template>
</xsl:stylesheet>