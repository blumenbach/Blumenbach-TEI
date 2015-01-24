<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:saxon="http://saxon.sf.net/"
    extension-element-prefixes="saxon"
    version="2.0">
<xsl:output method="xml" indent="yes"/>
<xsl:variable name="count" select="0" saxon:assignable="yes"/>    
<xsl:template match="/">  
    
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="de-DE">
        <head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--THIS FILE IS GENERATED FROM AN XML MASTER. DO NOT EDIT (5)-->
            <meta name="DC.Title" content="Regesten zum Briefwechsel Johann Friedrich Blumenbachs" />
            <meta name="DC.Type" content="Text" />
            <meta name="DC.Format" content="text/html" />
            <link href="http://www.tei-c.org/release/xml/tei/stylesheet/tei.css" rel="stylesheet" type="text/css" />
            <link rel="stylesheet" media="print" type="text/css" href="http://www.tei-c.org/release/xml/tei/stylesheet/tei-print.css" />
        </head>
    <xsl:for-each select="//list/bibl/item">
        <div class="aphront-table-wrap">
            <tbody>
                <tr>
                    <td class="left">
                        <xsl:if test="./note[@type=langdesc]">
                            <xsl:value-of select="./note"/>
                        </xsl:if>    
                    </td>
                </tr>
            </tbody>            
        </div>    
    </xsl:for-each>    
</html>
</xsl:template>  
</xsl:stylesheet>