<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:variable name="count" select="0" saxon:assignable="yes"/>
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="TEI/teiHeader/fileDesc/notesStmt/note[@type='ref']">
        <xsl:for-each select="./ref">
            <saxon:assign name="count" select="$count+1"/>
            <xsl:variable name="seq" select="$count"/>
            <xsl:variable name="id" select="./@xml:id"/>
            <note type="ref">
                <ref>
                    <xsl:attribute name="type">
                        <xsl:value-of select="./@type"/>
                    </xsl:attribute>
                    <xsl:attribute name="n">
                        <xsl:value-of select="$seq"/>
                    </xsl:attribute>
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="$id"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </ref>
                <rs>
                    <xsl:attribute name="type">
                        <xsl:value-of select="./@type"/>
                    </xsl:attribute>
                    <xsl:value-of select="../rs"/>
                </rs>
            </note>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>