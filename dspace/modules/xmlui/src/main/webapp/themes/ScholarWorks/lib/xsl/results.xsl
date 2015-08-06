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

    ScholarWorks THEME
	search results

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
	
	<xsl:template name="search_results">
	
		<xsl:variable name="start" select="//variable/results/start" />
		<xsl:variable name="end" select="//variable/results/end" />
		<xsl:variable name="total" select="//variable/results/total" />
		<xsl:variable name="query" select="//variable/query" />
				
		<div class="container">
		
			<div class="row">
			
				<div class="col-sm-4">&nbsp;</div>
				<div class="col-sm-8">
			
					<div class="search-area">
					
						<div class="search-box">
						
							<!-- query -->
		
							<form action="discover" method="get">
								<input type="text" name="query" value="{$query}" class="query" />
								<input type="submit" value="search" class="submit-button" />
							</form>
							
							<xsl:call-template name="facets_remove" />
							
							<xsl:if test="not(alchemy/results)">
								<div class="no-results">
									<i18n:text catalogue="default">xmlui.ArtifactBrowser.AbstractSearch.no_results</i18n:text>
								</div>
							</xsl:if>
							
						</div>
					
					</div>
				</div>
			</div>
			
			<xsl:if test="alchemy/results">
				
				<div class="search-results-area">
				
					<div class="row">
						<div class="col-sm-4">
						
							<div class="sidebar">
							
								<xsl:for-each select="dri:options/dri:list[@n='discovery']/dri:list">
								
									<div class="facet">
										<h2>
											<i18n:text><xsl:value-of select="dri:head/i18n:text" /></i18n:text>
										</h2>
										<ul>
											<xsl:for-each select="dri:item">
												<li>
													<xsl:choose>
														<xsl:when test="dri:xref">
															<a href="{dri:xref/@target}">
																<xsl:copy-of select="dri:xref" />
															</a>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="text()" />
														</xsl:otherwise>
													</xsl:choose>
												</li>
											</xsl:for-each>
										</ul>
									</div>
									
								</xsl:for-each>
							
							</div>
							
						</div>
						<div class="col-sm-8">
					
							<div class="results search-results">
							
								<div class="result-options">
							
									<div class="sort-options">
									
										<xsl:text>sort by: </xsl:text>
									
										<xsl:call-template name="sort_form">
											<xsl:with-param name="sort_by">score</xsl:with-param>
											<xsl:with-param name="order">desc</xsl:with-param>
										</xsl:call-template>
										
										<xsl:text> | </xsl:text>
					
										<xsl:call-template name="sort_form">
											<xsl:with-param name="sort_by">dc.date.issued_dt</xsl:with-param>
											<xsl:with-param name="order">desc</xsl:with-param>
										</xsl:call-template>
										
										<xsl:text> | </xsl:text>
					
										<xsl:call-template name="sort_form">
											<xsl:with-param name="sort_by">dc.date.issued_dt</xsl:with-param>
											<xsl:with-param name="order">asc</xsl:with-param>
										</xsl:call-template>
										
									</div>				
							
									<div class="summary">
										Results <strong><xsl:value-of select="$start" />-<xsl:value-of select="$end" /></strong> of 
										<strong><xsl:value-of select="$total" /></strong>
									</div>
									
								</div>
								
								<xsl:call-template name="community_results" />
								<xsl:call-template name="medium_results" />
							
							</div>
							
							<xsl:call-template name="pager" />
							
						</div>
					</div>
				</div>
				
			</xsl:if>
			
		</div>

	</xsl:template>	
	



	<!-- 
		****************************
		  UTILITY TEMPLATES 
		  For handling dri cruft
		****************************
	-->
	
	
	<!--
		TEMPLATE: FACETS REMOVE
		Hack to create forms that re-submit the search minus the selected facet 
		so we can have 'remove links' that the user can use to unselect facets
	-->
	
	<xsl:template name="facets_remove">
	
		<xsl:if test="//dri:row[@rend='search-filter used-filter']">
	
			<div class="facets-remove">
		
				<!-- facets -->
				
				<xsl:for-each select="//dri:row[@rend='search-filter used-filter']">
										
					<form action="discover">
					
						<!-- the query, which should always be here -->
						
						<xsl:for-each select="//dri:div[@id='aspect.discovery.SimpleSearch.div.search-filters']/dri:p[@id='aspect.discovery.SimpleSearch.p.hidden-fields']/dri:field">
							<input type="hidden" name="{@n}" value="{dri:value}" />						
						</xsl:for-each>
						
						<!-- take every row other than the current one to 'remove' the current one -->
						
						<xsl:variable name="name" select="@n" />
						
						<xsl:for-each select="//dri:row[@rend='search-filter used-filter' and @n != $name]">
					
							<xsl:for-each select="dri:cell[@rend != 'filter-controls']/dri:field">
							
								<input type="hidden" name="{@n}">
									<xsl:attribute name="value">
										<xsl:choose>
											<xsl:when test="dri:value/@option">
												<xsl:value-of select="dri:value/@option" />
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="dri:value" />
											</xsl:otherwise>
										</xsl:choose>
									</xsl:attribute>
								</input>
								
							</xsl:for-each>
							
						</xsl:for-each>
						
						<!-- the display value -->
						
						<xsl:variable name="facet_selected" select="dri:cell[@rend='discovery-filter-input-cell']/dri:field/dri:value" />
										
						<button type="submit">
							<xsl:value-of select="$facet_selected" />
							<span class="close">x</span>
						</button>
						
					</form>
					
				</xsl:for-each>
				
				<div style="clear:left">&nbsp;</div>
				
			</div>
			
		</xsl:if>
	
	</xsl:template>
	
	<!--
		TEMPLATE: PAGER
		For paging through result set
		Note: this is copied (and modified) from dri2xhtml/structural.xsl @ line 2669 
	-->
	
	<xsl:template name="pager">
	
		<!-- only show a page if there are more than 1 page of results -->
		
		<xsl:if test="//dri:div[@id='aspect.discovery.SimpleSearch.div.search-results']/@pagesTotal &gt; 1">
				
			<div class="paging">
			
				<xsl:for-each select="//dri:div[@id='aspect.discovery.SimpleSearch.div.search-results']/@pagination">
			
					<xsl:variable name="position">bottom</xsl:variable>
				
					<!-- pager -->
				
				   <ul class="pagination">
						<xsl:if test="(parent::node()/@currentPage - 4) &gt; 0">
							<li>
								<a>
									<xsl:attribute name="href">
										<xsl:value-of select="substring-before(parent::node()/@pageURLMask,'{pageNum}')"/>
										<xsl:text>1</xsl:text>
										<xsl:value-of select="substring-after(parent::node()/@pageURLMask,'{pageNum}')"/>
									</xsl:attribute>
									<xsl:text>1</xsl:text>
								</a>
								<xsl:text> . . . </xsl:text>
							</li>
						</xsl:if>
						<xsl:call-template name="offset-link">
							<xsl:with-param name="pageOffset">-3</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="offset-link">
							<xsl:with-param name="pageOffset">-2</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="offset-link">
							<xsl:with-param name="pageOffset">-1</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="offset-link">
							<xsl:with-param name="pageOffset">0</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="offset-link">
							<xsl:with-param name="pageOffset">1</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="offset-link">
							<xsl:with-param name="pageOffset">2</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="offset-link">
							<xsl:with-param name="pageOffset">3</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="(parent::node()/@currentPage + 4) &lt;= (parent::node()/@pagesTotal)">
							<li class="last-page-link">
								<xsl:text> . . . </xsl:text>
								<a>
									<xsl:attribute name="href">
										<xsl:value-of select="substring-before(parent::node()/@pageURLMask,'{pageNum}')"/>
										<xsl:value-of select="parent::node()/@pagesTotal"/>
										<xsl:value-of select="substring-after(parent::node()/@pageURLMask,'{pageNum}')"/>
									</xsl:attribute>
									<xsl:value-of select="parent::node()/@pagesTotal"/>
								</a>
							</li>
						</xsl:if>
						
						<!-- next element -->
						
						<xsl:if test="not(parent::node()/@lastItemIndex = parent::node()/@itemsTotal)">
						
							<li>
								<a>
									<xsl:attribute name="href">
										<xsl:value-of select="substring-before(parent::node()/@pageURLMask,'{pageNum}')"/>
										<xsl:value-of select="parent::node()/@currentPage + 1"/>
										<xsl:value-of select="substring-after(parent::node()/@pageURLMask,'{pageNum}')"/>
									</xsl:attribute>
									<i18n:text>xmlui.dri2xhtml.structural.pagination-next</i18n:text>
								</a>
							</li>
						</xsl:if>						
						
					</ul>
					
				</xsl:for-each>
				
			</div>
			
		</xsl:if>
	
	</xsl:template>
	
	<!--
		TEMPLATE: SORT FORM
		Hack to construct form that resubmits the search minus the selected sort order
		so we can create sort-by 'links'
	-->
	
	<xsl:template name="sort_form">
		<xsl:param name="sort_by" />
		<xsl:param name="order" />
		
		<xsl:variable name="current_sort_by" select="//dri:div[@id='aspect.discovery.SimpleSearch.div.main-form']/dri:p/dri:field[@n = 'sort_by']" />
		<xsl:variable name="current_order" select="//dri:div[@id='aspect.discovery.SimpleSearch.div.main-form']/dri:p/dri:field[@n = 'order']" />
		
		<xsl:choose>
		
			<!-- this is the currently selected option, so just display text -->
		
			<xsl:when test="$current_sort_by = $sort_by and $current_order = $order">

				<strong>
					<xsl:call-template name="sort_text">
						<xsl:with-param name="sort_by" select="$sort_by" />
						<xsl:with-param name="order" select="$order" />	
					</xsl:call-template>
				</strong>
			
			</xsl:when>
			
			<!-- run over the query elements, but skip any existing sort and order params,
				 which we'll supply ourselves, as well as page (since we want to go back to page 1)
				 and any other unused elements -->			
			
			<xsl:otherwise>

				<form action="discover" method="get">
						
					<xsl:for-each select="//dri:div[@id='aspect.discovery.SimpleSearch.div.main-form']/dri:p/dri:field[@n != 'search-result' and @n != 'sort_by' and @n != 'order' and @n != 'page']">
					
						<input type="hidden" name="{@n}" value="{dri:value}" />
					
					</xsl:for-each>
					
					<input type="hidden" name="sort_by" value="{$sort_by}" />
					<input type="hidden" name="order" value="{$order}" />
					
					<button type="submit">
						<xsl:call-template name="sort_text">
							<xsl:with-param name="sort_by" select="$sort_by" />
							<xsl:with-param name="order" select="$order" />	
						</xsl:call-template>						
					</button>
					
				</form>
			
			</xsl:otherwise>
		</xsl:choose>
	
	</xsl:template>	

	<!--
		TEMPLATE: SORT TEXT
		the i18n display of the sort options, 
		based solely on sort_by and order params
	-->
	
	<xsl:template name="sort_text">
		<xsl:param name="sort_by" />
		<xsl:param name="order" />
			
		<xsl:choose>
			<xsl:when test="$sort_by = 'dc.date.issued_dt' and $order = 'desc'">
				<!-- <i18n:text catalogue="default">xmlui.Discovery.AbstractSearch.sort_by.dc.date.issued_dt_desc</i18n:text> -->
				<xsl:text>newest first</xsl:text>
			</xsl:when>
			<xsl:when test="$sort_by = 'dc.date.issued_dt' and $order = 'asc'">
				<!-- <i18n:text catalogue="default">xmlui.Discovery.AbstractSearch.sort_by.dc.date.issued_dt_asc</i18n:text> -->
				<xsl:text>oldest first</xsl:text>
			</xsl:when>
			<xsl:when test="$sort_by = 'score'">
				<!-- <i18n:text catalogue="default">xmlui.Discovery.AbstractSearch.sort_by.relevance</i18n:text> -->
				<xsl:text>relevance</xsl:text>
			</xsl:when>
		</xsl:choose>
		
	</xsl:template>
	
</xsl:stylesheet>
