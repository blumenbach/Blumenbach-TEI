<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">


<xsl:attribute-set name="h1" >
    <xsl:attribute name="font-size">24pt</xsl:attribute>
    <xsl:attribute name="font-family">"sans-serif"</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="space-after">14pt</xsl:attribute>
    <xsl:attribute name="break-before">page</xsl:attribute>
    <xsl:attribute name="border-after-style">solid</xsl:attribute>
    <xsl:attribute name="border-after-width">2pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="h2" >
<xsl:attribute name="font-size">16pt</xsl:attribute>
<xsl:attribute name="font-family">"sans-serif"</xsl:attribute>
<xsl:attribute name="font-weight">bold</xsl:attribute>
<xsl:attribute name="space-before">19pt</xsl:attribute>
<xsl:attribute name="space-after">5pt</xsl:attribute>
<xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="h3" >
<xsl:attribute name="font-size">13pt</xsl:attribute>
<xsl:attribute name="font-family">"sans-serif"</xsl:attribute>
<xsl:attribute name="font-weight">bold</xsl:attribute>
<xsl:attribute name="space-before">14pt</xsl:attribute>
<xsl:attribute name="space-after">5pt</xsl:attribute>
<xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="h4" >
<xsl:attribute name="font-size">12pt</xsl:attribute>
<xsl:attribute name="font-family">"sans-serif"</xsl:attribute>
<xsl:attribute name="font-weight">bold</xsl:attribute>
<xsl:attribute name="space-before">5pt</xsl:attribute>
<xsl:attribute name="space-after">5pt</xsl:attribute>
<xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="h5" >
<xsl:attribute name="font-size">10pt</xsl:attribute>
<xsl:attribute name="font-family">"sans-serif"</xsl:attribute>
<xsl:attribute name="font-weight">bold</xsl:attribute>
<xsl:attribute name="space-before">3pt</xsl:attribute>
<xsl:attribute name="space-after">3pt</xsl:attribute>
<xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
</xsl:attribute-set>

    <xsl:attribute-set name="table.data" >
    <xsl:attribute name="table-layout">fixed</xsl:attribute>
    <xsl:attribute name="space-before">10pt</xsl:attribute>
    <xsl:attribute name="space-after">10pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="table.data.caption" >
        <xsl:attribute name="font-family">sans-serif</xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
        <xsl:attribute name="space-before">3pt</xsl:attribute>
        <xsl:attribute name="space-after">3pt</xsl:attribute>
        <xsl:attribute name="space-after.precedence">2</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="table.data.th" >
        <xsl:attribute name="background-color">#DDDDDD</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-width">1pt</xsl:attribute>
        <xsl:attribute name="padding-start">0.3em</xsl:attribute>
        <xsl:attribute name="padding-end">0.2em</xsl:attribute>
        <xsl:attribute name="padding-before">2pt</xsl:attribute>
        <xsl:attribute name="padding-after">2pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="table.data.td1" >
        <xsl:attribute name="column-number">1</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-width">1pt</xsl:attribute>
        <xsl:attribute name="padding-start">0.3em</xsl:attribute>
        <xsl:attribute name="padding-end">0.2em</xsl:attribute>
        <xsl:attribute name="padding-before">2pt</xsl:attribute>
        <xsl:attribute name="padding-after">2pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="table.data.td2" >
        <xsl:attribute name="column-number">2</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-width">1pt</xsl:attribute>
        <xsl:attribute name="padding-start">0.3em</xsl:attribute>
        <xsl:attribute name="padding-end">0.2em</xsl:attribute>
        <xsl:attribute name="padding-before">2pt</xsl:attribute>
        <xsl:attribute name="padding-after">2pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="table.data.td3" >
        <xsl:attribute name="column-number">3</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-width">1pt</xsl:attribute>
        <xsl:attribute name="padding-start">0.3em</xsl:attribute>
        <xsl:attribute name="padding-end">0.2em</xsl:attribute>
        <xsl:attribute name="padding-before">2pt</xsl:attribute>
        <xsl:attribute name="padding-after">2pt</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>