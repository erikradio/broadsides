<?xml version="1.0" encoding="UTF-8"?>
<!-- Deletes empty nodes in an xml document
Stolen from stack overflow by Erik Radio, KU Libraries, 10/14-->
    <xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="fn xs">
        <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
        <xsl:template match="node()|@*">
            <xsl:if test="normalize-space(string(.)) != ''">
                <xsl:copy>
                    <xsl:apply-templates select="node()|@*"/>
                </xsl:copy>
            </xsl:if>
        </xsl:template>
    
</xsl:stylesheet>