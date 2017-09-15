<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:csw="http://www.opengis.net/cat/csw/2.0.2"
                              xmlns:dct="http://purl.org/dc/terms/"
                              xmlns:ows="http://www.opengis.net/ows"
                              xmlns:dc="http://purl.org/dc/elements/1.1/"
                              xmlns:gmd="http://www.isotc211.org/2005/gmd"
                              xmlns:gco="http://www.isotc211.org/2005/gco"
                              exclude-result-prefixes="csw dc dct ows">
                              
   <xsl:output method="xml" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
   <xsl:template match="/">
   <xsl:choose>
      <!-- if CSW response returns some exception, do the following -->
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
         <Records>
            <xsl:attribute name="maxRecords">
               <xsl:value-of select="/csw:GetRecordsResponse/csw:SearchResults/@numberOfRecordsMatched"/>   
            </xsl:attribute>
               <xsl:for-each select="/csw:GetRecordsResponse/csw:SearchResults/csw:Record | /csw:GetRecordsResponse/csw:SearchResults/csw:BriefRecord | /csw:GetRecordByIdResponse/csw:Record | /csw:GetRecordsResponse/csw:SearchResults/csw:SummaryRecord">
                  <Record>
                     <ID>
                        <xsl:choose>
                           <xsl:when test="string-length(normalize-space(dc:identifier[@scheme='urn:x-esri:specification:ServiceType:ArcIMS:Metadata:DocID']/text())) > 0">
                              <xsl:value-of select="normalize-space(dc:identifier[@scheme='urn:x-esri:specification:ServiceType:ArcIMS:Metadata:DocID'])"/>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:value-of select="normalize-space(dc:identifier)"/>
                           </xsl:otherwise>
                        </xsl:choose>                 
                     </ID>
                     <Title>
                        <xsl:value-of select="dc:title"/>
                     </Title>
                     <Abstract>
                        <xsl:value-of select="dct:abstract"/>
                     </Abstract>
                     <Type>
                        <xsl:value-of select="dc:type"/>
                     </Type>
                     <!--each profile could have a different type of bounding box. Some of have two, some have four. This one has four -->
                     <LowerCorner>
                        <xsl:value-of select="ows:WGS84BoundingBox/ows:LowerCorner"/>
                     </LowerCorner>
                     <UpperCorner>
                        <xsl:value-of select="ows:WGS84BoundingBox/ows:UpperCorner"/>
                     </UpperCorner>
                     <MaxX>
                        <xsl:value-of select="normalize-space(substring-before(ows:WGS84BoundingBox/ows:UpperCorner,' '))"/>
                     </MaxX>
                     <MaxY>
                        <xsl:value-of select="normalize-space(substring-after(ows:WGS84BoundingBox/ows:UpperCorner,' '))"/>
                     </MaxY>
                     <MinX>
                        <xsl:value-of select="normalize-space(substring-before(ows:WGS84BoundingBox/ows:LowerCorner,' '))"/>
                     </MinX>
                     <MinY>
                        <xsl:value-of select="normalize-space(substring-after(ows:WGS84BoundingBox/ows:LowerCorner,' '))"/>
                     </MinY>
                     <ModifiedDate>
                        <xsl:value-of select="./dct:modified"/>
                     </ModifiedDate>
                  
                     <!-- 
                     used to extract any urls in the document. It gets the urls and the scheme attribute (@scheme, which determines their type
                    (type of url it is (thumbnail, website, server, contact, etc. urls)). We always choose the "server" url when we add to map.
                     -->
                     <References>
                        <xsl:for-each select="./dct:references">
                           <xsl:value-of select="."/>
                           <xsl:text>&#x2714;</xsl:text>
                           <xsl:value-of select="@scheme"/>
                           <xsl:text>&#x2715;</xsl:text>
                        </xsl:for-each>
                     </References>
               
                     <!-- this extracts content type information. Can be used to highlight add to map button-->
                     <Types>
                        <xsl:for-each select="./dc:type">
                           <xsl:value-of select="."/>
                           <xsl:text>&#x2714;</xsl:text>
                           <xsl:value-of select="@scheme"/>
                           <xsl:text>&#x2715;</xsl:text>
                        </xsl:for-each>
                     </Types>
                  </Record>
               </xsl:for-each>
            </Records>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>
