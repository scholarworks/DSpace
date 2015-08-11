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
	
	<xsl:template name="collection">
		
		<h1>
			<xsl:value-of select="variable/collections/mets:METS//dim:dim/dim:field[@mdschema='dc' and @element='title']" />
			&nbsp;
		</h1>

		<xsl:choose>
			<xsl:when test="variable/results/mets:METS">
			
				<div class="search-box">
					<form action="{variable/collections/mets:METS/@OBJID}/discover" method="get">
						<input type="text" name="query" class="query" />
						<input type="submit" value="search" class="submit-button" />
					</form>
				</div>
				
				<h2><i18n:text catalogue="default">xmlui.ArtifactBrowser.CollectionViewer.head_recent_submissions</i18n:text></h2>
		
				<div class="results">
					<xsl:call-template name="brief_results" />
				</div>
				
				<xsl:call-template name="simple_pager" />
				
			</xsl:when>
			<xsl:otherwise>
		
				<p>There are currently no items in this collection.</p>
		
			</xsl:otherwise>
		</xsl:choose>
		
	
	</xsl:template>
		
	<xsl:template name="simple_pager">
	
		<xsl:variable name="previous_page" select="alchemy/results/previousPage" />
		<xsl:variable name="next_page" select="alchemy/results/nextPage" />
		
		<xsl:variable name="start" select="variable/results/start" />
		<xsl:variable name="end" select="variable/results/end" />
		<xsl:variable name="total" select="variable/results/total" />
		
		<xsl:if test="variable/results/start">
		
			<div class="browse-pager">
				<div class="row">
					<div class="col-sm-6">						
						<xsl:if test="not($start = 1)">
							<a class="btn btn-default" href="{$previous_page}">Previous</a>
						</xsl:if>
						&nbsp;
					</div>
					<div class="col-sm-6">
						<div style="text-align: right">
							&nbsp;
							<xsl:if test="not($end = $total)">
								<a class="btn btn-default" href="{$next_page}">Next</a>
							</xsl:if>
						</div>
					</div>
				</div>
			</div>
			
		</xsl:if>
	
	</xsl:template>	
	
</xsl:stylesheet>
