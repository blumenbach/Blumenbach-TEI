<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" indent="yes"/>
<xsl:template match="/">
<TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="de-DE">
    <teiHeader>
        <xsl:for-each select="record">
        <fileDesc>
            <titleStmt><title type="main"><xsl:value-of select="title"/></title>
                <author>
                    <persName ref="http://d-nb.info/gnd/">
                        <surname></surname>
                        <forename></forename>
                    </persName>
                </author>
                <editor>
                    <persName ref="http://d-nb.info/gnd/">
                        <surname></surname>
                        <forename></forename>
                    </persName>
                </editor>
                <respStmt>
                    <orgName>Akademie der Wissenschaften zu Göttingen</orgName>
                    <resp>
                        <note type="remarkResponsibility">Projektträger</note>
                        <ref target="http://adw-goe.de/"/>
                    </resp>
                </respStmt>
                <respStmt>
                    <orgName>Bearbeiter des Projekts Johann Friedrich Blumenbach &#x2013; online</orgName>
                    <resp>
                        <note type="remarkResponsibility">Bearbeitung</note>
                        <ref target="http://www.blumenbach-online.de/"/>
                    </resp>
                </respStmt>
            </titleStmt>
            <publicationStmt>
                <publisher xml:id="">
                    <email></email>
                    <orgName role=""></orgName>
                    <address>
                        <addrLine></addrLine>
                        <country></country>
                    </address>
                </publisher>
                <pubPlace></pubPlace>
                <date type="publication"></date>
                <availability>
                    <licence target="">
                        <p></p>
                    </licence>
                </availability>
                <idno>
                    <idno type="URLWeb"></idno>
                    <idno type="URLXML"></idno>
                    <idno type="URLHTML"></idno>
                    <idno type="URLText"></idno>
                    <idno type="JFBODirName"></idno>
                    <idno type="JFBBOID"></idno>
                </idno>
            </publicationStmt>
            <sourceDesc>
                <bibl type="M"></bibl>
                <biblFull>
                    <titleStmt>
                        <title level="m" type="main"></title>
                        <author>
                            <persName ref="http://d-nb.info/gnd/">
                                <surname></surname>
                                <forename></forename>
                            </persName>
                        </author>
                    </titleStmt>
                    <publicationStmt>
                        <publisher><name></name></publisher>
                        <pubPlace></pubPlace>
                        <date type="publication"></date>
                    </publicationStmt>
                </biblFull>
                <msDesc>
                    <msIdentifier>
                    </msIdentifier>
                    <physDesc>
                        <typeDesc>
                            <p></p>
                        </typeDesc>
                    </physDesc>
                </msDesc>
            </sourceDesc>
        </fileDesc>
        <profileDesc>
            <langUsage>
                <language ident="deu">German</language>
            </langUsage>
            <textClass>
                <classCode scheme=""></classCode>
                <classCode scheme=""></classCode>
                <classCode scheme=""></classCode>
            </textClass>
        </profileDesc>
        </xsl:for-each>
    </teiHeader>
</TEI>
</xsl:template>  
</xsl:stylesheet>
