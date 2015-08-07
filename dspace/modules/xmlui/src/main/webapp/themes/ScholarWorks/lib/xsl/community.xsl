<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
	<!ENTITY copy   "&#169;">
	<!ENTITY reg    "&#174;">
	<!ENTITY trade  "&#8482;">
	<!ENTITY mdash  "&#8212;">
	<!ENTITY ldquo  "&#8220;">
	<!ENTITY rdquo  "&#8221;"> 
	<!ENTITY pound  "&#163;">
	<!ENTITY yen    "&#165;">
	<!ENTITY euro   "&#8364;">
]>

<!--

    ALCHEMY THEME
	community

-->

<xsl:stylesheet xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
	xmlns:dri="http://di.tamu.edu/DRI/1.0/"
	xmlns:mets="http://www.loc.gov/METS/"
	xmlns:xlink="http://www.w3.org/TR/xlink/"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
	xmlns:dim="http://www.dspace.org/xmlns/dspace/dim"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:mods="http://www.loc.gov/mods/v3"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="i18n dri mets xlink xsl dim xhtml mods dc">

    <xsl:output indent="yes"/>
	
	<xsl:template name="community">
	
		<xsl:for-each select="variable/communities/community">
		
			<h1><xsl:value-of select="mets:METS//dim:dim/dim:field[@mdschema='dc' and @element='title']" /></h1>
			
			<h2><i18n:text catalogue="default">xmlui.ArtifactBrowser.CommunityViewer.head_sub_collections</i18n:text></h2>
			
			<ul>
				<xsl:for-each select="collections//dim:dim">
					<li>
						<a href="{../../../../@OBJID}"><xsl:value-of select="dim:field[@mdschema='dc' and @element='title']" /></a>
					</li>
				</xsl:for-each>
			</ul>
			
		</xsl:for-each>
	
	</xsl:template>
	
</xsl:stylesheet>
