<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <p>Extracts data from an ordered Briefregesten collection nodeset and outputs as HTML</p>
        </desc>
    </doc>
    <xsl:template match="/">
        <body>
            <table class="brief">
                <thead>
                    <tr>
                        <th style="width: 1%;"/>
                        <th style="width: 5%;"/>
                        <th style="width: 1%;"/>
                        <th style="width: 12%;"/>
                        <th style="width: 1%;"/>
                        <th style="width: 25%;"/>
                        <th style="width: 1%;"/>
                        <th/>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td/>
                        <td>
                            <span class="RegNr">
                                <xsl:variable name="regnr" select="/TEI/teiHeader/profileDesc/textClass/classCode[@scheme='RegNr']/idno"/>
                                <a href="/exist/apps/blumenbach/view-brief.html?id={$regnr}" target="_blank">
                                    <xsl:value-of select="/TEI/teiHeader/profileDesc/textClass/classCode[@scheme='RegNr']/idno"/>
                                </a>
                            </span>
                        </td>
                        <td/>
                        <td>
                            <span class="Eckdaten">
                                <xsl:value-of select="/TEI/teiHeader/profileDesc/creation/origDate/note/listEvent/event[@type='origin']/note/date/text()"/>
                                <br/>
                                <xsl:value-of select="/TEI/teiHeader/profileDesc/creation/placeName"/>
                            </span>
                            <br/>
                            <xsl:choose>
                                <xsl:when test="/TEI/teiHeader/profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-nb']">
                                    <xsl:choose>
                                        <xsl:when test="not(/TEI/teiHeader/profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-na'])">
                                            <span class="AlternatDatum">
                                        nach <xsl:value-of select="/TEI/teiHeader/profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-nb']/@notBefore"/>
                                            </span>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <span class="AlternatDatum">
                                      nach <xsl:value-of select="/TEI/teiHeader/profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-nb']/@notBefore"/>
                                            </span>
                                            <br/>
                                            <span class="AlternatDatum">
                                        vor <xsl:value-of select="/TEI/teiHeader/profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-na']/@notAfter"/>
                                            </span>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:when test="/TEI/teiHeader/profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-na']">
                                    <xsl:if test="not(/TEI/teiHeader/profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-nb'])">
                                        <span class="AlternatDatum">
                                            vor <xsl:value-of select="/TEI/teiHeader/profileDesc/creation/origDate/note/listEvent/event[@type='iso-origin-na']/@notAfter"/>
                                        </span>
                                    </xsl:if>
                                </xsl:when>
                                <xsl:otherwise>
                                    <span class="AlternatDatum">
                                        <xsl:value-of select="/TEI/teiHeader/profileDesc/creation/origDate/note/listEvent/event[@type='origin']/@when"/>
                                    </span>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="/TEI/teiHeader/profileDesc/creation/origDate/note/listEvent/event[@type='julian-origin']">
                                <br/>
                                <span class="AlternatDatum">
                                        [= julian. Kal.: <xsl:value-of select="/TEI/teiHeader/profileDesc/creation/origDate/note/listEvent/event[@type='julian-origin']/@when"/>]
                                    </span>
                            </xsl:if>
                        </td>
                        <td/>
                        <td>
                            <table class="data">
                                <thead>
                                    <tr>
                                        <th style="width: 5%;"/>
                                        <th style="width: 2%;"/>
                                        <th/>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <span class="Rubriken">A:</span>
                                        </td>
                                        <td/>
                                        <td>
                                            <span class="Eckdaten">
                                                <xsl:for-each select="/TEI/teiHeader/fileDesc/titleStmt/author/persName">
                                                    <xsl:if test="not(position() = 1)">
                                                        <br/>&#160;und <br/>
                                                    </xsl:if>
                                                    <xsl:choose>
                                                        <xsl:when test="./surname/text()">
                                                            <xsl:value-of select="./surname"/>,&#160;<xsl:value-of select="./forename"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select=".//text()"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:for-each>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="Rubriken">E:</span>
                                        </td>
                                        <td/>
                                        <td>
                                            <span class="Eckdaten">
                                                <xsl:for-each select="/TEI/teiHeader/profileDesc/creation/persName">
                                                    <xsl:if test="not(position() = 1)">
                                                        <br/>&#160;und <br/>
                                                    </xsl:if>
                                                    <xsl:choose>
                                                        <xsl:when test="./surname/text()">
                                                            <xsl:value-of select="./surname"/>,&#160;<xsl:value-of select="./forename"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select=".//text()"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:for-each>
                                            </span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                        <td/>
                        <td>
                            <span class="Briefinhalt">
                                <xsl:copy-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title[@type='source']"/>
                            </span>
                            <br/>
                            <br/>
                            <table class="data">
                                <thead>
                                    <tr>
                                        <th style="width: 43px;"/>
                                        <th style="width: 1px;"/>
                                        <th style="width: 219px;"/>
                                        <th style="width: 11px;"/>
                                        <th style="width: 46px;"/>
                                        <th style="width: 1px;"/>
                                        <th style="width: 210px;"/>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <span class="Rubriken">Überl.:</span>
                                        </td>
                                        <td/>
                                        <td>
                                            <span class="ZusatzDaten">
                                                <xsl:copy-of select="/TEI/teiHeader/fileDesc/notesStmt/note[@type='Überlieferung']"/>
                                            </span>
                                        </td>
                                        <td/>
                                        <td>
                                            <span class="Rubriken">Werke:</span>
                                        </td>
                                        <td/>
                                        <td>
                                            <span class="ZusatzDaten">
                                                <xsl:copy-of select="/TEI/teiHeader/fileDesc/notesStmt/note[@type='Werke']/bibl"/>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="Rubriken">Dr.:</span>
                                        </td>
                                        <td/>
                                        <td>
                                            <span class="ZusatzDaten">
                                                <xsl:copy-of select="/TEI/teiHeader/fileDesc/notesStmt/note[@type='Drucke']/bibl"/>
                                            </span>
                                        </td>
                                        <td/>
                                        <td>
                                            <span class="Rubriken">Obj.:</span>
                                        </td>
                                        <td/>
                                        <td>
                                            <span class="ZusatzDaten">
                                                <xsl:copy-of select="/TEI/teiHeader/fileDesc/notesStmt/note[@type='Objekte']/rs"/>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="Rubriken">Ed.:</span>
                                        </td>
                                        <td/>
                                        <td>
                                            <span class="ZusatzDaten">
                                                <xsl:copy-of select="/TEI/teiHeader/fileDesc/notesStmt/note/bibl/edition"/>
                                            </span>
                                        </td>
                                        <td/>
                                        <td>
                                            <span class="Rubriken">Anm.:</span>
                                        </td>
                                        <td/>
                                        <td>
                                            <span class="ZusatzDaten">
                                                <xsl:copy-of select="/TEI/teiHeader/fileDesc/notesStmt/note[@type='Anmerkung']/*[not(self::title)]"/>
                                            </span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br/>
            <br/>
            <br/>
        </body>
    </xsl:template>
</xsl:stylesheet>