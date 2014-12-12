<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes" method="xml"/>
    <xsl:template match="/">
                    <xsl:apply-templates mode="transform">
                        <xsl:with-param name="repository" select="data/briefregnr"/>
                    </xsl:apply-templates>
    </xsl:template>
        
    
    <xsl:template match="text()" mode="transform" priority="2.5">
        <xsl:param name="repository" />
        <xsl:variable name="this" select="." />
        <xsl:variable name="term" select="$repository//title[contains($this,./text())]" />
        <xsl:choose>
            <xsl:when test="count($term) > 0">
                <xsl:value-of select="substring-before(., $term/text())"/>
                <xsl:variable name="termTitle" select="$term/@abbr" />
                <abbr title="{$termTitle}"><xsl:value-of select="$term/text()"/></abbr>
                <xsl:value-of select="substring-after($this, $term/text())"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="node()" mode="transform" priority="2">
        <xsl:param name="repository" />
        <xsl:copy>
            <xsl:apply-templates mode="transform">
                <xsl:with-param name="repository" select="$repository"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
    
</xsl:stylesheet>