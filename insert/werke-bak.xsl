<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:saxon="http://saxon.sf.net/" xmlns:so="http://standoff.proposal" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="teiHeader">
        <xsl:choose>
            <xsl:when test="./fileDesc/titleStmt/title[@type='taxon']">
                <table class="taxon">
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
                                <table>
                                    <thead>
                                        <tr>
                                            <th style="width: 38px;"/>
                                            <th style="width: 704px;"/>
                                        </tr>
                                    </thead>
                                    <xsl:if test="./fileDesc/titleStmt/title[@type='taxon']">
                                        <xsl:variable name="idno">
                                            <xsl:value-of select="substring-before(./profileDesc/textClass/classCode[@scheme='cat']/idno/@n, '.00')"/>
                                        </xsl:variable>
                                        <xsl:variable name="taxon-name">
                                            <xsl:value-of select="./profileDesc/textClass/classCode[@scheme='cat']/idno"/>
                                        </xsl:variable>
                                        <xsl:variable name="base-uri">
                                            <xsl:value-of select="static-base-uri()"/>
                                        </xsl:variable>
                                        <xsl:choose>
                                            <xsl:when test="./fileDesc/titleStmt/title[@n='1']">
                                                <tr>
                                                    <td>
                                                        <h1>
                                                            <a class="taxon" id="tx_{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                                                                <xsl:value-of select="$taxon-name"/>.
                                                                </a>
                                                        </h1>
                                                    </td>
                                                    <td>
                                                        <h1>
                                                            <a class="taxon" id="{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                                                                <xsl:value-of select="./fileDesc/titleStmt/title"/>
                                                            </a>
                                                        </h1>
                                                    </td>
                                                </tr>
                                            </xsl:when>
                                            <xsl:when test="./fileDesc/titleStmt/title[@n='2']">
                                                <tr>
                                                    <td>
                                                        <h2>
                                                            <a class="taxon" id="{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                                                                <xsl:value-of select="substring-after($taxon-name, '.')"/>.
                                                                </a>
                                                        </h2>
                                                    </td>
                                                    <td>
                                                        <h2>
                                                            <a class="taxon" id="{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                                                                <xsl:value-of select="./fileDesc/titleStmt/title"/>
                                                            </a>
                                                        </h2>
                                                    </td>
                                                </tr>
                                            </xsl:when>
                                            <xsl:when test="./fileDesc/titleStmt/title[@n='3'] or ./fileDesc/titleStmt/title[@n='4']">
                                                <xsl:choose>
                                                    <xsl:when test="./fileDesc/sourceDesc/biblStruct/monogr/title[@level='j']">
                                                        <tr>
                                                            <td>
                                                                <h3>
                                                                    <a class="taxon" id="{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                                                                        <xsl:value-of select="substring-after($taxon-name, '.')"/>
                                                                    </a>
                                                                </h3>
                                                            </td>
                                                            <td>
                                                                <h3>
                                                                    <a class="emph" id="{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                                                                        <xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/title[@level='j']"/>
                                                                    </a>
                                                                </h3>
                                                            </td>
                                                        </tr>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <tr>
                                                            <td>
                                                                <h3>
                                                                    <a class="taxon" id="{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                                                                        <xsl:value-of select="substring-after($taxon-name, '.')"/>
                                                                    </a>
                                                                </h3>
                                                            </td>
                                                            <td>
                                                                <h3>
                                                                    <a class="taxon" id="{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                                                                        <xsl:value-of select="./fileDesc/titleStmt/title"/>
                                                                    </a>
                                                                </h3>
                                                            </td>
                                                        </tr>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <tr>
                                                    <td>
                                                        <span class="taxon3">
                                                            <a class="taxon" id="{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                                                                <xsl:value-of select="substring-after($taxon-name, '.')"/>
                                                            </a>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span class="taxon3">
                                                            <a class="taxon" id="{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                                                                <xsl:value-of select="./fileDesc/titleStmt/title"/>
                                                            </a>
                                                        </span>
                                                    </td>
                                                </tr>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:if>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td/>
                            <td/>
                            <td>
                                <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/title[@level='j']">
                                    <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher/name/text()">
                                        <span class="meta">
                                            <xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/pubPlace"/>
                                        </span>
                                        <span class="meta">&#160;:&#160;<xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher"/>
                                        </span>
                                    </xsl:if>
                                    <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']">
                                        <span class="meta">,&#160;<xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']"/>
                                        </span>
                                    </xsl:if>
                                </xsl:if>
                                <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/biblScope">
                                    <span class="meta">&#160;–&#160;<xsl:copy-of select="./fileDesc/sourceDesc/biblStruct/monogr/biblScope"/>
                                    </span>
                                    <xsl:if test="./fileDesc/sourceDesc/biblStruct/citedRange/text()">
                                        <span class="meta">,&#160;<xsl:value-of select="./fileDesc/sourceDesc/biblStruct/citedRange"/>
                                        </span>
                                    </xsl:if>
                                    <span>.</span>
                                    <br/>
                                </xsl:if>
                            </td>
                        </tr>
                        <tr>
                            <td/>
                            <td/>
                            <td>
                                <xsl:if test="./fileDesc/sourceDesc/msDesc/msIdentifier/repository/text()">
                                    <xsl:for-each select="./fileDesc/sourceDesc/msDesc/msIdentifier">
                                        <span class="notes">
                                            <xsl:value-of select="./repository"/>
                                        </span>
                                        <xsl:if test="./fileDesc/sourceDesc/msDesc/msIdentifier/idno">
                                            <span class="notes">:&#160;<xsl:copy-of select="./idno"/>&#160;</span>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:if>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <xsl:if test="./fileDesc/titleStmt/title[@n &gt; '2']">
                    <br/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
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
                                    <xsl:variable name="BibNr" select="./profileDesc/textClass/classCode[@scheme='BiblNr']"/>
                                    <a class="taxon" href="/apps/blumenbach/view-work.html?id={$BibNr}" target="_blank">
                                        <xsl:value-of select="$BibNr"/>
                                    </a>
                                    <br/>
                                </span>
                                <xsl:if test="./fileDesc/notesStmt/note[@type='ref']">
                                    <xsl:for-each select="./fileDesc/notesStmt/note[@type='ref']/ref[@type='pdf']">
                                        <a href="{.}" target="_blank">
                                            <span>
                                                <img style="border: 0px solid ; width: 35px; height: 26px;" title="{./following-sibling::rs/text()}" src="/apps/blumenbach/resources/images/Buch.png"/>
                                            </span>
                                        </a>
                                        <br/>
                                    </xsl:for-each>
                                    <xsl:for-each select="./fileDesc/notesStmt/note[@type='ref']/ref[@type='html']">
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
                                                <xsl:if test="./fileDesc/sourceDesc/biblStruct/analytic/title">
                                                    <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/biblScope">
                                                        <span class="meta">
                                                            <xsl:copy-of select="./fileDesc/sourceDesc/biblStruct/monogr/biblScope"/>
                                                        </span>
                                                        <xsl:if test="./fileDesc/sourceDesc/biblStruct/citedRange/text()">
                                                            <span class="meta">,&#160;<xsl:value-of select="./fileDesc/sourceDesc/biblStruct/citedRange"/>
                                                            </span>
                                                        </xsl:if>
                                                        <span>.</span>
                                                        <br/>
                                                    </xsl:if>
                                                    <xsl:for-each select="./fileDesc/sourceDesc/biblStruct/analytic/title">
                                                        <xsl:choose>
                                                            <xsl:when test="./@type='schrift'">
                                                                <br/>
                                                                <span class="meta">
                                                                    <xsl:value-of select="."/>
                                                                </span>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <span class="meta">
                                                                    <xsl:value-of select="."/>
                                                                </span>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <xsl:choose>
                                                            <xsl:when test="contains(., '.]')"/>
                                                            <xsl:when test="contains(., '.“]')"/>
                                                            <xsl:when test="contains(., '.)')"/>
                                                            <xsl:when test="contains(., '.*')"/>
                                                            <xsl:when test="contains(., '.’“')"/>
                                                            <xsl:otherwise>
                                                                <span>.</span>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:for-each>
                                                    <xsl:for-each select="./fileDesc/sourceDesc/biblStruct/monogr/title[@level='m']">
                                                        <br/>
                                                        <span class="meta">
                                                            <xsl:value-of select="."/>
                                                        </span>
                                                    </xsl:for-each>
                                                </xsl:if>
                                                <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/title">
                                                    <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/title[@type='aut']">
                                                        <xsl:for-each select="./fileDesc/sourceDesc/biblStruct/monogr/title[@type='aut']">
                                                            <span class="meta">
                                                                <xsl:value-of select="."/>
                                                            </span>
                                                        </xsl:for-each>
                                                    </xsl:if>
                                                    <xsl:for-each select="./fileDesc/sourceDesc/biblStruct/monogr/title[@type='main']">
                                                        <span class="meta">
                                                            <xsl:if test="following-sibling::title[@type='aut']">&#160;</xsl:if>
                                                            <xsl:value-of select="."/>
                                                        </span>
                                                    </xsl:for-each>
                                                    <xsl:for-each select="./fileDesc/sourceDesc/biblStruct/monogr/title[@type='sub']">
                                                        <span class="meta">
                                                            <xsl:if test="not(preceding-sibling::title/child::span[@type='pc'])"/>
                                                            <xsl:copy-of select="."/>
                                                        </span>
                                                    </xsl:for-each>
                                                    <xsl:for-each select="./fileDesc/sourceDesc/biblStruct/monogr/title[@type='ed']">
                                                        <span class="meta">
                                                            <xsl:copy-of select="."/>
                                                        </span>
                                                    </xsl:for-each>
                                                </xsl:if>
                                                <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/edition/text()">
                                                    <span class="meta">.&#160;–&#160;<xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/edition"/>
                                                    </span>
                                                </xsl:if>
                                                <xsl:choose>
                                                    <xsl:when test="./fileDesc/sourceDesc/biblStruct/analytic/title">
                                                        <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/title[@level='m']">
                                                            <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher/name/text()">
                                                                <span class="meta">.&#160;–&#160;<xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/pubPlace"/>
                                                                </span>
                                                                <span class="meta">&#160;:&#160;<xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher/name"/>
                                                                </span>
                                                            </xsl:if>
                                                            <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']">
                                                                <span class="meta">,&#160;<xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']"/>
                                                                </span>
                                                            </xsl:if>
                                                        </xsl:if>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher/name/text()">
                                                            <span class="meta">.&#160;–&#160;<xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/pubPlace"/>
                                                            </span>
                                                            <span class="meta">&#160;:&#160;<xsl:copy-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher/name"/>
                                                            </span>
                                                        </xsl:if>
                                                        <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']">
                                                            <span class="meta">,&#160;<xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']"/>.</span>
                                                        </xsl:if>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                                <xsl:if test="./fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent">
                                                    <xsl:apply-templates select="./fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent"/>
                                                </xsl:if>
                                                <xsl:if test="./fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent/dimensions/dim">
                                                    <span class="meta">&#160;;&#160;<xsl:copy-of select="./fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent/dimensions/dim"/>.</span>
                                                </xsl:if>
                                                <xsl:if test="./fileDesc/sourceDesc/biblStruct/series">
                                                    <span class="meta">&#160;–&#160;<xsl:value-of select="./fileDesc/sourceDesc/biblStruct/series"/>.</span>
                                                </xsl:if>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <xsl:if test="./profileDesc/textClass/classCode[@n &gt; '00171.00']">
                                                    <xsl:if test="./profileDesc/textClass/classCode[@n &lt; '00180.00']">
                                                        <xsl:if test="./fileDesc/sourceDesc/biblStruct/citedRange/text()">
                                                            <span class="meta">
                                                                <xsl:value-of select="./fileDesc/sourceDesc/biblStruct/citedRange"/>
                                                            </span>
                                                        </xsl:if>
                                                        <span>.</span>
                                                        <br/>
                                                    </xsl:if>
                                                </xsl:if>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <xsl:if test="/TEI/so:stdf/so:annotations/spanGrp">
                                                    <xsl:call-template name="so:annotations"/>
                                                </xsl:if>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <xsl:choose>
                                                    <xsl:when test="./fileDesc/sourceDesc/biblStruct/analytic/title">
                                                        <xsl:if test="./profileDesc/textClass/classCode[@n &gt; '00171.00']">
                                                            <xsl:if test="./profileDesc/textClass/classCode[@n &lt; '00180.00']">
                                                                <xsl:if test="./fileDesc/sourceDesc/msDesc/msIdentifier/repository/text()">
                                                                    <xsl:for-each select="./fileDesc/sourceDesc/msDesc/msIdentifier">
                                                                        <span class="notes">
                                                                            <xsl:value-of select="./repository"/>
                                                                        </span>
                                                                        <xsl:if test="./fileDesc/sourceDesc/msDesc/msIdentifier/idno">
                                                                            <span>:&#160;</span>
                                                                            <span class="notes">
                                                                                <xsl:copy-of select="./idno"/>
                                                                            </span>
                                                                        </xsl:if>
                                                                    </xsl:for-each>
                                                                </xsl:if>
                                                            </xsl:if>
                                                        </xsl:if>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:if test="./fileDesc/sourceDesc/msDesc/msIdentifier/repository/text()">
                                                            <xsl:for-each select="./fileDesc/sourceDesc/msDesc/msIdentifier">
                                                                <span class="notes">
                                                                    <xsl:value-of select="./repository"/>
                                                                </span>
                                                                <xsl:if test="./fileDesc/sourceDesc/msDesc/msIdentifier/idno">
                                                                    <span>:</span>
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
                                        <tr>
                                            <td>
                                                <xsl:if test="/TEI/so:stdf/so:annotations/spanGrp/span">
                                                    <xsl:for-each select="/TEI/so:stdf/so:annotations/spanGrp">
                                                        <xsl:for-each select="./span">
                                                            <xsl:if test="./@type='msDesc'">
                                                                <span class="notes">
                                                                    <xsl:copy-of select="."/>
                                                                </span>
                                                                <span>.</span>
                                                            </xsl:if>
                                                        </xsl:for-each>
                                                    </xsl:for-each>
                                                </xsl:if>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <br/>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="extent">
        <span class="meta">&#160;–&#160;<xsl:copy-of select="*[not(self::dimensions)]"/>
        </span>
    </xsl:template>
    <xsl:template name="so:annotations">
        <xsl:if test="/TEI/so:stdf/so:annotations/spanGrp/span">
            <xsl:for-each select="/TEI/so:stdf/so:annotations/spanGrp">
                <xsl:choose>
                    <xsl:when test="./@style='n'">
                        <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
                            <xsl:attribute name="class">green-sm</xsl:attribute>
                            <xsl:call-template name="spans"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="spans"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="contains((child::span)[last()],'.“')"/>
                    <xsl:when test="(child::span[@type='idno'])[last()]">
                        <xsl:choose>
                            <xsl:when test="following-sibling::spanGrp">
                                <span>.</span>
                            </xsl:when>
                            <xsl:otherwise/>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="child::span[@type='msDesc']"/>
                    <xsl:otherwise>
                        <span>.</span>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    <xsl:template name="spans">
        <xsl:for-each select="./span">
            <xsl:choose>
                <xsl:when test="preceding-sibling::span[1]/child::metamark">
                    <xsl:choose>
                        <xsl:when test="./@type='pubPlace'">
                             .&#160;–&#160;<xsl:copy-of select="."/>
                        </xsl:when>
                        <xsl:when test="./@type='edition'">
                             .&#160;–&#160;<xsl:copy-of select="."/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="."/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="preceding-sibling::span[1]/child::span[@type='pc']">
                    <xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@style='j'">&#160;<xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@style='a'">&#160;<xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@style='m'">&#160;<xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='editor'">&#160;<xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='edition'">.&#160;–&#160;<xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='pubPlace'">.&#160;–&#160;<xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='publisher'">&#160;:&#160;<xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='date'">,&#160;<xsl:copy-of select="."/>
                    <xsl:if test="following-sibling::span[@type='biblScope']">.</xsl:if>
                </xsl:when>
                <xsl:when test="./@type='idno'">:&#160;<xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='extent'">&#160;–&#160;<xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='biblScope'">&#160;<xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='citedRange'">
                    <xsl:if test="preceding-sibling::span[@type='biblScope'][1]">,&#160;</xsl:if>
                    <xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='repository'">&#160;<xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='note'">&#160;<xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='img'">&#160;<xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='msDesc'"/>
                <xsl:when test="./@type='meta'">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='pc'">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='reference'">
                    <xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='ref'">
                    <xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='token'">
                    <xsl:copy-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>