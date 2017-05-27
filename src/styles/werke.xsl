<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:so="http://standoff.proposal" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="so:stdf"/>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <p>Outputs superscripts</p>
        </desc>
    </doc>
    <xsl:template name="superscript">
        <xsl:variable name="base-uri">
            <xsl:value-of select="static-base-uri()"/>
        </xsl:variable>
        <xsl:variable name="idno">
            <xsl:value-of select="./profileDesc/textClass/classCode[@scheme='taxon']"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="./fileDesc/sourceDesc/biblStruct/monogr/title[@style='anm']">
                <sup>
                    <a class="sup" id="{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                        <xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/title[@style='anm']"/>
                    </a>
                </sup>
            </xsl:when>
            <xsl:otherwise>
                <sup>
                    <a class="sup" id="{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                        <xsl:value-of select="./fileDesc/titleStmt/title[@style='anm']"/>
                    </a>
                </sup>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <p>Extracts data from an ordered Werke collection nodeset and outputs as HTML</p>
        </desc>
    </doc>
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
                                            <xsl:value-of select="./profileDesc/textClass/classCode[@scheme='taxon']"/>
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
                                                                <xsl:value-of select="./fileDesc/titleStmt/title[1]"/>
                                                            </a>
                                                            <xsl:call-template name="superscript"/>
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
                                                                <xsl:value-of select="./fileDesc/titleStmt/title[1]"/>
                                                            </a>
                                                            <xsl:call-template name="superscript"/>
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
                                                                    <xsl:choose>
                                                                        <xsl:when test="./fileDesc/sourceDesc/biblStruct/monogr/title[@style='n']">
                                                                            <a class="green-emph" id="{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                                                                                <xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/title[@level='j'][1]"/>
                                                                            </a>
                                                                            <xsl:call-template name="superscript"/>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <a class="emph" id="{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                                                                                <xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/title[@level='j'][1]"/>
                                                                            </a>
                                                                            <xsl:call-template name="superscript"/>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
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
                                                                    <xsl:choose>
                                                                        <xsl:when test="./fileDesc/titleStmt/title[@style='n']">
                                                                            <a class="green" id="{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                                                                                <xsl:value-of select="./fileDesc/titleStmt/title"/>
                                                                            </a>
                                                                            <xsl:call-template name="superscript"/>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <a class="taxon" id="{$idno}" href="{$base-uri}/apps/blumenbach/work-list-cat.html?id={$idno}">
                                                                                <xsl:value-of select="./fileDesc/titleStmt/title"/>
                                                                            </a>
                                                                            <xsl:call-template name="superscript"/>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
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
                        <xsl:if test="./fileDesc/sourceDesc/biblStruct/note[@type='anm']">
                            <tr>
                                <td/>
                                <td/>
                                <td>
                                    <span class="meta">
                                        <xsl:copy-of select="./fileDesc/sourceDesc/biblStruct/note[@type='anm']"/>
                                    </span>
                                </td>
                            </tr>
                        </xsl:if>
                        <tr>
                            <td/>
                            <td/>
                            <td>
                                <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/title[@level='j']">
                                    <xsl:for-each select="./fileDesc/sourceDesc/biblStruct/monogr/imprint">
                                        <xsl:if test="./publisher/name/string()">
                                            <span class="meta">
                                                <xsl:value-of select="./pubPlace"/>
                                            </span>
                                            <span class="meta">&#160;:&#160;<xsl:value-of select="./publisher"/>
                                            </span>
                                        </xsl:if>
                                        <xsl:if test="./date[@type='publication']">
                                            <span class="meta">,&#160;<xsl:value-of select="./date[@type='publication']"/>
                                            </span>
                                        </xsl:if>
                                        <xsl:if test="./*[position() &gt; 1]">
                                            <br/>
                                        </xsl:if>
                                    </xsl:for-each>
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
                                <xsl:if test="./fileDesc/sourceDesc/msDesc/msIdentifier/repository/string()">
                                    <xsl:apply-templates select="./fileDesc/sourceDesc/msDesc/msIdentifier"/>
                                </xsl:if>
                            </td>
                        </tr>
                        <xsl:if test="./fileDesc/notesStmt/note">
                            <tr>
                                <td/>
                                <td/>
                                <td>
                                    <br/>
                                    <xsl:copy-of select="./fileDesc/notesStmt/note[@type='anm']"/>
                                    <br/>
                                    <br/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="./fileDesc/sourceDesc/biblStruct/note">
                            <xsl:if test="not(./fileDesc/sourceDesc/biblStruct/note[@type='anm'])">
                                <xsl:for-each select="./fileDesc/sourceDesc/biblStruct/note">
                                    <tr>
                                        <td/>
                                        <td/>
                                        <td>
                                            <xsl:value-of select="."/>
                                            <br/>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </xsl:if>
                        </xsl:if>
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
                                    <xsl:choose>
                                        <xsl:when test="$BibNr &gt; 03000">
                                        <a class="green-lg" href="/exist/apps/blumenbach/view-work.html?id={$BibNr}" target="_blank">
                                            <xsl:copy-of select="$BibNr"/>
                                        </a>
                                        </xsl:when>
                                        <xsl:otherwise>
                                        <a class="taxon" href="/exist/apps/blumenbach/view-work.html?id={$BibNr}" target="_blank">
                                            <xsl:copy-of select="$BibNr"/>
                                        </a>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <br/>
                                </span>
                                <xsl:if test="./fileDesc/notesStmt/note[@type='ref']">
                                    <xsl:for-each select="./fileDesc/notesStmt/note[@type='ref']/ref[@type='pdf']">
                                        <a href="{.}" target="_blank">
                                            <span>
                                                <img style="border: 0px solid ; width: 35px; height: 26px;" title="{./following-sibling::rs/text()}" src="/exist/apps/blumenbach/resources/images/Buch.png"/>
                                            </span>
                                        </a>
                                        <br/>
                                    </xsl:for-each>
                                    <xsl:for-each select="./fileDesc/notesStmt/note[@type='ref']/ref[@type='html']">
                                        <a href="{.}" target="_blank">
                                            <span>
                                                <img style="border: 0px solid ; width: 33px; height: 45px;" title="{./following-sibling::rs/text()}" src="/exist/apps/blumenbach/resources/images/Html.png"/>
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
                                                            <xsl:when test="contains(., '.“')"/>
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
                                                            <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher/name/string()">
                                                                <span class="meta">.&#160;–&#160;<xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/pubPlace"/>
                                                                </span>
                                                                <span class="meta">&#160;:&#160;<xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher/name"/>
                                                                </span>
                                                            </xsl:if>
                                                            <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']">
                                                                <span class="meta">,&#160;<xsl:copy-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']"/>.
                                                                </span>
                                                            </xsl:if>
                                                        </xsl:if>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher/name/string()">
                                                            <span class="meta">.&#160;–&#160;<xsl:copy-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/pubPlace"/>
                                                            </span>
                                                            <span class="meta">&#160;:&#160;<xsl:copy-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher/name"/>
                                                            </span>
                                                        </xsl:if>
                                                        <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']">
                                                            <span class="meta">,&#160;<xsl:copy-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']"/>.</span>
                                                        </xsl:if>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                                <xsl:if test="./fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent/string()">
                                                    <span class="meta">&#160;–&#160;<xsl:apply-templates select="./fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent/node()[not(self::dimensions)]"/>
                                                    </span>
                                                </xsl:if>
                                                <xsl:if test="./fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent/dimensions/dim/string()">
                                                    <span class="meta">&#160;;&#160;<xsl:copy-of select="./fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent/dimensions/dim"/>.</span>
                                                </xsl:if>
                                                <xsl:if test="./fileDesc/sourceDesc/biblStruct/series">
                                                    <span class="meta">&#160;–&#160;<xsl:value-of select="./fileDesc/sourceDesc/biblStruct/series"/>.</span>
                                                </xsl:if>
                                                <xsl:if test="./fileDesc/notesStmt/note[@type='ptr']">
                                                    <sup>
                                                        <xsl:value-of select="./fileDesc/notesStmt/note[@type='ptr']"/>
                                                    </sup>
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
                                                <xsl:if test="../so:stdf/so:annotations/spanGrp">
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
                                                                    <xsl:apply-templates select="./fileDesc/sourceDesc/msDesc/msIdentifier"/>
                                                                </xsl:if>
                                                            </xsl:if>
                                                        </xsl:if>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:if test="./fileDesc/sourceDesc/msDesc/msIdentifier/repository/text()">
                                                            <xsl:apply-templates select="./fileDesc/sourceDesc/msDesc/msIdentifier"/>
                                                        </xsl:if>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <xsl:if test="../so:stdf/so:annotations/spanGrp/span">
                                                    <xsl:for-each select="../so:stdf/so:annotations/spanGrp">
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
    <xsl:template match="msIdentifier">
        <xsl:for-each select=".">
            <span class="notes">
                <xsl:value-of select="./repository"/>
            </span>
            <xsl:if test="./idno">
                <span>:</span>
                <xsl:call-template name="id-links"/>
                <span>&#160;</span>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="id-links">
        <xsl:for-each select="./idno">
            <xsl:choose>
                <xsl:when test="./preceding-sibling::repository[position()=1] = 'SUB Göttingen'">
                    <xsl:copy>
                        <xsl:attribute name="type">idno</xsl:attribute>
                        <a xmlns="http://www.w3.org/1999/xhtml" href="https://opac.sub.uni-goettingen.de/DB=1/SET=3/TTL=1/CMD?ACT=SRCHA&amp;IKT=5025&amp;SRT=YOP&amp;TRM={./@n}" target="_blank">
                            <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
                                <xsl:attribute name="class">token</xsl:attribute>
                                <xsl:value-of select="."/>
                            </xsl:element>
                        </a>
                    </xsl:copy>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of copy-namespaces="no" select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="extent">
        <span class="meta">&#160;–<xsl:copy-of select="."/>
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
                    <xsl:when test="contains((child::span)[last()],'.“') or contains((child::span)[last()],'.’“') or contains((child::span)[last()],'.)') or (child::span[@type='anm'])"/>
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
                        <xsl:when test="./@type='pubPlace'">.&#160;–&#160;<xsl:copy-of select="."/>
                        </xsl:when>
                        <xsl:when test="./@type='edition'">.&#160;–&#160;<xsl:copy-of select="."/>
                        </xsl:when>
                        <xsl:when test="./@type='biblScope'">&#160;<xsl:copy-of select="."/>
                        </xsl:when>
                        <xsl:when test="./@type='citedRange'">&#160;<xsl:copy-of select="."/>
                        </xsl:when>
                        <xsl:when test="./@style='j'">&#160;<xsl:apply-templates select="self::span[@style='j']"/>
                        </xsl:when>
                        <xsl:when test="./@type='note'">&#160;<xsl:copy-of select="."/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="."/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="preceding-sibling::span[1]/child::span[@type='pc']">
                    <xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@style='j'">&#160;<xsl:apply-templates select="self::span[@style='j']"/>
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
                    <xsl:if test="following-sibling::span[@type='biblScope'][1] or following-sibling::span[@type='extent'][1]">.</xsl:if>
                </xsl:when>
                <xsl:when test="./@type='idno'">
                    <xsl:if test="not(preceding-sibling::span[@type='idno'][1])">&#160;</xsl:if>
                    <xsl:apply-templates select="self::span[@type='idno']"/>
                </xsl:when>
                <xsl:when test="./@type='extent'">&#160;–&#160;<xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='biblScope'">&#160;<xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='citedRange'">
                    <xsl:if test="preceding-sibling::span[@type='biblScope'][1] or preceding-sibling::span[@type='date'][1] or preceding-sibling::span[@type='title'][1]">,&#160;</xsl:if>
                    <xsl:copy-of select="."/>
                </xsl:when>
                <xsl:when test="./@type='repository'">&#160;<xsl:copy-of select="."/>:</xsl:when>
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
 <!-- 
                <xsl:when test="./@type='reference'"> <xsl:copy-of select="."/></xsl:when>
 -->
                <xsl:when test="./@type='reference'">&#160;<xsl:call-template name="references"/>
                </xsl:when>
                <xsl:when test="./@type='ref'">
                    <xsl:copy-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="references">
        <xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="href">/exist/apps/blumenbach/view-work.html?id=<xsl:value-of select="."/>
            </xsl:attribute>
            <xsl:attribute name="target">_blank</xsl:attribute>
            <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
                <xsl:attribute name="class">token</xsl:attribute>[-&gt;<xsl:value-of select="replace(., '0*([1-9][0-9]*|0)', '$1')"/>]</xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="span[@type='idno']">
        <xsl:choose>
            <xsl:when test="./preceding-sibling::span[position()=1] = 'SUB Göttingen'">
                <a xmlns="http://www.w3.org/1999/xhtml" href="https://opac.sub.uni-goettingen.de/DB=1/SET=3/TTL=1/CMD?ACT=SRCHA&amp;IKT=5025&amp;SRT=YOP&amp;TRM={./@n}" target="_blank">
                    <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
                        <xsl:attribute name="class">token</xsl:attribute>
                        <xsl:value-of select="."/>
                    </xsl:element>
                </a>
            </xsl:when>
            <xsl:when test="./preceding-sibling::span[position() &gt; 1] = 'SUB Göttingen'">
                <span>;&#160;</span>
                <a xmlns="http://www.w3.org/1999/xhtml" href="https://opac.sub.uni-goettingen.de/DB=1/SET=3/TTL=1/CMD?ACT=SRCHA&amp;IKT=5025&amp;SRT=YOP&amp;TRM={./@n}" target="_blank">
                    <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
                        <xsl:attribute name="class">token</xsl:attribute>
                        <xsl:value-of select="."/>
                    </xsl:element>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of copy-namespaces="no" select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="span[@style='j']">
        <xsl:element name="em" namespace="http://www.w3.org/1999/xhtml">
            <xsl:choose>
                <xsl:when test=".//hi">
                    <xsl:call-template name="rend-green-sm"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template name="rend-green-sm">
        <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">green-sm</xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="hi[@rend='green-md']">
        <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">green-md</xsl:attribute>
            <xsl:copy-of select="."/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="hi[@rend='green-lg']">
        <xsl:element name="span" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="class">green-lg</xsl:attribute>
            <xsl:copy-of select="."/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="hi[@rend='sup']">
        <sup>
            <xsl:copy-of select="."/>
        </sup>
    </xsl:template>
    <xsl:template match="//emph">
        <em>
            <xsl:copy-of select="."/>
        </em>
    </xsl:template>
    <xsl:template match="//span[@style='q']">
        <xsl:copy>
            <xsl:attribute name="type">title</xsl:attribute>
            <xsl:attribute name="style">m</xsl:attribute>
            <xsl:apply-templates select="child::node()[not(self::text())]"/>
            <span style="q">
                <em xmlns="http://www.w3.org/1999/xhtml">
                    <xsl:value-of select="./text()"/>
                </em>
            </span>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>