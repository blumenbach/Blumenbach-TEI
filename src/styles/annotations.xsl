<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:so="http://standoff.proposal" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <tr>
            <td class="col-md-2">
                <table class="table table-condensed table-bordered">
                    <thead>
                        <tr>
                            <th>Statement</th>
                            <th>Text</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="./so:annotations/spanGrp">
                            <tr>
                                <td>
                                    <xsl:value-of select="position()"/>
                                </td>
                                <td>
                                    <xsl:choose>
                                        <xsl:when test="./span[@style='j']">
                                            <em>
                                                <xsl:value-of select="./span[@style='j']/text()"/>
                                            </em>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="./span/text()"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>