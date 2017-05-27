<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:gvp="http://vocab.getty.edu/ontology#" xmlns:wgs="http://www.w3.org/2003/01/geo/wgs84_pos#" xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:blume="http://purl.org/vocab/blumenbach#" xmlns:xs="http://www.w3.org/2001/XMLSchema" extension-element-prefixes="saxon" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="node() | @*" name="identity">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="form">
                <blume:a0>
                    <xsl:value-of select="//a0"/>
                </blume:a0>
                <blume:a8>
                    <xsl:value-of select="//a8"/>
                </blume:a8>
                <blume:a2>
                    <xsl:value-of select="//a2"/>
                </blume:a2>
                        <blume:a3>
                            <xsl:value-of select="//a3"/>
                        </blume:a3>
                <blume:a5>
                    <xsl:value-of select="//a5"/>
                </blume:a5>
                <blume:a6>
                    <xsl:value-of select="//a6"/>
                </blume:a6>
                <blume:z1>
                    <xsl:value-of select="//class"/>
                </blume:z1>
                <blume:a1>
                    <xsl:value-of select="//a1"/>
                </blume:a1>
                <blume:a7a>
                    <xsl:value-of select="//a7a"/>
                </blume:a7a>
                <blume:a7b>
                    <xsl:value-of select="//a7b"/>
                </blume:a7b>
                <blume:a9a>
                    <xsl:value-of select="//a9a"/>
                </blume:a9a>
                <blume:a9b>
                    <xsl:value-of select="//a9b"/>
                </blume:a9b>
                <blume:a9c>
                    <xsl:value-of select="//a9c"/>
                </blume:a9c>
                <blume:a26>
                    <xsl:value-of select="//a26"/>
                </blume:a26>
                <blume:a12a>
                    <xsl:value-of select="//a12a"/>
                </blume:a12a>
                <blume:a12aa>
                    <xsl:value-of select="//a12aa"/>
                </blume:a12aa>
                <blume:a12b>
                    <xsl:value-of select="//a12b"/>
                </blume:a12b>
                <blume:a12c>
                    <xsl:value-of select="//a12c"/>
                </blume:a12c>
                <blume:a12d>
                    <xsl:value-of select="//a12d"/>
                </blume:a12d>
                <blume:a13a>
                    <xsl:value-of select="//a13a"/>
                </blume:a13a>
                <blume:a13b>
                    <xsl:value-of select="//a13b"/>
                </blume:a13b>
                <blume:a13c>
                            <xsl:value-of select="//a13c"/>                        
                </blume:a13c>             
                <gvp:prefLabel>
                    <xsl:value-of select="//gvp:prefLabel"/>
                </gvp:prefLabel>
                <xml:lang>
                    <xsl:value-of select="//xml:lang"/>
                </xml:lang>               
                <gvp:parentString>
                    <xsl:value-of select="//gvp:parentString"/>
                </gvp:parentString>
                <wgs:lat>
                    <xsl:value-of select="//wgs:lat"/>
                </wgs:lat>
                <wgs:long>
                    <xsl:value-of select="//wgs:long"/>
                </wgs:long>
                <blume:a14a>
                    <xsl:value-of select="//a14a"/>
                </blume:a14a>
                <blume:a14aa>
                    <xsl:value-of select="//a14aa"/>
                </blume:a14aa>
                <blume:a14b>
                    <xsl:value-of select="//a14b"/>
                </blume:a14b>
                <blume:a14ba>
                    <xsl:value-of select="//a14ba"/>
                </blume:a14ba>
                <blume:a15a>
                    <xsl:value-of select="//a15a"/>
                </blume:a15a>
                <blume:a15aa>
                    <xsl:value-of select="//a15aa"/>
                </blume:a15aa>
                <blume:a15b>
                    <xsl:value-of select="//a15b"/>
                </blume:a15b>
                <blume:a15ba>
                    <xsl:value-of select="//a15ba"/>
                </blume:a15ba>
                <blume:a16a>
                    <xsl:value-of select="//a16a"/>
                </blume:a16a>
                <blume:a16b>
                    <xsl:value-of select="//a16b"/>
                </blume:a16b>
                <blume:a17>
                    <xsl:value-of select="//a17"/>
                </blume:a17>
                <blume:a12e>
                    <xsl:value-of select="//a12e"/>
                </blume:a12e>
                <blume:a12f>
                    <xsl:value-of select="//a12f"/>
                </blume:a12f>
                <blume:a12g>
                    <xsl:value-of select="//a12g"/>
                </blume:a12g>
                <blume:a12h>
                    <xsl:value-of select="//a12h"/>
                </blume:a12h>
                <blume:a12i>
                    <xsl:value-of select="//a12i"/>
                </blume:a12i>
        <xsl:for-each select="//original-lit-grid-iteration">
                        <blume:a18>
                    <xsl:value-of select="a18"/>
                </blume:a18>
        </xsl:for-each>
        <xsl:for-each select="//original-desc-grid-iteration">
                        <blume:a19>
                    <xsl:value-of select="a19"/>
                </blume:a19>
        </xsl:for-each>
        <xsl:for-each select="//original-image-grid-iteration">
                        <blume:a20>
                    <xsl:value-of select="a20"/>
                </blume:a20>
        </xsl:for-each>
        <xsl:for-each select="//secondary-lit-grid-iteration">
                        <blume:a22>
                    <xsl:value-of select="a22"/>
                </blume:a22>
                        <blume:a23>
                    <xsl:value-of select="a23"/>
                </blume:a23>
        </xsl:for-each>
        <xsl:for-each select="//brief-mentioned-grid-iteration">
                        <blume:f4>
                    <xsl:value-of select="f4"/>
                </blume:f4>
        </xsl:for-each>
                <blume:f5>
                    <xsl:value-of select="//f5"/>
                </blume:f5>
                <blume:f8>
                    <xsl:value-of select="//f8"/>
                </blume:f8>
        <xsl:for-each select="//mineral-authority-grid-iteration">
                        <blume:a9d>
                    <xsl:value-of select="a9d"/>
                        </blume:a9d>
        </xsl:for-each>
                <blume:a24a>
                    <xsl:value-of select="//a24a"/>
                </blume:a24a>
                <blume:a24b>
                    <xsl:value-of select="//a24b"/>
                </blume:a24b>
                <blume:a27>
                    <xsl:value-of select="//a27"/>
                </blume:a27>
                <blume:a28>
                    <xsl:value-of select="//a28"/>
                </blume:a28>
        <blume:f2a>
                    <xsl:value-of select="//f2a"/>
                </blume:f2a>
        <blume:f2b>
                    <xsl:value-of select="//f2b"/>
                </blume:f2b>
        <blume:f3a>
                    <xsl:value-of select="//f3a"/>
                </blume:f3a>
        <blume:f3b>
                    <xsl:value-of select="//f3b"/>
                </blume:f3b>
        <blume:b1>
                    <xsl:value-of select="//b1"/>
                </blume:b1>
        <blume:b2>
                    <xsl:value-of select="//b2"/>
                </blume:b2>
        <blume:b3b>
                    <xsl:value-of select="//b3b"/>
                </blume:b3b>
        <blume:b3d>
                    <xsl:value-of select="//b3d"/>
                </blume:b3d>
        <blume:b4a>
                    <xsl:value-of select="//b4a"/>
                </blume:b4a>
        <blume:b4aa>
                    <xsl:value-of select="//b4aa"/>
                </blume:b4aa>
        <blume:b4b>
                    <xsl:value-of select="//b4b"/>
                </blume:b4b>
        <blume:b4c>
                    <xsl:value-of select="//b4c"/>
                </blume:b4c>
        <blume:b4ca>
                    <xsl:value-of select="//b4ca"/>
                </blume:b4ca>
        <blume:b4d>
                    <xsl:value-of select="//b4d"/>
                </blume:b4d>
        <blume:b5>
                    <xsl:value-of select="//b5"/>
                </blume:b5>
        <blume:b6>
                    <xsl:value-of select="//b6"/>
                </blume:b6>
        <blume:b7a>
                    <xsl:value-of select="//b7a"/>
                </blume:b7a>
        <blume:b8>
                    <xsl:value-of select="//b8"/>
                </blume:b8>
                <blume:a21>
                    <xsl:value-of select="//a21"/>
                </blume:a21>
        <blume:f1>
                    <xsl:value-of select="//f1"/>
                </blume:f1>
        <blume:b9a>
                    <xsl:value-of select="//b9a"/>
                </blume:b9a>
        <blume:b9b>
                    <xsl:value-of select="//b9b"/>
                </blume:b9b>
        <blume:b10a>
                    <xsl:value-of select="//b10a"/>
                </blume:b10a>
        <blume:b10b>
                    <xsl:value-of select="//b10b"/>
                </blume:b10b>
        <blume:b11a>
                    <xsl:value-of select="//b11a"/>
                </blume:b11a>
        <blume:b11b>
                    <xsl:value-of select="//b11b"/>
                </blume:b11b>
        <blume:b11c>
                    <xsl:value-of select="//b11c"/>
                </blume:b11c>
        <blume:c1>
                    <xsl:value-of select="//c1"/>
                </blume:c1>
        <blume:c2>
                    <xsl:value-of select="//c2"/>
                </blume:c2>
            <xsl:for-each select="section-10/etikett-grid1">
            <etikett-grid>
                    <blume:a10>
                        <xsl:value-of select="a10"/>
                    </blume:a10>
                <blume:c3>
                        <xsl:value-of select="c3"/>
                    </blume:c3>
                <blume:c4>
                        <xsl:value-of select="c4"/>
                    </blume:c4>
                <blume:c5>
                        <xsl:value-of select="c5"/>
                    </blume:c5>
                <blume:c6a>
                        <xsl:value-of select="c6a"/>
                    </blume:c6a>
                <blume:c6b>
                        <xsl:value-of select="c6b"/>
                    </blume:c6b>
                <blume:c7a>
                        <xsl:value-of select="c7a"/>
                    </blume:c7a>
            </etikett-grid>
                </xsl:for-each>
            <xsl:for-each select="section-11/objekttext-grid1">
                <objekttext-grid1>
                    <blume:a11>
                        <xsl:value-of select="a11"/>
                    </blume:a11>
                    <blume:d1>
                        <xsl:value-of select="d1"/>
                    </blume:d1>
                    <blume:d2>
                        <xsl:value-of select="d2"/>
                    </blume:d2>
                    <blume:d3a>
                        <xsl:value-of select="d3a"/>
                    </blume:d3a>
                    <blume:d3b>
                        <xsl:value-of select="d3b"/>
                    </blume:d3b>
                </objekttext-grid1>
                </xsl:for-each>

            <xsl:for-each select="section-12/number-grid1">
                <number-grid1>
                    <blume:a4>
                        <xsl:value-of select="a4"/>
                    </blume:a4>
                    <blume:e1>
                        <xsl:value-of select="e1"/>
                    </blume:e1>
                    <blume:e2>
                        <xsl:value-of select="e2"/>
                    </blume:e2>
                    <blume:e3>
                        <xsl:value-of select="e3"/>
                    </blume:e3>
                    <blume:e4a>
                        <xsl:value-of select="e4a"/>
                    </blume:e4a>
                    <blume:e4b>
                        <xsl:value-of select="e4b"/>
                    </blume:e4b>
                    <blume:e5a>
                        <xsl:value-of select="e5a"/>
                    </blume:e5a>
                </number-grid1>
                </xsl:for-each>
        
    </xsl:template>
</xsl:stylesheet>