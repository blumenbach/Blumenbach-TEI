<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:bo="bo" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="orig" select="document('werke-orig.xml')"/>
    <xsl:strip-space elements="*"/>
    <xsl:function name="functx:substring-after-last" as="xs:string">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="delim" as="xs:string"/>
        <xsl:sequence select="replace ($arg,concat('^.*',functx:escape-for-regex($delim)),'')"/>
    </xsl:function>
    <xsl:function name="functx:escape-for-regex" as="xs:string">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:sequence select="replace($arg, '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')"/>
    </xsl:function>
    <xsl:template match="node() | @*" name="identity">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="monogr">
        <xsl:variable name="biblNr" select="./ancestor-or-self::teiHeader/profileDesc/textClass/classCode[@scheme='BiblNr']"/>
        <xsl:call-template name="identity"/>
        <xsl:for-each select="$orig/TEI/note">
            <xsl:if test="$biblNr = functx:substring-after-last(./ab/@xml:id, '_')">
                <xsl:copy>
                    <xsl:attribute name="type">ck_source</xsl:attribute>
                    <xsl:apply-templates select="./ab"/>
                </xsl:copy>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>