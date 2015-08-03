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
	home page

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
		
	<xsl:template name="home_page">
		
		<div class="container">
		
			<xsl:call-template name="promo" />
				
			<div class="row">
			
				<div class="col-sm-4">
				
					<xsl:call-template name="browser" />
					
					<h2><i18n:text catalogue="default">xmlui.ArtifactBrowser.CommunityBrowser.head</i18n:text></h2>
					
					<ul>
						<xsl:for-each select="alchemy/communities/community/mets:METS">
							<li>
								<xsl:variable name="url">
									<xsl:text>handle/</xsl:text>
									<xsl:value-of select="substring-after(@ID,'hdl:')" />
								</xsl:variable>
								
								<a href="{$url}">
									<xsl:value-of select="mets:dmdSec/mets:mdWrap/mets:xmlData/dim:dim/dim:field[@mdschema='dc' and @element='title']" />
								</a>
							</li>
						</xsl:for-each>
					</ul>
				
				</div>
				<div class="col-sm-8">
					
					<h2>About Our Institutional Repository</h2>
					
					<p>
						DSpace is a digital service that collects, preserves, and distributes digital material. 
						Repositories are important tools for preserving an organization's legacy; they facilitate 
						digital preservation and scholarly communication.
					</p>
					
					<h2><i18n:text catalogue="default">xmlui.ArtifactBrowser.SiteViewer.head_recent_submissions</i18n:text></h2>
					
					<div class="results">
						<xsl:call-template name="brief_results" />
					</div>
					
				</div>
			</div>
			
		</div>
	
	</xsl:template>

	<xsl:template name="promo">
	
		<div class="promo">
			&nbsp;
		</div>
	
	</xsl:template>
	
</xsl:stylesheet>
