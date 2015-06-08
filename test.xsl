<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:saxon="http://saxon.sf.net/" xmlns:so="http://standoff.proposal" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <body>
            <!--
            <table class="werk">
                <thead>
                    <tr>
                        <th style="width: 15px;"/>
                        <th style="width: 65px;"/>
                        <th style="width: 1020px;"/>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td/>
                        <td/>
                        <td>
                            <hr/>
                            <xsl:for-each select="/TEI/teiHeader/profileDesc/textClass/classCode[@scheme='cat']">
                                <span class="code">
                                    <xsl:value-of select="./idno"/> <xsl:value-of select="./text()"/>
                                </span>
                                <span> / </span>
                            </xsl:for-each>
                            <hr/>
                            <br/>
                        </td>
                    </tr>
                </tbody>
            </table>
             -->
            <table class="werk">
                <thead>
                    <tr>
                        <th style="width: 15px;"/>
                        <th style="width: 65px;"/>
                        <th style="width: 1020px;"/>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td/>
                        <td>
                            <span class="BiblNr">
                                <xsl:variable name="BibNr" select="/TEI/teiHeader/profileDesc/textClass/classCode[@scheme='BiblNr']"/>
                                <a style="color: #000;" href="/apps/blumenbach/view-work.html?id={$BibNr}" target="_blank">
                                    <xsl:value-of select="$BibNr"/>
                                </a>
                                <br/>
                            </span>
                            <xsl:if test="/TEI/teiHeader/fileDesc/notesStmt/note[@type='ref']">
                                <xsl:for-each select="/TEI/teiHeader/fileDesc/notesStmt/note[@type='ref']/ref[@type='pdf']">
                                    <a href="{.}" target="_blank">
                                        <span>
                                            <img style="border: 0px solid ; width: 35px; height: 26px;" title="{./following-sibling::rs/text()}" src="/apps/blumenbach/resources/images/Buch.png"/>
                                        </span>
                                    </a>
                                    <br/>
                                </xsl:for-each>
                                <xsl:for-each select="/TEI/teiHeader/fileDesc/notesStmt/note[@type='ref']/ref[@type='html']">
                                    <a href="{.}" target="_blank">
                                        <span>
                                            <img style="border: 0px solid ; width: 33px; height: 45px;" title="{./following-sibling::rs/text()}" src="/apps/blumenbach/resources/images/Html.png"/>
                                        </span>
                                    </a>
                                    <br/>
                                </xsl:for-each>
                            </xsl:if>
                        </td>
                        <td>
                            <table class="data">
                                <tbody>
                                    <tr>
                                        <td>
                                            <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title">
                                                <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/biblScope">
                                                    <span class="meta">
                                                        <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/biblScope"/>
                                                    </span>
                                                    <span>.</span>
                                                    <br/>
                                                </xsl:if>
                                                <xsl:if test="/TEI/teiHeader/profileDesc/textClass/classCode[@scheme='cat']/idno ='II.3'">
                                                    <span class="meta">
                                                        <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent/text()"/>
                                                    </span>
                                                    <br/>
                                                </xsl:if>
                                                <xsl:for-each select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title">
                                                    <span class="meta">
                                                        <xsl:value-of select="."/>
                                                    </span>
                                                    <span>.</span>
                                                </xsl:for-each>
                                                <xsl:for-each select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title[@level='m']">
                                                    <br/>
                                                    <span class="meta">
                                                        <xsl:value-of select="."/>
                                                    </span>
                                                </xsl:for-each>
                                            </xsl:if>
                                            <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title">
                                                <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title[@type='aut']">
                                                    <xsl:for-each select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title[@type='aut']">
                                                        <span class="meta">
                                                            <xsl:value-of select="."/>
                                                        </span>
                                                        <span>&#160;…&#160;</span>
                                                    </xsl:for-each>
                                                </xsl:if>
                                                <xsl:for-each select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title[@type='main']">
                                                    <span class="meta">
                                                        <xsl:value-of select="."/>
                                                    </span>
                                                </xsl:for-each>
                                                <xsl:for-each select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title[@type='sub']">
                                                    <span>&#160;/&#160;</span>
                                                    <span class="meta">
                                                        <xsl:value-of select="."/>
                                                    </span>
                                                </xsl:for-each>
                                                <xsl:for-each select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title[@type='ed']">
                                                    <span>&#160;–&#160;</span>
                                                    <span class="meta">
                                                        <xsl:value-of select="."/>
                                                    </span>
                                                </xsl:for-each>
                                            </xsl:if>
                                            <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/edition/text()">
                                                <span>&#160;–&#160;</span>
                                                <span class="meta">
                                                    <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/edition"/>
                                                </span>
                                            </xsl:if>
                                            <xsl:choose>
                                                <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title">
                                                    <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title[@level='m']">
                                                        <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher">
                                                            <span>.&#160;–&#160;</span>
                                                            <span class="meta">
                                                                <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/pubPlace"/>
                                                            </span>
                                                            <span>:&#160;</span>
                                                            <span class="meta">
                                                                <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher"/>
                                                            </span>
                                                        </xsl:if>
                                                        <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']">
                                                            <span>,&#160;</span>
                                                            <span class="meta">
                                                                <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']"/>
                                                            </span>
                                                        </xsl:if>
                                                    </xsl:if>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher">
                                                        <span>.&#160;–&#160;</span>
                                                        <span class="meta">
                                                            <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/pubPlace"/>
                                                        </span>
                                                        <span>:&#160;</span>
                                                        <span class="meta">
                                                            <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher"/>
                                                        </span>
                                                    </xsl:if>
                                                    <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']">
                                                        <span>,&#160;</span>
                                                        <span class="meta">
                                                            <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']"/>
                                                        </span>
                                                        <span>.</span>
                                                    </xsl:if>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            <xsl:if test="not(/TEI/teiHeader/profileDesc/textClass/classCode[@scheme='cat']/idno ='II.3')">
                                                <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent/text()">
                                                    <span>&#160;–&#160;</span>
                                                    <span class="meta">
                                                        <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent/text()"/>
                                                    </span>
                                                </xsl:if>
                                            </xsl:if>
                                            <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent/dimensions/dim/text()">
                                                <span>&#160;;&#160;</span>
                                                <span class="meta">
                                                    <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent/dimensions/dim"/>
                                                </span>
                                                <span>.</span>
                                            </xsl:if>
                                            <xsl:choose>
                                                <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title">
                                                    <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/citedRange/text()">
                                                        <span>;&#160;</span>
                                                        <span class="meta">
                                                            <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/citedRange"/>
                                                        </span>
                                                    </xsl:if>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/series">
                                                <span>&#160;–&#160;</span>
                                                <span class="meta">
                                                    <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/series"/>
                                                </span>
                                            </xsl:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <xsl:if test="/TEI/so:stdf/so:annotations/spanGrp/span">
                                                <xsl:for-each select="/TEI/so:stdf/so:annotations/spanGrp">
                                                    <xsl:for-each select="./span">
                                                        <xsl:choose>
                                                            <xsl:when test="./@type='title'">
                                                                <span class="notes">
                                                                    <xsl:copy-of select="."/>
                                                                </span>
                                                                <span>&#160;</span>
                                                            </xsl:when>
                                                            <xsl:when test="./@type='edition'">
                                                                <span>&#160;–&#160;</span>
                                                                <span class="notes">
                                                                    <xsl:copy-of select="."/>
                                                                </span>
                                                            </xsl:when>
                                                            <xsl:when test="./@type='pubPlace'">
                                                                <span>.&#160;–&#160;</span>
                                                                <span class="notes">
                                                                    <xsl:copy-of select="."/>
                                                                </span>
                                                            </xsl:when>
                                                            <xsl:when test="./@type='publisher'">
                                                                <span>:</span>
                                                                <span class="notes">
                                                                    <xsl:copy-of select="."/>
                                                                </span>
                                                                <span>&#160;</span>
                                                            </xsl:when>
                                                            <xsl:when test="./@type='date'">
                                                                <span>,</span>
                                                                <span class="notes">
                                                                    <xsl:copy-of select="."/>
                                                                </span>
                                                                <span>&#160;</span>
                                                            </xsl:when>
                                                            <xsl:when test="./@type='idno'">
                                                                <span>:&#160;</span>
                                                                <span class="notes">
                                                                    <xsl:copy-of select="."/>
                                                                </span>
                                                                <span>&#160;</span>
                                                            </xsl:when>
                                                            <xsl:when test="./@type='extent'">
                                                                <span>&#160;–&#160;</span>
                                                                <span class="notes">
                                                                    <xsl:copy-of select="."/>
                                                                </span>
                                                            </xsl:when>
                                                            <xsl:when test="./@type='citedRange'">
                                                                <span>&#160;,&#160;</span>
                                                                <span class="notes">
                                                                    <xsl:copy-of select="."/>
                                                                </span>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <span class="notes">
                                                                    <xsl:copy-of select="."/>
                                                                </span>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:for-each>
                                                    <span>.&#160;</span>
                                                </xsl:for-each>
                                            </xsl:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <xsl:choose>
                                                <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title"/>
                                                <xsl:otherwise>
                                                    <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/repository/text()">
                                                        <xsl:for-each select="/TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier">
                                                            <span class="notes">
                                                                <xsl:value-of select="./repository"/>
                                                            </span>
                                                            <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno">
                                                                <span>:&#160;</span>
                                                                <span class="notes">
                                                                    <xsl:copy-of select="./idno"/>
                                                                </span>
                                                                <span>&#160;</span>
                                                            </xsl:if>
                                                        </xsl:for-each>
                                                    </xsl:if>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <br/>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br/>
        </body>
    </xsl:template>
</xsl:stylesheet>
