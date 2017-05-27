<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:saxon="http://saxon.sf.net/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:so="http://standoff.proposal" extension-element-prefixes="saxon" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
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
    <xsl:template match="node() | @*" name="identity">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="lb">
        <br xmlns="http://www.w3.org/1999/xhtml"/>
    </xsl:template>
    <xsl:template match="so:annotations">
        <br/>
        <table border="1" width="100%">
            <thead>
                <tr>
                    <th width="10%" align="left">Statement #</th>
                    <th width="90%" align="left">Value</th>
                </tr>
            </thead>
            <xsl:for-each select="/TEI/so:stdf/so:annotations/spanGrp">
                <tr>
                    <td>
                        <xsl:variable name="pos" select="position()"/>
                        <xsl:value-of select="$pos"/>
                    </td>
                    <td>
                        <table width="100%">
                            <thead>
                                <tr>
                                    <th width="20%" align="left">Meta Element</th>
                                    <th width="80%" align="left">Value</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="./span">
                                    <tr>
                                        <td>
                                            <xsl:value-of select="./@type"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select="."/>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <p>Extracts data from a single Werk TEI nodeset and outputs as an HTML table</p>
            <p>Also includes matching ID XML fragment from external file</p>
        </desc>
    </doc>
    <xsl:template match="teiHeader">
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
                        <xsl:value-of select="/TEI/teiHeader/profileDesc/textClass/classCode[@scheme='BiblNr']"/>
                    </xsl:variable>
                    <td>
                        <xsl:variable name="previous">
                            <xsl:value-of select="number($id) -1"/>
                        </xsl:variable>
                        <a href="./{functx:pad-integer-to-length($previous, 5)}">
                            <img alt="vorherige Seite" title="vorherige Seite" src="/exist/apps/blumenbach/resources/images/pageprev.gif"/>
                        </a>
                    </td>
                    <td>
                        <xsl:variable name="next">
                            <xsl:value-of select="number($id) + 1"/>
                        </xsl:variable>
                        <a href="./{functx:pad-integer-to-length($next, 5)}">
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
                    <th width="10%" align="left">Meta Element</th>
                    <th width="90%" align="left">Value</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <xsl:variable name="biblnr">
                        <xsl:value-of select="./profileDesc/textClass/classCode[@scheme='BiblNr']"/>
                    </xsl:variable>
                    <xsl:variable name="fragment">
                        <xsl:value-of select="concat('ck_source_', $biblnr)"/>
                    </xsl:variable>
                    <td>                            
                        Original Text of <xsl:value-of select="$biblnr"/>
                    </td>
                    <td>
                        <xsl:element name="xi:include">
                            <xsl:attribute name="href">/db/apps/blumenbach/data/ck-source/werke-2015-05-15.xml</xsl:attribute>
                            <xsl:attribute name="xpointer">
                                <xsl:value-of select="$fragment"/>
                            </xsl:attribute>
                        </xsl:element>
                    </td>
                </tr>
                <tr>
                    <td>Bibliographie #:</td>
                    <td>
                        <xsl:value-of select="./profileDesc/textClass/classCode[@scheme='BiblNr']"/>
                    </td>
                </tr>
                <tr>
                    <td>Class:</td>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <xsl:for-each select="./profileDesc/textClass/classCode[@scheme='cat']/idno">
                                        <xsl:value-of select="."/>
                                        <br/>
                                    </xsl:for-each>
                                </td>
                                <td>
                                    <xsl:for-each select="./profileDesc/textClass/classCode[@scheme='cat']">
                                        <xsl:value-of select="./text()"/>
                                        <br/>
                                    </xsl:for-each>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <xsl:if test="./fileDesc/sourceDesc/biblStruct/analytic/title">
                    <tr>
                        <td>Titel (analytic):</td>
                        <td>
                            <xsl:for-each select="./fileDesc/sourceDesc/biblStruct/analytic/title">
                                <xsl:value-of select="."/>
                                <br/>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>
                <tr>
                    <td>Titel (monograph):</td>
                    <td>
                        <xsl:for-each select="./fileDesc/sourceDesc/biblStruct/monogr/title">
                            <xsl:value-of select="."/>
                            <br/>
                        </xsl:for-each>
                    </td>
                </tr>
                <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/edition">
                    <tr>
                        <td>Edition:</td>
                        <td>
                            <xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/edition"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher">
                    <tr>
                        <td>Publication Place: </td>
                        <td>
                            <xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/pubPlace"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Publisher: </td>
                        <td>
                            <xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/publisher"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']">
                    <tr>
                        <td>Publication Date: </td>
                        <td>
                            <xsl:value-of select="./fileDesc/sourceDesc/biblStruct/monogr/imprint/date[@type='publication']/@when"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent/text()">
                    <tr>
                        <td>Extent:</td>
                        <td>
                            <xsl:value-of select="./fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent/text()"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent/dimensions/dim/text()">
                    <tr>
                        <td>Dimensions:</td>
                        <td>
                            <xsl:value-of select="./fileDesc/sourceDesc/msDesc/physDesc/objectDesc/supportDesc/extent/dimensions/dim"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./fileDesc/sourceDesc/biblStruct/series">
                    <tr>
                        <td>Series:</td>
                        <td>
                            <xsl:value-of select="./fileDesc/sourceDesc/biblStruct/series"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./fileDesc/sourceDesc/msDesc/msIdentifier/repository">
                    <tr>
                        <td>Repository:</td>
                        <td>
                            <xsl:value-of select="./fileDesc/sourceDesc/msDesc/msIdentifier/repository"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./fileDesc/sourceDesc/msDesc/msIdentifier/idno">
                    <tr>
                        <td>MS Signature:</td>
                        <td>
                            <xsl:value-of select="./fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./fileDesc/notesStmt/note[@type='ref']">
                    <tr>
                        <td>Online Resources:</td>
                        <td>
                            <xsl:for-each select="./fileDesc/notesStmt/note[@type='ref']">
                                <xsl:value-of select="."/>
                                <br/>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="/TEI/so:stdf/so:annotations/spanGrp">
                    <xsl:apply-templates select="so:annotations"/>
                </xsl:if>
                <tr>
                    <td>TEI Description:</td>
                    <td>
                        <table>
                            <tr>
                                <td>File Name:</td>
                                <td>
                                    <xsl:value-of select="./fileDesc/publicationStmt/idno"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Revision Description:</td>
                                <td>
                                    <xsl:value-of select="./revisionDesc/change"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Project Responsible:</td>
                                <td>
                                    <xsl:value-of select="./fileDesc/titleStmt/respStmt/orgName[@resp = 'proj']"/>
                                </td>
                            </tr>
                            <tr>
                                <td>Encoding Responsible:</td>
                                <td>
                                    <xsl:value-of select="./fileDesc/titleStmt/respStmt/persName[@resp = 'enc']"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>