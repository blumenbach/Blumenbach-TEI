<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:saxon="http://saxon.sf.net/"
    extension-element-prefixes="saxon"
    version="2.0">
<xsl:output method="xml" indent="yes"/>
<xsl:variable name="count" select="0" saxon:assignable="yes"/>    
<xsl:template match="/">
<xsl:for-each select="BR/record">
<saxon:assign name="count" select="$count+1"/>
<xsl:variable name="filename" select="concat('briefregesten/',$count,'.xml')" />
<xsl:value-of select="$filename" />  
<xsl:result-document href="{$filename}">    
      <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="de-DE">
    <teiHeader>
            <fileDesc>
            <titleStmt><title type="main"><xsl:value-of select="title"/></title>
                <author>
                    <persName ref="http://d-nb.info/gnd/">
                        <xsl:value-of select="author"/>
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
                <pubPlace><xsl:value-of select="place"/></pubPlace>
                <xsl:if test="notbefore">
                   <date type="publication" when="{notbefore}"><xsl:value-of select="date"/></date>
                </xsl:if>    
                <xsl:if test="notafter">
                   <date type="publication" when="{notafter}"><xsl:value-of select="date"/></date>
                </xsl:if>  
                <xsl:if test="altdate">
                    <date type="publication" when="{altdate}"><xsl:value-of select="date"/></date>
                </xsl:if>                 
                <availability>
                    <licence>
                        <p></p>
                    </licence>
                </availability>
                <idno>
                    <idno type="URLWeb"></idno>
                    <idno type="URLXML"></idno>
                    <idno type="URLHTML"></idno>
                    <idno type="URLText"></idno>
                </idno>
            </publicationStmt>
            <seriesStmt>
                <title></title>
                <respStmt>
                    <resp>ed. by</resp>
                    <name></name>
                </respStmt>
                <biblScope unit="volume"><xsl:value-of select="Zusatzdaten"/><xsl:value-of select="edition"/></biblScope>
                <idno type="ISSN"></idno>
            </seriesStmt>
            <notesStmt>
                <note><xsl:value-of select="note"/></note>
                <note><rs type="object"><xsl:value-of select="object"/></rs></note>
                <note><rs type="span"><xsl:value-of select="span"/></rs></note>
                <note> <rs type="bibl"><xsl:value-of select="bibl"/></rs></note>
                <note> <rs type="lz"><xsl:value-of select="Lit_in_Zusatzdaten"/></rs></note>
                <note>
                        <xsl:for-each select="ref">
                            <xsl:if test="@target">
                        <ref target="{@target}"></ref>
                            </xsl:if>
                        </xsl:for-each>                     
                </note>
                <note><rs type="edition"><xsl:value-of select="link"/></rs></note>
            </notesStmt>
            <sourceDesc>
                <bibl type="brief"></bibl>
                <biblFull>
                    <titleStmt>
                        <title level="m" type="main"><xsl:value-of select="biblScope"/></title>
                        <author>
                            <persName ref="http://d-nb.info/gnd/">
                                <xsl:value-of select="author"/>
                            </persName>
                        </author>
                    </titleStmt>
                    <publicationStmt>
                        <publisher><name></name></publisher>
                        <pubPlace></pubPlace>
                        <date type="publication"></date>
                    </publicationStmt>
                </biblFull> 
                
                    <xsl:if test="notbefore">
                        <listEvent>
                        <event type="origin" notBefore="{notbefore}">
                            <label><xsl:value-of select="date"/></label>
                        </event>
                        </listEvent>    
                    </xsl:if>
                
                    <xsl:if test="notafter">
                        <listEvent>
                        <event type="origin" notAfter="{notafter}">
                            <label><xsl:value-of select="date"/></label>
                        </event>
                        </listEvent>
                    </xsl:if>                
                
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
                <language ident="deu"></language>
            </langUsage>
            <creation>
                <persName type="addressee">
                    <xsl:value-of select="receiver"/>
                </persName>
            </creation>
            <textClass>
                <classCode scheme="RegNr"><xsl:value-of select="RegNr"/></classCode>
                <classCode scheme="anchor"><xsl:value-of select="anchor"/></classCode>
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
