<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:saxon="http://saxon.sf.net/" xmlns:so="http://standoff.proposal" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
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
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//span[@style='q']">
        <xsl:copy>
            <xsl:attribute name="type">title</xsl:attribute>
            <xsl:attribute name="style">m</xsl:attribute>
            <xsl:apply-templates select="child::node()[not(self::text())]"/>
            <span>
                <em>
                    <xsl:value-of select="./text()"/>
                </em>&#160;</span>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//span[@style='j']">
        <xsl:copy>
            <xsl:attribute name="type">title</xsl:attribute>
            <xsl:attribute name="style">j</xsl:attribute>
            <span>
                <em>
                    <xsl:value-of select="."/>
                </em>&#160;</span>
        </xsl:copy>
    </xsl:template>
<!--
    <xsl:template match="//span[@type='img']">
                <img style="width: 16px; height: 16px;" src="/apps/blumenbach/resources/images/work.png"/>
    </xsl:template>
 -->
    <xsl:template match="//span[@type='reference']">
        <xsl:copy copy-namespaces="no">
            <xsl:attribute name="type">reference</xsl:attribute>
            <a href="/apps/blumenbach/view-work.html?id={.}" target="_blank">
                <span class="token">&#160;[-&gt;<xsl:value-of select="replace(., '0*([1-9][0-9]*|0)', '$1')"/>]&#160;</span>
            </a>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//lb">
        <br/>
    </xsl:template>
    <xsl:template match="//pc[@unit='bind']">
        <span>–&#160;</span>
    </xsl:template>
    <xsl:template match="//pc[@unit='point']">
        <span>.</span>
    </xsl:template>
    <xsl:template match="//pc[@unit='semicolon']">
        <span>;</span>
    </xsl:template>
    <xsl:template match="//pc[@unit='colon']">
        <span>:</span>
    </xsl:template>
    <xsl:template match="//pc[@unit='comma']">
        <span>,</span>
    </xsl:template>
    <xsl:template match="//pc[@unit='slash']">
        <span>&#160;/&#160;</span>
    </xsl:template>
    <xsl:template match="//gap[@reason='ellipsis']">
        <span>&#160;…&#160;</span>
    </xsl:template>
    <xsl:template match="//span[@type='ref']/ref">
        <span>
            <a href="{./@target}" target="_blank">
                <xsl:value-of select="./text()"/>
            </a>&#160;</span>
    </xsl:template>
    <xsl:template match="//span[@type='idno']">
        <xsl:for-each select=".">
            <xsl:choose>
                <xsl:when test="functx:trim(substring-before(./preceding-sibling::span[position()=1], '&#160;')) = 'SUB Göttingen'">
                    <xsl:copy copy-namespaces="no">
                        <xsl:attribute name="type">idno</xsl:attribute>
                        <a style="color: #6e5cb6;" href="https://opac.sub.uni-goettingen.de/DB=1/SET=3/TTL=1/CMD?ACT=SRCHA&amp;IKT=5025&amp;SRT=YOP&amp;TRM={.}" target="_blank">
                            <xsl:value-of select="functx:trim(.)"/>&#160;</a>
                    </xsl:copy>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of copy-namespaces="no" select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno">
        <xsl:for-each select=".">
            <xsl:choose>
                <xsl:when test="functx:trim(./preceding-sibling::repository[position()=1]) = 'SUB Göttingen'">
                    <xsl:copy copy-namespaces="no">
                        <xsl:attribute name="type">idno</xsl:attribute>
                        <a style="color: #6e5cb6;" href="https://opac.sub.uni-goettingen.de/DB=1/SET=3/TTL=1/CMD?ACT=SRCHA&amp;IKT=5025&amp;SRT=YOP&amp;TRM={.}" target="_blank">
                            <xsl:value-of select="functx:trim(.)"/>&#160;</a>
                    </xsl:copy>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of copy-namespaces="no" select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
