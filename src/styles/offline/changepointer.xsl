<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="count" select="0" saxon:assignable="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:function name="functx:substring-before-last" as="xs:string">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="delim" as="xs:string"/>
        <xsl:sequence select="    if (matches($arg, functx:escape-for-regex($delim)))    then replace($arg,             concat('^(.*)', functx:escape-for-regex($delim),'.*'),             '$1')    else ''  "/>
    </xsl:function>
    <xsl:function name="functx:escape-for-regex" as="xs:string">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:sequence select="    replace($arg,            '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')  "/>
    </xsl:function>
    <xsl:template match="//ptr">
        <xsl:variable name="tgt" select="."/>
        <xsl:variable name="oldid" select="functx:substring-before-last($tgt,'_')"/>
        <xsl:variable name="newnr" select="ancestor::teiHeader/fileDesc/publicationStmt/idno/idno[@type='RegNr']"/>
        <xsl:attribute name="target">
            <xsl:value-of select="concat($oldid, $newnr)"/>
        </xsl:attribute>
        <ptr/>
    </xsl:template>
</xsl:stylesheet>