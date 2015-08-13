<?xml version="1.0" encoding="UTF-8"?>

<!--
	ScholarWorks Variables
-->

<xsl:stylesheet xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
	xmlns:dri="http://di.tamu.edu/DRI/1.0/"
	xmlns:mets="http://www.loc.gov/METS/"
	xmlns:xlink="http://www.w3.org/TR/xlink/"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
	xmlns:dim="http://www.dspace.org/xmlns/dspace/dim"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:mods="http://www.loc.gov/mods/v3"
	xmlns:dc="http://purl.org/dc/elements/1.1/">

    <xsl:output indent="yes"/>
	
	<xsl:template match="/dri:document">
	
		<dri:document>
			<xsl:apply-templates />
			<xsl:call-template name="variables" />
		</dri:document>

	</xsl:template>
	
	<xsl:template name="variables">
	
		<variable>
		
			<page>
				<xsl:value-of select="dri:body/dri:div/@n" />
			</page>
			
			<!-- query -->
			
			<xsl:if test="//dri:field[@id='aspect.discovery.SimpleSearch.field.query']/dri:value">
			
				<query>
					<xsl:value-of select="//dri:field[@id='aspect.discovery.SimpleSearch.field.query']/dri:value" />
				</query>
				
			</xsl:if>
		
			<!-- bring the mets documents into the xml proper -->
			
			<!-- Discovery Facets -->
	
			<xsl:if test="//dri:options/dri:list[@n='discovery']">
	
				<facets>
					<xsl:for-each select="//dri:options/dri:list[@n='discovery']/dri:list">
						
						<facet>
							<xsl:value-of select="//dri:head/i18n:text" />
						</facet>
									
					</xsl:for-each>
				</facets>
				
			</xsl:if>
			
			<!-- communities -->
	
			<xsl:if test="//dri:referenceSet[@n='community-browser' or @n='community-view']/dri:reference">
	
				<communities>
					<xsl:for-each select="//dri:referenceSet[@n='community-browser' or @n='community-view']/dri:reference">
						
						<community>
							<xsl:call-template name="render_reference" />
							
							<xsl:if test="dri:referenceSet">
								<collections>
									<xsl:for-each select="dri:referenceSet/dri:reference">
										<xsl:call-template name="render_reference" />
									</xsl:for-each>
								</collections>
							</xsl:if>
							
						</community>
									
					</xsl:for-each>
				</communities>
				
			</xsl:if>

			<!-- collections -->
	
			<xsl:if test="//dri:referenceSet[@n='collection-view']/dri:reference">
	
				<collections>
					<xsl:for-each select="//dri:referenceSet[@n='collection-view']/dri:reference">
						<xsl:call-template name="render_reference" />
					</xsl:for-each>
				</collections>
							
			</xsl:if>

			<!-- recent submissions and full item -->
			
			<xsl:if test="//dri:referenceSet[@rend='recent-submissions' or @n='collection-viewer' or contains(@n, 'browse')]/dri:reference">
				
				<results>
					<xsl:for-each select="//dri:div[@pagination='simple']">
						<start><xsl:value-of select="@firstItemIndex" /></start>
						<end><xsl:value-of select="@lastItemIndex" /></end>
						<total><xsl:value-of select="@itemsTotal" /></total>
						<nextPage><xsl:value-of select="@nextPage" /></nextPage>
						<previousPage><xsl:value-of select="@previousPage" /></previousPage>
					</xsl:for-each>

					<xsl:for-each select="//dri:referenceSet[@rend='recent-submissions' or @n='collection-viewer' or contains(@n, 'browse')]/dri:reference">
						<xsl:call-template name="render_reference" />
					</xsl:for-each>
				</results>
				
			</xsl:if>
			
			<!-- browse nav -->
			
			<xsl:if test="//dri:div[@n='browse-navigation']">
	
				<browse_nav>
					<xsl:for-each select="//dri:div[@n='browse-navigation']/dri:list[@n='jump-list']/dri:item">
						<letter link="{dri:xref/@target}"><xsl:value-of select="dri:xref" /></letter>
					</xsl:for-each>
				</browse_nav>
				
			</xsl:if>
			
			<!-- browse nav -->
			
			<xsl:if test="//dri:table[substring(@n,1,9) = 'browse-by']">
			
				<browse>				
					<xsl:for-each select="//dri:table[substring(@n,1,9) = 'browse-by']/dri:row[not(@role)]/dri:cell">
					
						<!-- switch browse url to discovery facet link -->
					
						<xsl:variable name="query">
							<xsl:value-of select="substring-before(substring-after(dri:xref/@target,'?value='), '&amp;')" />
						</xsl:variable>
						
						<xsl:variable name="type">
							<xsl:value-of select="substring-after(dri:xref/@target,'&amp;type=')" />
						</xsl:variable>

						<xsl:variable name="link">
							<xsl:text>discover?filtertype=</xsl:text>
							<xsl:value-of select="$type" />
							<xsl:text>&amp;filter_relational_operator=equals</xsl:text>
							<xsl:text>&amp;filter=</xsl:text>
							<xsl:value-of select="$query" />
						</xsl:variable>
					
						<entry link="{$link}">
							<value><xsl:value-of select="dri:xref" /></value>
							<count><xsl:value-of select="substring(text(),3,string-length(text()) - 3)" /></count>
						</entry>
					</xsl:for-each>
				</browse>
			
			</xsl:if>
			
			<!-- search results -->
			
			<xsl:if test="//dri:list[@n='item-result-list'] or //dri:list[@n='comm-coll-result-list']">
			
				<results>
					<start><xsl:value-of select="//dri:div[@id='aspect.discovery.SimpleSearch.div.search-results']/@firstItemIndex" /></start>
					<end><xsl:value-of select="//dri:div[@id='aspect.discovery.SimpleSearch.div.search-results']/@lastItemIndex" /></end>
					<total><xsl:value-of select="//dri:div[@id='aspect.discovery.SimpleSearch.div.search-results']/@itemsTotal" /></total>

					<!-- community results -->
					
					<xsl:if test="//dri:list[@n='comm-coll-result-list']/dri:list">
					
						<communities>
		
							<xsl:for-each select="//dri:list[@n='comm-coll-result-list']/dri:list">
							
									<community>
										<title><xsl:value-of select="dri:list[contains(@n, 'dc.title')]/dri:item" /></title>
										<link>/handle/<xsl:value-of select="substring(dri:list[contains(@n, 'dc.identifier.uri')]/dri:item, 23)" /></link>
									</community>

							</xsl:for-each>
							
						</communities>
						
					</xsl:if>

					<xsl:for-each select="//dri:list[@n='item-result-list']">
						<xsl:for-each select="dri:list">
							<xsl:variable name="external_metadata_url">
								<xsl:text>cocoon://metadata/handle/</xsl:text>
								<xsl:value-of select="substring-before(@n, ':')"/>
								<xsl:text>/mets.xml</xsl:text>
							</xsl:variable>
							<xsl:copy-of select="document($external_metadata_url)" />
						</xsl:for-each>
					</xsl:for-each>
				</results>
				
			</xsl:if>
			
		</variable>
	
	</xsl:template>
	
	<!-- render the reference element -->
	
	<xsl:template name="render_reference">
	
		<xsl:variable name="external_metadata_url">
			<xsl:text>cocoon:/</xsl:text>
			<xsl:value-of select="@url" />
		</xsl:variable>
		
		<xsl:copy-of select="document($external_metadata_url)" />	
		
	</xsl:template>
	
	<!-- leave all other elements untouched -->

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	
</xsl:stylesheet>
