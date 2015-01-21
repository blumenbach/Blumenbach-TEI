<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="xml"
        doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
        omit-xml-declaration="yes"
        encoding="UTF-8"
        indent="yes" />
    
    <xsl:variable name="is-logged-in" select="/data/logged-in-author/author"/>
    
    <xsl:template match="/">
        <xsl:apply-templates mode="transform">
            <xsl:with-param name="tei"/>
        </xsl:apply-templates>
        <xsl:apply-templates mode="render">
            <xsl:with-param name="page-title" />
        </xsl:apply-templates>
        <xsl:apply-templates mode="render">
            <xsl:with-param name="navigation" />
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="text()" mode="render" priority="2.5">
        <html>
            <head>
                <title>
                    <xsl:call-template name="page-title"/>
                </title>
                <link rel="icon" type="images/png" href="{$workspace}/images/icons/bookmark.png" />
                <link rel="stylesheet" type="text/css" media="screen" href="{$workspace}/css/styles.css" />
                <link rel="alternate" type="application/rss+xml" href="{$root}/rss/" />
            </head>
            <body>
                <div id="masthead">
                    <h1>
                        <a href="{$root}"><xsl:value-of select="$website-name"/></a>
                    </h1>
                    <xsl:apply-templates select="data/navigation">
                        <xsl:with-param name="navigation" />
                    </xsl:apply-templates>
                </div>
                
                <div id="package">
                    
                    <div id="content">
                        <ul>
                            <xsl:apply-templates select="//*[name()='title']/node()">
                                <xsl:with-param name="tei" />
                            </xsl:apply-templates>
                        </ul>
                    </div>
                </div>
                <ul id="footer">
                    <li>Orchestrated by <a class="symphony" href="http://getsymphony.com/">Symphony</a></li>
                    <li>Broadcasted via <a class="rss" href="{$root}/rss/">XML Feed</a></li>
                </ul>
            </body>
        </html>
        
    </xsl:template>
    
    
    <xsl:template match="node()" mode="transform" priority="2">
        <li>
            <xsl:copy>
                <xsl:apply-templates select="node()">
                    <xsl:with-param name="tei" />
                </xsl:apply-templates>
            </xsl:copy>
        </li>
    </xsl:template>
    
</xsl:stylesheet>
