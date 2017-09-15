<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                              xmlns:csw="http://www.opengis.net/cat/csw/2.0.2" 
                              xmlns:dct="http://purl.org/dc/terms/" 
                              xmlns:ows="http://www.opengis.net/ows"
                              xmlns:gmd="http://www.isotc211.org/2005/gmd"
                              xmlns:gco="http://www.isotc211.org/2005/gco"
                              exclude-result-prefixes="csw dct">

   <xsl:output method="text" indent="no" encoding="UTF-8"/> 


<xsl:template match="/"> 
   <xsl:choose>
      <xsl:when test="/ows:ExceptionReport">
         <exception>
            <exceptionText>
               <xsl:for-each select="/ows:ExceptionReport/ows:Exception">
                  <xsl:value-of select="ows:ExceptionText"/> 
               </xsl:for-each> 
            </exceptionText>
         </exception>
      </xsl:when> 
      <xsl:otherwise>
         <xsl:apply-templates select="//csw:Record/dct:references"/>
      </xsl:otherwise>
   </xsl:choose>       
</xsl:template>

<xsl:template match="//csw:Record/dct:references"> 
   <xsl:value-of select="."/>
   <xsl:text>&#x2714;</xsl:text>
   <xsl:value-of select="@scheme"/>
   <xsl:text>&#x2715;</xsl:text>
</xsl:template>
</xsl:stylesheet>
