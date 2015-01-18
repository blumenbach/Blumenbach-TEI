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
                                <xsl:value-of select="./title[@type='main']"/>
                                </title>
                                <author>
                                    <persName ref="http://viaf.org/viaf/71570755">Blumenbach, Johann Friedrich‏</persName>
                                </author>
                                <editor>
                                    <persName ref="http://viaf.org/viaf/">
                                        <surname></surname>
                                        <forename></forename>
                                    </persName>
                                </editor>
                                <respStmt>
                                   <orgName>Akademie der Wissenschaften zu Göttingen</orgName>
                                   <resp key="proj">Projektträger<ref target="http://adw-goe.de/"/></resp>
                                </respStmt>
                                <respStmt>
                                   <orgName>Bearbeiter des Projekts Johann Friedrich Blumenbach Online</orgName>
                                   <resp key="arb">Bearbeitung<ref target="http://www.blumenbach-online.de/"/></resp>
                                   <resp key="enc">XML Encoding<persName>Christopher Hanna Johnson</persName></resp>
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
                        <sourceDesc>
                           <biblStruct>
                               <monogr>                                   
                                   <xsl:if test="./title[@type='main'] and ./title[@level='m']"><title level="m" type="main"><xsl:value-of select="./title[@type='main']"/></title></xsl:if>                                  
                                   <xsl:if test="./title[@type='sub'] and ./title[@level='m']">
                                       <xsl:for-each select="title[@type='sub']">
                                            <title level="m" type="sub"><xsl:value-of select=".[@type='sub']"/></title>
                                       </xsl:for-each>
                                   </xsl:if>                                                              
                                   <xsl:if test="./title[@type='aut'] and ./title[@level='m']"><title level="m" type="aut"><xsl:value-of select="./title[@type='aut']"/></title></xsl:if>                        
                                   <xsl:if test="./title[@type='ed'] and ./title[@level='m']"><title level="m" type="ed"><xsl:value-of select="./title[@type='ed']"/></title></xsl:if>                                    
                                   <author>
                                       <persName ref="http://viaf.org/viaf/71570755">Blumenbach, Johann Friedrich‏</persName>
                                   </author>
                                   <xsl:if test="./edition"><edition><xsl:value-of select="./edition"/></edition></xsl:if>
                                   <editor>
                                       <persName ref="http://viaf.org/viaf"><xsl:value-of select="editor"/></persName>
                                   </editor>
                                <imprint>
                                    <publisher><name><xsl:value-of select="publisher"/></name></publisher>
                                    <pubPlace><xsl:value-of select="pubPlace"/></pubPlace>
                                    <date type="publication"><xsl:value-of select="date"/></date>
                                </imprint>
                               </monogr>
                               <xsl:if test="note">
                                   <xsl:for-each select="note">
                                       <note><xsl:value-of select="."/></note>                                          
                                   </xsl:for-each>                     
                               </xsl:if>
                               <xsl:if test="link">
                                    <xsl:for-each select="link">                                       
                                           <note>
                                               <ref><xsl:value-of select="."/></ref> 
                                           </note>  
                                    </xsl:for-each>                     
                               </xsl:if> 
                               
                               <xsl:for-each select="relatedItem">
                               <relatedItem>
                                   <xsl:if test="not(attribute::xml:id)">
                                       <xsl:attribute name="xml:id">
                                           <xsl:value-of select="concat(name(),'_',generate-id())"/>
                                       </xsl:attribute>
                                   </xsl:if> 
                                   <biblStruct>                                                                     
                                   <xsl:if test="analytic">                                         
                                       <analytic>                                             
                                           <xsl:choose>
                                               <xsl:when test="./analytic/title[@level='a']">
                                                   <xsl:if test="./analytic/title[@type='main']"><title level="a" type="main"><xsl:value-of select="./analytic/title[@type='main']"/></title></xsl:if>
                                                   <xsl:if test="./analytic/title[@type='sub']"><title level="a" type="sub"><xsl:value-of select="./analytic/title[@type='sub']"/></title></xsl:if>
                                                   <xsl:if test="./analytic/title[@type='aut']"><title level="a" type="aut"><xsl:value-of select="./analytic/title[@type='aut']"/></title></xsl:if>
                                                   <xsl:if test="./analytic/title[@type='ed']"><title level="a" type="ed"><xsl:value-of select="./analytic/title[@type='ed']"/></title></xsl:if>
                                               </xsl:when>  
                                           </xsl:choose> 
                                           <xsl:if test="./analytic/extent"><extent><xsl:value-of select="./analytic/extent"/></extent> </xsl:if>
                                       </analytic>
                                       <xsl:if test="./analytic/citedRange"><citedRange><xsl:value-of select="./analytic/citedRange"/></citedRange></xsl:if>                                                                  
                                       <xsl:if test="note">
                                           <xsl:for-each select="note">
                                               <note><xsl:value-of select="."/></note>
                                           </xsl:for-each>   
                                       </xsl:if>                                               
                                   </xsl:if>  
                                   <xsl:if test="monogr">                                       
                                       <monogr>
                                           <xsl:choose>
                                           <xsl:when test="./monogr/title[@level='m']">
                                           <xsl:if test="./monogr/title[@type='main']"><title level="m" type="main"><xsl:value-of select="./monogr/title[@type='main']"/></title></xsl:if>                                  
                                               <xsl:if test="./monogr/title[@type='sub'] and ./monogr/title[@level='m']">
                                                   <xsl:for-each select="./monogr/title[@type='sub']">
                                                       <title level="m" type="sub"><xsl:value-of select=".[@type='sub']"/></title>
                                                   </xsl:for-each>
                                               </xsl:if>                                                               
                                           <xsl:if test="./monogr/title[@type='aut']"><title level="m" type="aut"><xsl:value-of select="./monogr/title[@type='aut']"/></title></xsl:if>                        
                                           <xsl:if test="./monogr/title[@type='ed']"><title level="m" type="ed"><xsl:value-of select="./monogr/title[@type='ed']"/></title></xsl:if>
                                               <xsl:if test="./monogr/title[@type='profile']"><title level="m" type="pro"><xsl:value-of select="./monogr/title[@type='profile']"/></title></xsl:if>
                                               <imprint>
                                                   <publisher><name><xsl:value-of select="./monogr/publisher"/></name></publisher>
                                                   <pubPlace><xsl:value-of select="./monogr/pubPlace"/></pubPlace>
                                                   <date type="publication"><xsl:value-of select="./monogr/date"/></date>
                                               </imprint> 
                                           </xsl:when>
                                           <xsl:otherwise>
                                               <xsl:if test="./monogr/title[@type='main']"><title level="j" type="main"><xsl:value-of select="./monogr/title[@type='main']"/></title></xsl:if>                                                       
                                               <xsl:if test="./monogr/title[@type='aut']"><title level="j" type="main"><xsl:value-of select="./monogr/title[@type='aut']"/></title></xsl:if>
                                               <xsl:if test="./monogr/title[@level='j']">
                                                   <imprint>
                                                       <publisher></publisher>
                                                       <pubPlace></pubPlace>
                                                       <date></date>  
                                                   </imprint>   
                                                   <biblScope><xsl:value-of select="./monogr/biblScope"/></biblScope>
                                               </xsl:if>        
                                           </xsl:otherwise>    
                                           </xsl:choose>      
                                           <xsl:if test="./monogr/extent"><extent><xsl:value-of select="./monogr/extent"/></extent> </xsl:if>
                                       </monogr>
                                       <xsl:if test="./citedRange"><citedRange><xsl:value-of select="./citedRange"/></citedRange></xsl:if> 
                                       <xsl:if test="./ref/note">
                                           <ref><note><xsl:value-of select="./ref/note"/></note> </ref>
                                       </xsl:if> 
                                       <ref><xsl:value-of select="./reference"/></ref>                      
                                         <xsl:if test="note">
                                            <xsl:for-each select="note">
                                                <note><xsl:value-of select="."/></note>
                                             </xsl:for-each>   
                                         </xsl:if>
                              
                                         <xsl:for-each select="current()/relatedItem">
                                             <relatedItem>
                                                 <biblStruct>
                                                    <xsl:if test="monogr">                                                   
                                                        <monogr>                                                
                                                        <xsl:choose>
                                                            <xsl:when test="./monogr/title[@level='m']">
                                                                <xsl:if test="./monogr/title[@type='main']"><title level="m" type="main"><xsl:value-of select="./monogr/title[@type='main']"/></title></xsl:if>                                  
                                                                <xsl:if test="./monogr/title[@type='sub'] and ./monogr/title[@level='m']">
                                                                    <xsl:for-each select="./monogr/title[@type='sub']">
                                                                        <title level="m" type="sub"><xsl:value-of select=".[@type='sub']"/></title>
                                                                     </xsl:for-each>
                                                                </xsl:if>                                                               
                                                                <xsl:if test="./monogr/title[@type='aut']"><title level="m" type="aut"><xsl:value-of select="./monogr/title[@type='aut']"/></title></xsl:if>                        
                                                                <xsl:if test="./monogr/title[@type='ed']"><title level="m" type="ed"><xsl:value-of select="./monogr/title[@type='ed']"/></title></xsl:if>
                                                                <xsl:if test="./monogr/title[@type='profile']"><title level="m" type="pro"><xsl:value-of select="./monogr/title[@type='profile']"/></title></xsl:if>
                                                             <imprint>
                                                                <publisher><name><xsl:value-of select="./monogr/publisher"/></name></publisher>
                                                                <pubPlace><xsl:value-of select="./monogr/pubPlace"/></pubPlace>
                                                                <date type="publication"><xsl:value-of select="./monogr/date"/></date>
                                                             </imprint> 
                                                            </xsl:when>
                                                            <xsl:otherwise >                                                       
                                                               <xsl:if test="./monogr/title[@type='main']"><title level="j" type="main"><xsl:value-of select="./monogr/title[@type='main']"/></title></xsl:if>                                                       
                                                               <xsl:if test="./monogr/title[@type='aut']"><title level="j" type="main"><xsl:value-of select="./monogr/title[@type='aut']"/></title></xsl:if>
                                                               <xsl:if test="./monogr/title[@level='j'] or ./monogr/title[@level='a']">
                                                                   <imprint>
                                                                       <publisher></publisher>
                                                                       <pubPlace></pubPlace>
                                                                       <date></date>  
                                                                   </imprint>   
                                                                   <biblScope><xsl:value-of select="./monogr/biblScope"/></biblScope>
                                                               </xsl:if>                                                        
                                                           </xsl:otherwise>     
                                                        </xsl:choose> 
                                                        <xsl:if test="./monogr/extent"><extent><xsl:value-of select="./monogr/extent"/></extent> </xsl:if>
                                                        </monogr>
                                                        <xsl:if test="./citedRange"><citedRange><xsl:value-of select="./citedRange"/></citedRange></xsl:if>
                                                        <xsl:if test="./ref/note">
                                                        <ref><note><xsl:value-of select="./ref/note"/></note></ref> 
                                                        </xsl:if> 
                                                        <ref><xsl:value-of select="./reference"/></ref>                      
                                                        <xsl:if test="note">
                                                          <xsl:for-each select="note">
                                                             <note><xsl:value-of select="."/></note>  
                                                          </xsl:for-each> 
                                                        </xsl:if>                                                      
                                                </xsl:if>
                                                </biblStruct> 
                                             </relatedItem>        
                                         </xsl:for-each>                               
                                   </xsl:if>
                                   </biblStruct>         
                               </relatedItem> 
                               </xsl:for-each> 
                            </biblStruct>    
                            <msDesc>
                                <msIdentifier>
                                    <repository><xsl:value-of select="repository"/></repository>
                                    <idno><xsl:value-of select="idno"/></idno>
                                </msIdentifier>
                                <physDesc>
                                    <objectDesc>
                                        <supportDesc>
                                            <extent><xsl:value-of select="extent"/>
                                                <dimensions>
                                                    <dim><xsl:value-of select="dimensions"/></dim>
                                                </dimensions>
                                            </extent>
                                        </supportDesc>  
                                    </objectDesc>                                        
                                    </physDesc>
                                <additional>
                                    <adminInfo>
                                        <recordHist>
                                            <source>
                                                <certainty locus="location"><desc><xsl:value-of select="source/certainty"/></desc></certainty>
                                            </source>
                                        </recordHist>                                        
                                        <note>
                                            <p><xsl:for-each select="msDesc"> <xsl:value-of select="./note"/> </xsl:for-each></p>
                                        </note>
                                </adminInfo>
                                </additional>
                            </msDesc>                             
                        </sourceDesc>             
                        </fileDesc>  
                        <profileDesc>
                            <langUsage>
                                <xsl:choose>
                                    <xsl:when test="language[@ident]">
                                        <xsl:for-each select="language">
                                    <language ident="{@ident}"></language>
                                        </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <language ident="de-DE"></language>   
                                </xsl:otherwise>    
                                </xsl:choose>    
                            </langUsage>
                            <textDesc>
                                <channel mode="w"/>
                                <constitution type="single"/>                                
                                    <xsl:choose>
                                        <xsl:when test="derivation[@type]">
                                            <xsl:for-each select="derivation">
                                        <derivation type="{@type}"></derivation>
                                            </xsl:for-each>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <derivation></derivation>
                                    </xsl:otherwise>                                 
                                    </xsl:choose>                                 
                                <domain type="academic"/>
                                <factuality></factuality>
                                <interaction></interaction>
                                <preparedness></preparedness>
                                <purpose></purpose>
                            </textDesc>
                            <textClass>
                                <classCode scheme="BiblNr"><xsl:value-of select="BiblNr"/></classCode>
                                <xsl:for-each select="category/catDesc">
                                    <classCode scheme="cat"><xsl:value-of select="."/></classCode>
                                </xsl:for-each>    
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