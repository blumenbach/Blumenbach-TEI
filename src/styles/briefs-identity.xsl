<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:function name="functx:trim" as="xs:string">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:sequence select="replace(replace($arg,'\s+$',''),'^\s+','')"/>
    </xsl:function>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <p>Identity Template</p>
        </desc>
    </doc>
    <xsl:template match="node() | @*">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//emph">
        <em>
            <xsl:value-of select="."/>
        </em>
    </xsl:template>
    <xsl:template match="//ptr">
        <xsl:variable name="ref" select="id(./@target)"/>
        <xsl:variable name="label" select="id(./@target)/following-sibling::rs/text()"/>
        <xsl:variable name="token" select="tokenize($ref, '/')[last()]"/>
        <xsl:choose>
            <xsl:when test="contains(id(./@target), 'http')">
                <xsl:choose>
                    <xsl:when test="id(./@target)/following-sibling::rs/text()">
                        &#160;<a href="{$ref}">&#160;[<xsl:value-of select="functx:trim($label)"/>]&#160;</a>
                    </xsl:when>
                    <xsl:otherwise>
                        &#160;<a href="{$ref}">&#160;[<xsl:value-of select="functx:trim($token)"/>]&#160;</a>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="id(./@target)/following-sibling::rs/text()">
                       &#160;<a href="/exist/apps/blumenbach/{$ref}" target="_blank">&#160;[<xsl:value-of select="functx:trim($label)"/>]&#160;</a>
                    </xsl:when>
                    <xsl:otherwise>
                       &#160;<a href="/exist/apps/blumenbach/{$ref}" target="_blank">&#160;[<xsl:value-of select="functx:trim($token)"/>]&#160;</a>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>