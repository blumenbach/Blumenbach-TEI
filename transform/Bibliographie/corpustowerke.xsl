<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:saxon="http://saxon.sf.net/" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="count" select="0" saxon:assignable="yes"/>
    <xsl:template match="/">
        <xsl:for-each select="teiCorpus/TEI">
            <saxon:assign name="count" select="$count+1"/>
            <xsl:variable name="filename" select="concat('jfb_werke_',concat(format-number($count, '00000'),'.xml'))"/>
            <xsl:value-of select="$filename"/>
            <xsl:result-document href="{$filename}">
                <xsl:processing-instruction name="xml-model">href="./standoff-proposal.rnc" type="application/relax-ng-compact-syntax"</xsl:processing-instruction>
                   <xsl:copy-of copy-namespaces="no" select="."/>                
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>  