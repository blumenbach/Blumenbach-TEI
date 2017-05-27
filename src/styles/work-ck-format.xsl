<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:so="http://standoff.proposal" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="count" select="0" saxon:assignable="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:function name="functx:substring-after-match" as="xs:string?">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="regex" as="xs:string"/>
        <xsl:sequence select="replace($arg,concat('^.*?',$regex),'')"/>
    </xsl:function>
    <xsl:function name="functx:trim" as="xs:string">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:sequence select="replace(replace($arg,'\s+$',''),'^\s+','')"/>
    </xsl:function>
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="lb">
        <xsl:element name="br" namespace="http://www.w3.org/1999/xhtml"/>
    </xsl:template>
    <xsl:template match="span[@type='eintrag']">
        <xsl:copy>
            <xsl:attribute name="class">eintrag</xsl:attribute>
            <xsl:copy-of select="."/>
            <xsl:apply-templates select="lb"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="span[@type='anmerkung']">
        <xsl:copy>
            <xsl:attribute name="class">kommentar</xsl:attribute>
            <xsl:copy-of select="."/>
            <xsl:apply-templates select="lb"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="span[@type='werknr']"/>
</xsl:stylesheet>