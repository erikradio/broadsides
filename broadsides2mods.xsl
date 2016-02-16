<?xml version="1.0" encoding="UTF-8"?>
<!-- This stylesheet transforms Guatemalan broadsides MODS records into Luna schema.
Created by Erik Radio, KU Libraries, 2015-04-28-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:mods="http://www.loc.gov/mods/v3">
    <xsl:output method="xhtml" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <recordList xmlns="http://www.lunaimaging.com/xsd">
        
                    <xsl:apply-templates select="@*|node()"/>
        </recordList>
    </xsl:template>
    
    <xsl:template match="mods:mods">
        <xsl:for-each select=".">
            
            <xsl:variable name="eng">English</xsl:variable>
            <xsl:variable name="fre">French</xsl:variable>
            <xsl:variable name="ita">Italian</xsl:variable>
            <xsl:variable name="ger">German</xsl:variable>
            <xsl:variable name="spa">Spanish</xsl:variable>
            
            
            <xsl:variable name="nonsort" select="mods:titleInfo[1]/mods:nonSort"/>
            <xsl:variable name="title" select="mods:titleInfo[1]/mods:title"/>
            <xsl:variable name="subtitle" select="mods:titleInfo[1]/mods:subTitle"/>
            <xsl:variable name="namedates" select="mods:name/mods:namePart[@type='date']"/>
           
            
            
            <record type="MODS" xmlns="http://www.lunaimaging.com/xsd">
                
                
                
                <field xmlns="http://www.lunaimaging.com/xsd" type="Record ID">
                    
                    <xsl:value-of select="mods:recordInfo/mods:recordIdentifier"/>
                    
                </field>
                
              
                <fieldGroup type="titleInfo">
                    <field xmlns="http://www.lunaimaging.com/xsd" type="Title">
                        <xsl:for-each select="mods:titleInfo[1]">
                        
                        <xsl:choose>
                            <xsl:when test="count($nonsort)>0">
                                <xsl:value-of select="concat($nonsort,$title )"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$title"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        </xsl:for-each>
                    </field>
                    <xsl:if test="count($subtitle)>0">
                    <field xmlns="http://www.lunaimaging.com/xsd" type="subTitle">
                        <xsl:value-of select="$subtitle"/>
                    </field>
                    </xsl:if>
                </fieldGroup>
                
                
               
                <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="name">
                    <xsl:for-each select="mods:name">
                        
                           
                       
                                <field type="Creator">
                                    
                                    <xsl:value-of select="mods:namePart"/>
                                    
                                    
                                </field>
                    </xsl:for-each>
                </fieldGroup>
                
                <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Abstract_Description">
                    <field type="Abstract">
                        <xsl:value-of select="mods:abstract"/>
                    </field>
                </fieldGroup>
                
                
                
                <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Language">
                    
                        <field type="Language">
                            <xsl:choose>
                                <xsl:when test="mods:language/mods:languageTerm[@type='code']='spa'">
                                    <xsl:value-of select="$spa"/>
                                </xsl:when>
                                <xsl:when test="mods:language/mods:languageTerm[@type='code']='eng'">
                                    <xsl:value-of select="$eng"/>
                                </xsl:when>
                                <xsl:when test="mods:language/mods:languageTerm[@type='code']='ger'">
                                    <xsl:value-of select="$ger"/>
                                </xsl:when>
                                <xsl:when test="mods:language/mods:languageTerm[@type='code']='fre'">
                                    <xsl:value-of select="$fre"/>
                                </xsl:when>
                                <xsl:when test="mods:language/mods:languageTerm[@type='code']='ita'">
                                    <xsl:value-of select="$ita"/>
                                </xsl:when>
                            </xsl:choose>
                    
                        </field>
                </fieldGroup>
                
                <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Genre">
                    <field type="Genre">
                        <xsl:value-of select="mods:genre"/>
                    </field>
                </fieldGroup>
                
                
                
                <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="originInfo">
                    <field type="Date Issued">
                        <xsl:value-of select="mods:originInfo/mods:dateIssued[@encoding='marc']"/></field>
                    <field type="Place"><xsl:value-of select="mods:originInfo/mods:place/mods:placeTerm[@type='text']"/></field>
                    <field type="Publisher"><xsl:value-of select="mods:publisher"/></field>
                    <field type="Issuance"><xsl:value-of select="mods:originInfo/mods:issuance"/></field>
                    
                    
                </fieldGroup>
                
                
                <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Physical_Description">
                    <field type="Extent">
                        <xsl:value-of select="mods:physicalDescription/mods:extent"/>
                    </field>
                    <field type="Form">
                        <xsl:value-of select="mods:physicalDescription/mods:form"/>
                    </field>
                </fieldGroup>
                
                <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Misc_Note">
                    <field type="Note">
                        <xsl:value-of select="mods:note"/>
                    </field>
                </fieldGroup>
                
                <!-- <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Related_Items">
                <field type="Related_Item_Title">
                    <xsl:value-of select="relatedItem/titleInfo/title"/>
                </field>
            </fieldGroup>-->
                
                <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="ID">
                    <field type="Identifier">
                        <xsl:value-of select="mods:recordInfo/mods:recordIdentifier"/>
                    </field>
                </fieldGroup>
                
        <fieldGroup xmlns="http://www.lunaimaging.com/xsd" type="Subject">
            
            <xsl:for-each select="mods:subject/*">
            <field type="Subject">
                
                <xsl:value-of select="."/>
                
            </field>
            </xsl:for-each> 
            
        </fieldGroup>
                
            </record>
                
                
                
            
        </xsl:for-each>
        
    </xsl:template>
</xsl:stylesheet>
