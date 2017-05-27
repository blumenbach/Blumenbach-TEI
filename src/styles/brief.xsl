<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:function name="functx:pad-integer-to-length" as="xs:string">
        <xsl:param name="integerToPad" as="xs:anyAtomicType?"/>
        <xsl:param name="length" as="xs:integer"/>
        <xsl:sequence select="if ($length &lt; string-length(string($integerToPad)))        then error(xs:QName('functx:Integer_Longer_Than_Length'))        else concat              (functx:repeat-string(                 '0',$length - string-length(string($integerToPad))),               string($integerToPad))"/>
    </xsl:function>
    <xsl:function name="functx:repeat-string" as="xs:string">
        <xsl:param name="stringToRepeat" as="xs:string?"/>
        <xsl:param name="count" as="xs:integer"/>
        <xsl:sequence select="string-join((for $i in 1 to $count return $stringToRepeat), '')"/>
    </xsl:function>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <p>Extracts data from a single Brief TEI nodeset and outputs as an HTML table</p>
        </desc>
    </doc>
    <xsl:template match="/">
        <br/>
        <table style="width: 100%" border="0">
            <thead>
                <tr>
                    <th width="5%"/>
                    <th width="5%"/>
                    <th width="90%"/>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <xsl:variable name="id">
                        <xsl:value-of select="/TEI/teiHeader/profileDesc/textClass/classCode[@scheme='RegNr']/idno"/>
                    </xsl:variable>
                    <td>
                        <xsl:variable name="previous">
                            <xsl:value-of select="number($id) -1"/>
                        </xsl:variable>
                        <a href="./{functx:pad-integer-to-length($previous, 4)}">
                            <img alt="vorherige Seite" title="vorherige Seite" src="/exist/apps/blumenbach/resources/images/pageprev.gif"/>
                        </a>
                    </td>
                    <td>
                        <xsl:variable name="next">
                            <xsl:value-of select="number($id) + 1"/>
                        </xsl:variable>
                        <a href="./{functx:pad-integer-to-length($next, 4)}">
                            <img alt="nächste Seite" title="nächste Seite" src="/exist/apps/blumenbach/resources/images/pagenext.gif"/>
                        </a>
                    </td>
                    <td/>
                </tr>
            </tbody>
        </table>
        <table style="width: 100%" border="1">
            <thead>
                <tr>
                    <th width="10%">Meta Element</th>
                    <th width="90%">Value</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Register #:</td>
                    <td>
                        <xsl:value-of select="/TEI/teiHeader/profileDesc/textClass/classCode[@scheme='RegNr']/idno"/>
                    </td>
                </tr>
                <tr>
                    <td>Title:</td>
                    <td>
                        <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title[@type='source']"/>
                    </td>
                </tr>
                <tr>
                    <td>Absender:</td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="/TEI/teiHeader/fileDesc/titleStmt/author/persName/surname/text()">
                                <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/author/persName/*"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/author/persName/text()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <tr>
                    <td>Empfanger:</td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="/TEI/teiHeader/profileDesc/creation/persName/surname/text()">
                                <xsl:value-of select="/TEI/teiHeader/profileDesc/creation/persName/*"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="/TEI/teiHeader/profileDesc/creation/persName/text()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <tr>
                    <td>Abfassungsdatum:</td>
                    <td>
                        <xsl:value-of select="/TEI/teiHeader/profileDesc/creation/origDate/note/listEvent/event[@type='origin']/@when"/>
                    </td>
                </tr>
                <tr>
                    <td>Abfassungsort:</td>
                    <td>
                        <xsl:value-of select="/TEI/teiHeader/profileDesc/creation/placeName"/>
                    </td>
                </tr>
                <tr>
                    <td>Überlieferung:</td>
                    <td>
                        <xsl:for-each select="/TEI/teiHeader/fileDesc/notesStmt/note[@type='Überlieferung']//text()">
                            <xsl:value-of select="."/>
                        </xsl:for-each>
                    </td>
                </tr>
                <tr>
                    <td>Drucke:</td>
                    <td>
                        <xsl:value-of select="/TEI/teiHeader/fileDesc/notesStmt/note[@type='Drucke']/bibl//text()"/>
                    </td>
                </tr>
                <tr>
                    <td>Edition:</td>
                    <td>
                        <xsl:value-of select="/TEI/teiHeader/fileDesc/notesStmt/note/bibl/edition//text()"/>
                    </td>
                </tr>
                <tr>
                    <td>Werke:</td>
                    <td>
                        <xsl:value-of select="/TEI/teiHeader/fileDesc/notesStmt/note[@type='Werke']/bibl//text()"/>
                    </td>
                </tr>
                <tr>
                    <td>Objekte:</td>
                    <td>
                        <xsl:value-of select="/TEI/teiHeader/fileDesc/notesStmt/note[@type='Objekte']//text()[not(ancestor::title)]"/>
                    </td>
                </tr>
                <tr>
                    <td>Anmerkung:</td>
                    <td>
                        <xsl:value-of select="/TEI/teiHeader/fileDesc/notesStmt/note[@type='Anmerkung']//text()[not(ancestor::title)]"/>
                    </td>
                </tr>
                <xsl:for-each select="/TEI/teiHeader/fileDesc/notesStmt/note/ref">
                    <tr>
                        <td>References:</td>
                        <td>
                            <xsl:if test="./@type='html'">
                                <xsl:value-of select="."/>
                            </xsl:if>
                            <xsl:if test="./@type='pdf'">
                                <xsl:value-of select="."/>
                            </xsl:if>
                        </td>
                    </tr>
                </xsl:for-each>
                <xsl:for-each select="/TEI/teiHeader/fileDesc/notesStmt/note/rs">
                    <tr>
                        <td>Ref Labels:</td>
                        <td>
                            <xsl:if test="./@type='html'">
                                <xsl:value-of select="."/>
                            </xsl:if>
                            <xsl:if test="./@type='pdf'">
                                <xsl:value-of select="."/>
                            </xsl:if>
                        </td>
                    </tr>
                </xsl:for-each>
                <tr>
                    <td>TEI Description:</td>
                    <td>
                        <table>
                            <tr>
                                <td>File Name:</td>
                                <td>
                                    <xsl:value-of select="/TEI/teiHeader/fileDesc/publicationStmt/idno"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Revision Description:</td>
                                <td>
                                    <xsl:value-of select="/TEI/teiHeader/revisionDesc/change"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Project Responsible:</td>
                                <td>
                                    <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/respStmt/orgName[@resp = 'proj']"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Encoding Responsible:</td>
                                <td>
                                    <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/respStmt/persName[@resp = 'enc']"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>