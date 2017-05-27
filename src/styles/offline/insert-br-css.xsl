<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
        <head>
            <link rel="stylesheet" type="text/css" href="/apps/blumenbach/resources/css/br-stylesheet.css"/>
        </head>
        <body style="color: rgb(0, 0, 0); background-color: rgb(245, 245, 245);" alink="#000099" link="#000099" vlink="000099">
            <xsl:copy-of select="child::node()"/>
        </body>
    </xsl:template>
</xsl:stylesheet>