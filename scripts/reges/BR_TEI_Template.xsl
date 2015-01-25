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
            <notesStmt>
                        <note type="Überlieferung"><xsl:value-of select="biblScope"/></note>                
                        <xsl:if test="note">
                            <note type="Anmerkung">
                               <xsl:choose>
                                    <xsl:when test="note/emph">
                                        <xsl:for-each select="note/emph">
                                            <title level="m" type="main"><xsl:value-of select="."/></title>
                                         </xsl:for-each>   
                                        <xsl:value-of select="note"/>
                                    </xsl:when> 
                                    <xsl:otherwise>
                                        <xsl:value-of select="note"/>    
                                    </xsl:otherwise>
                               </xsl:choose>                                
                                <xsl:value-of select="note"/></note>
                        </xsl:if>
                        <xsl:if test="object">
                            <note type="Objekte">
                               <xsl:choose>
                                    <xsl:when test="object/emph">
                                        <xsl:for-each select="object/emph">
                                            <title level="m" type="main"><xsl:value-of select="."/></title>
                                         </xsl:for-each>   
                                        <xsl:value-of select="object"/>
                                    </xsl:when> 
                                    <xsl:otherwise>
                                        <xsl:value-of select="object"/>    
                                    </xsl:otherwise>
                               </xsl:choose>
                            </note>
                        </xsl:if> 
                        <xsl:if test="bibl">
                            <note type="Drucke">
                                <xsl:choose>
                                     <xsl:when test="bibl/emph"> 
                                      <title level="m" type="main"><xsl:value-of select="bibl/emph"/></title>   
                                        <xsl:value-of select="bibl"/>
                                     </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:value-of select="bibl"/>
                                    </xsl:otherwise>   
                                </xsl:choose>
                            </note>    
                         </xsl:if>  
                        <xsl:if test="Lit_in_Zusatzdaten">
                            <note type="Werke">
                                <xsl:choose>
                                    <xsl:when test="Lit_in_Zusatzdaten/emph">
                                        <title level="m" type="main"><xsl:value-of select="Lit_in_Zusatzdaten/emph"/></title>
                                        <xsl:value-of select="Lit_in_Zusatzdaten"/>
                                    </xsl:when> 
                                    <xsl:otherwise>
                                        <xsl:value-of select="Lit_in_Zusatzdaten"/>    
                                    </xsl:otherwise>
                                </xsl:choose>    
                            </note>    
                        </xsl:if>
                        <xsl:if test="relatedItem">
                            <note type="item">
                                <xsl:choose>
                                    <xsl:when test="relatedItem/emph">
                                        <title level="m" type="main"><xsl:value-of select="relatedItem/emph"/></title>
                                    <xsl:value-of select="relatedItem"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="Lit_in_Zusatzdaten"/>    
                                    </xsl:otherwise>
                                </xsl:choose>    
                            </note>
                        </xsl:if> 
                        <xsl:if test="ref">
                        <note type="ref">
                               <xsl:attribute name="xml:id">
                                    <xsl:value-of select="concat(name(),'_',generate-id())"/>
                               </xsl:attribute>
                                        <xsl:for-each select="ref">
                                            <xsl:if test="not(@type)">   
                                            <ref type="html" target="{@target}"></ref>
                                            </xsl:if>                                
                                            <xsl:if test="@type">
                                                <ref type="pdf" target="{@target}"></ref>    
                                            </xsl:if>  
                                        </xsl:for-each>
                                        <xsl:for-each select="link">
                                            <xsl:if test="not(./emph)">                                        
                                                <rs type="html"><xsl:value-of select="."/></rs>                                                                       
                                            </xsl:if>
                                            <xsl:if test="./emph">                                        
                                                <rs type="pdf"><xsl:value-of select="."/></rs>                                                                       
                                            </xsl:if>
                                        </xsl:for-each>   
                        </note>
                        </xsl:if>
                        <note type="Edition">
                            <xsl:choose>
                                 <xsl:when test="edition/emph"> 
                                  <title level="m" type="main"><xsl:value-of select="edition/emph"/></title>   
                                    <xsl:value-of select="edition"/>
                                 </xsl:when>
                                <xsl:otherwise>
                                  <xsl:value-of select="edition"/>
                                </xsl:otherwise>   
                            </xsl:choose>
                        </note>                
            </notesStmt>
            <sourceDesc>
                <bibl type="brief"></bibl>
                <biblFull>
                    <titleStmt>
                        <xsl:for-each select="title">
                        <title type="kurzdesc"><xsl:value-of select="substring(., 0, 80)"/>...</title>
                        <title type="langdesc">  
                        <xsl:choose>                             
                                <xsl:when test="./emph"><title level="m" type="sub"><xsl:value-of select="./emph"/></title>
                                    <xsl:value-of select="."/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="."/>  
                                </xsl:otherwise>                    
                         </xsl:choose>
                        </title>
                   </xsl:for-each>                             
                        <author>
                            <persName ref="http://d-nb.info/gnd/">
                                <xsl:choose>
                                <xsl:when test="author/forename or author/surname" >
                                    <forename><xsl:value-of select="author/forename"/></forename>
                                    <surname><xsl:value-of select="author/surname"/></surname>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="author"/>  
                                </xsl:otherwise>    
                                </xsl:choose>  
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
                <language ident="deu"></language>
            </langUsage>
            <calendarDesc>
                <calendar xml:id="julian-{$count}">
                    <p>Julian calendar (including proleptic)</p>
                </calendar>
                <calendar xml:id="ISO-{$count}">
                    <p>ISO 8601 calendar</p>
                </calendar>
            </calendarDesc>
            <creation>
                <persName resp="emp">                
                   <xsl:choose>
                       <xsl:when test="receiver/forename or receiver/surname" >
                           <forename><xsl:value-of select="receiver/forename"/></forename>
                           <surname><xsl:value-of select="receiver/surname"/></surname>
                       </xsl:when>
                       <xsl:otherwise>
                           <xsl:value-of select="receiver"/>  
                       </xsl:otherwise>    
                   </xsl:choose> 
                </persName>                
                <origDate>
                <note type="Abfassungsevent"> 
              <xsl:if test="altdate">
                <listEvent>
                    <event type="iso-origin" datingMethod="#ISO" sortKey="{altdate}" when="{altdate}" where="#orgplc-{$count}">
                        <label>Abfassungsdatum</label>
                        <note type="Abfassungsdatum"><date when="{altdate}"><xsl:value-of select="date"/>
                        <xsl:if test="precision"><precision precision="unknown"/></xsl:if>
                        </date></note> 
                    </event>                                  
                </listEvent>
                </xsl:if>
                <xsl:if test="notbefore">
                <listEvent>
                    <event type="iso-origin" datingMethod="#ISO" sortKey="{notbefore}" notBefore="{notbefore}" where="#orgplc-{$count}">
                        <label>Abfassungsdatum (not before):</label>
                        <note type="Abfassungsdatum"><date when="{notbefore}"><xsl:value-of select="date"/>
                        <xsl:if test="precision"><precision precision="unknown"/></xsl:if>
                        </date></note>                         
                    </event>
                 </listEvent>                    
                 </xsl:if>                
                 <xsl:if test="notafter">
                 <listEvent>
                     <event type="iso-origin" datingMethod="#ISO" sortKey="{notafter}" notAfter="{notafter}" where="#orgplc-{$count}">
                         <label>Abfassungsdatum (not after):</label>
                        <note type="Abfassungsdatum"><date when="{notafter}"><xsl:value-of select="date"/>
                        <xsl:if test="precision"><precision precision="unknown"/></xsl:if>
                        </date></note>                          
                     </event>                     
                 </listEvent>                  
                 </xsl:if>  
                <xsl:if test="julian">
                    <listEvent>
                        <event type="julian-origin" datingMethod="#julian" when="{julian}" where="#orgplc">
                            <label>Abfassungsdatum (julian):</label>
                        <note type="Abfassungsdatum"><date when="{julian}"><xsl:value-of select="date"/>
                        <xsl:if test="precision"><precision precision="unknown"/></xsl:if>
                        </date></note>                            
                        </event>
                    </listEvent>                   
                </xsl:if>
                </note>
                </origDate>
                <placeName xml:id="orgplc-{$count}" type="Abfassungsort"><xsl:value-of select="place"/></placeName>
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
