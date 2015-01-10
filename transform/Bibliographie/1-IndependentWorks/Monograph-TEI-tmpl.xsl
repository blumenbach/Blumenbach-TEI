<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:saxon="http://saxon.sf.net/"
    extension-element-prefixes="saxon"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="count" select="0" saxon:assignable="yes"/>    
    <xsl:template match="/">
        <xsl:for-each select="Bibliographie-1/biblStruct">
            <saxon:assign name="count" select="$count+1"/>
            <xsl:variable name="filename" select="concat('bibliographie/',$count,'.xml')" />
            <xsl:value-of select="$filename" />  
            <xsl:result-document href="{$filename}">    
                <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="de-DE">
                    <teiHeader>
                        <fileDesc>
                            <titleStmt><title type="main">
                                <xsl:for-each select="title">
                                    <xsl:if test="@type = 'main'"><xsl:value-of select="title"/></xsl:if>
                                </xsl:for-each></title>
                                <author>
                                    <persName ref="http://viaf.org/">
                                        <xsl:value-of select="author"/>
                                    </persName>
                                </author>
                                <editor>
                                    <persName ref="http://viaf.org/">
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
                                    <orgName>Bearbeiter des Projekts Johann Friedrich Blumenbach Online</orgName>
                                    <resp>
                                        <note type="remarkResponsibility">Bearbeitung</note>
                                        <ref target="http://www.blumenbach-online.de/"/>
                                    </resp>
                                </respStmt>
                            </titleStmt>
                            <publicationStmt>
                                <publisher>
                                    <email></email>
                                    <orgName></orgName>
                                    <address>
                                        <addrLine></addrLine>
                                        <country></country>
                                    </address>
                                </publisher>
                                <pubPlace></pubPlace> 
                                <date></date>
                                <availability>
                                    <licence>
                                        <p></p>
                                    </licence>
                                </availability>
                                <idno>
                                    <idno type="URLWeb"></idno>
                                    <idno type="URLXML"><xsl:value-of select="$filename"/></idno>
                                    <idno type="URLHTML"></idno>
                                    <idno type="URLText"></idno>
                                </idno>
                            </publicationStmt>
                        </fileDesc>                         
                        <sourceDesc>
                           <biblStruct>
                                <monogr>
                                    <title level="m" type="main"><xsl:for-each select="title">
                                        <xsl:if test="@type = 'main'"><xsl:value-of select="title"/></xsl:if>
                                    </xsl:for-each></title>
                                    <title level="m" type="sub"><xsl:for-each select="title">
                                        <xsl:if test="@type = 'sub'"><xsl:value-of select="title"/></xsl:if>
                                    </xsl:for-each></title>
                                    <title level="m" type="sub"><xsl:for-each select="title">
                                        <xsl:if test="@type = 'sub'"><xsl:value-of select="title"/></xsl:if>
                                    </xsl:for-each></title>
                                    <title level="m" type="ed"><xsl:for-each select="title">
                                        <xsl:if test="@type = 'ed'"><xsl:value-of select="title"/></xsl:if>
                                    </xsl:for-each></title>
                                    <author>
                                        <persName ref="http://viaf.org/">
                                            <xsl:value-of select="author"/>
                                        </persName>
                                    </author>
                                <imprint>
                                    <publisher><name><xsl:value-of select="publisher"/></name></publisher>
                                    <pubPlace><xsl:value-of select="pubPlace"/></pubPlace>
                                    <date type="publication"><xsl:value-of select="date"/></date>
                                </imprint>
                                <note><xsl:value-of select="note"/></note>
                                <note>
                                    <xsl:for-each select="link">
                                            <ref target="{link}"></ref>                                       
                                    </xsl:for-each>                     
                                </note>
                               </monogr>
                               <xsl:for-each select="relatedItem">
                                   <relatedItem><xsl:value-of select="relatedItem"/></relatedItem> 
                               </xsl:for-each> 
                            </biblStruct>        
                            <msDesc>
                                    <msIdentifier>
                                        <repository><xsl:value-of select="repository"/></repository>
                                        <idno><xsl:value-of select="idno"/></idno>
                                    </msIdentifier>
                                    <physDesc>
                                        <extent><xsl:value-of select="extent"/></extent>
                                        <dimension><xsl:value-of select="dimension"/></dimension>
                                        <note>
                                            <xsl:for-each select="msDesc"> <xsl:value-of select="note"/> </xsl:for-each> 
                                        </note>
                                    </physDesc>
                            </msDesc>
                           
                        </sourceDesc>             
                        
                        <profileDesc>
                            <langUsage>
                                <language ident="deu"></language>
                            </langUsage>
                            <textDesc>
                                <xsl:for-each select="derivation">
                                    <xsl:if test="@type">
                                        <derivation type="{@type}"></derivation>
                                    </xsl:if>
                                </xsl:for-each> 
                            </textDesc>
                            <textClass>
                                <classCode scheme="BiblNr"><xsl:value-of select="BiblNr"/></classCode>
                                <xsl:for-each select="catDesc">
                                    <classCode scheme="cat"><xsl:value-of select="catDesc"/></classCode>
                                </xsl:for-each>    
                                <classCode scheme=""></classCode>
                            </textClass>
                        </profileDesc>
                    </teiHeader>
                    <text>
                        <body>
                            <p></p>
                        </body>
                    </text>
                </TEI>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>  
</xsl:stylesheet>