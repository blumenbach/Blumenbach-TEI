<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:so="http://standoff.proposal" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
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
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <p>Identity Template</p>
        </desc>
    </doc>
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="hi[@rend='green-sm']">
        <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">green-sm</xsl:attribute>
            <xsl:copy-of select="."/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="hi[@rend='green-md']">
        <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">green-md</xsl:attribute>
            <xsl:copy-of select="."/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="hi[@rend='green-lg']">
        <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">green-lg</xsl:attribute>
            <xsl:copy-of select="."/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="hi[@rend='sup']">
        <sup>
            <xsl:copy-of select="."/>
        </sup>
    </xsl:template>
    <xsl:template match="//emph">
        <em>
            <xsl:copy-of select="."/>
        </em>
    </xsl:template>
    <xsl:template match="//lb">
        <xsl:element name="br" namespace="http://www.w3.org/1999/xhtml"/>
    </xsl:template>
    <xsl:template match="//pc[@unit='bind']">
        <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="type">pc</xsl:attribute>–</xsl:element>
    </xsl:template>
    <xsl:template match="//pc[@unit='point']">
        <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="type">pc</xsl:attribute>.</xsl:element>
    </xsl:template>
    <xsl:template match="//pc[@unit='semicolon']">
        <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="type">pc</xsl:attribute>;</xsl:element>
    </xsl:template>
    <xsl:template match="//pc[@unit='space']"/>
    <xsl:template match="//pc[@unit='colon']">
        <span type="pc">:</span>
    </xsl:template>
    <xsl:template match="//pc[@unit='comma']">
        <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">,</xsl:element>
    </xsl:template>
    <xsl:template match="//pc[@unit='slash']">
        <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="type">pc</xsl:attribute>/</xsl:element>
    </xsl:template>
    <xsl:template match="//gap[@reason='ellipsis']">
        <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="type">pc</xsl:attribute>…</xsl:element>
    </xsl:template>
    <xsl:template match="//span[@type='ref']/ref">
        <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
            <xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
                <xsl:attribute name="href">
                    <xsl:value-of select="./@target"/>
                </xsl:attribute>
                <xsl:attribute name="target">_blank</xsl:attribute>&#160;<xsl:value-of select="./text()"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>