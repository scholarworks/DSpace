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
	common templates
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
	
	<xsl:variable name="page" select="//variable/page" />
	<xsl:variable name="base_url" select="//dri:meta/dri:pageMeta/dri:metadata[@element='contextPath']" />
	<xsl:variable name="base_asset_url"><xsl:value-of select="$base_url" />/themes/Alchemy/lib</xsl:variable>
	<xsl:variable name="search_url">
		<xsl:value-of select="$base_url" />
		<xsl:value-of select="//dri:meta/dri:pageMeta/dri:metadata[@element='search' and @qualifier='simpleURL']" />
	</xsl:variable>
	
	<xsl:template match="/*">
	
		<xsl:choose>
			<xsl:when test="$page = 'search' or $page = 'item-view' or $page = 'news' or substring($page,1,9) = 'browse-by' or
				$page = 'comunity-browser' or $page = 'community-home' or $page = 'collection-home' or $page = 'login'">
				<xsl:call-template name="ScholarWorks" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="mirage" />
			</xsl:otherwise>
		</xsl:choose>
	
	</xsl:template>
	
	<xsl:template name="ScholarWorks">
	
		<!-- doctype: html 5 -->
		<!-- <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text> -->
		
		<html lang="en">
		<head>
		<meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="icon" href="/favicon.ico" />
		
		<title>
			<xsl:choose>
				<xsl:when test="dri:meta/dri:pageMeta/dri:metadata[@element='title']/i18n:*">
					<xsl:copy-of select="dri:meta/dri:pageMeta/dri:metadata[@element='title']/*" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="dri:meta/dri:pageMeta/dri:metadata[@element='title']" />
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text> - </xsl:text>
			<i18n:text catalogue="default">xmlui.dri2xhtml.structural.head-subtitle</i18n:text>
		</title>
		
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" />
		<link href="//netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
		<link href="{$base_asset_url}/css/alchemy.css" rel="stylesheet" />
		<xsl:call-template name="local_css" />
		
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->			
		
		</head>
		<body>
		
			<xsl:call-template name="header" />

			<xsl:choose>			
				<xsl:when test="$page = 'news'">
					<xsl:call-template name="home_page" />
				</xsl:when>
				<xsl:when test="$page = 'search'">
					<xsl:call-template name="search_results" />
				</xsl:when>
				<xsl:when test="$page = 'comunity-browser'">
						<xsl:call-template name="community_list" />
				</xsl:when>
				<xsl:when test="$page = 'community-home'">
						<xsl:call-template name="community" />
				</xsl:when>
			</xsl:choose>
			
			<xsl:call-template name="footer" />
			
			<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js" type="text/javascript">&nbsp;</script>	
			<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js" type="text/javascript">&nbsp;</script>
			<xsl:call-template name="local_js" />
		</body>
		</html>
	
	</xsl:template>
	
	<xsl:template name="local_css">
		<link href="{$base_asset_url}/css/local.css" rel="stylesheet" />
	</xsl:template>
	
	<xsl:template name="header">
	
		<xsl:variable name="home" select="//dri:pageMeta/dri:metadata[@element='contextPath']" />
		<xsl:variable name="login" select="//dri:userMeta/dri:metadata[@element='loginURL']" />
	
		<div id="header-navbar" class="navbar navbar-inverse navbar-static-top" role="navigation">
			<div class="container">
    			<div class="navbar-header">
    				<button type="button" class="navbar-toggle btn collapsed" data-toggle="collapse" data-target="#user-util-collapse">
      					<span class="sr-only">Toggle navigation</span>
      					<span class="icon-bar"></span>
      					<span class="icon-bar"></span>
      					<span class="icon-bar"></span>
    				</button>
    				<a class="navbar-brand" href="/">Blacklight</a>
    			</div>

    			<div class="collapse navbar-collapse" id="user-util-collapse">
      				<div class="navbar-right">
  						<ul class="nav navbar-nav">    
      						<li><a id="bookmarks_nav" href="/bookmarks">
  								Bookmarks (<span data-role='bookmark-counter'>0</span>)
							</a></li>

      						<li><a href="/search_history">History</a></li>
  						</ul>

    					<ul class="nav navbar-nav">
      						<li>
        						<a href="/users/sign_in">Login</a>
      						</li>
      					</ul>
					</div>
    			</div>
  			</div>
		</div>
		
		<div id="search-navbar" class="navbar navbar-default navbar-static-top" role="navigation">
  			<div class="container">
      			<form action="{$search_url}" class="search-query-form clearfix navbar-form" accept-charset="UTF-8" method="get"><input name="utf8" type="hidden" value="&#x2713;" />
          			<label for="search_field" class="sr-only">Search in</label>
      				<select name="search_field" id="search_field" title="Targeted search options" class="search_field form-control">
      					<option value="all_fields">All Fields</option>
						<option value="title">Title</option>
						<option value="author">Author</option>
						<option value="subject">Subject</option>
					</select>
      				<span class="sr-only">for</span>
    				<div class="input-group search-input-group">
        				<label for="q" class="sr-only">search for</label>
         				<input type="text" name="q" id="q" placeholder="Search..." class="search_q q form-control" autofocus="autofocus" />
						<span class="input-group-btn">
        					<button type="submit" class="btn btn-primary search-btn" id="search">
          						<span class="submit-search-text">Search</span>
          						<span class="glyphicon glyphicon-search"></span>
        					</button>
        				</span>
      				</div>
				</form>
  			</div>
		</div>
			
	</xsl:template>
	
	<xsl:template name="footer" />
	
	<xsl:template name="login">
	
		<ul class="nav navbar-nav navbar-right">
		
			<xsl:choose>
				<xsl:when test="//i18n:text = 'xmlui.EPerson.Navigation.login'">
					
					<li>
						<a href="{dri:meta/dri:userMeta/dri:metadata[@element='identifier' and @qualifier='loginURL']}">
							<i18n:text catalogue="default">xmlui.EPerson.Navigation.login</i18n:text>
						</a>
					</li>
					
				</xsl:when>
				<xsl:otherwise>
				
					<li class="dropdown">
					
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<xsl:value-of select="//i18n:translate[i18n:text = 'xmlui.EPerson.Navigation.profile']/i18n:param" />
							<xsl:text> </xsl:text>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<xsl:for-each select="dri:options/dri:list[@n='account']/dri:item">
								<li>
									<a href="{dri:xref/@target}">
										<xsl:copy-of select="dri:xref/*" />
									</a>
								</li>
							</xsl:for-each>
						</ul>
					</li>								
					
				</xsl:otherwise>
			</xsl:choose>
	
		</ul>
	
	</xsl:template>
	
	<xsl:template name="breadcrumbs">
	
		<div class="breadcrumbs">
			<div class="container">
				<ul>
					<xsl:for-each select="dri:meta/dri:pageMeta/dri:trail">
						<li>
							<xsl:choose>
								<xsl:when test="@target">
									<xsl:attribute name="class">parent</xsl:attribute>
									<a href="{@target}">
										<xsl:copy-of select="text()|i18n:text|i18n:translate/i18n:text" />
									</a>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="text()|i18n:text|i18n:translate/i18n:text" />
								</xsl:otherwise>
							</xsl:choose>
						</li>
					</xsl:for-each>
				</ul>
			</div>
		</div>
	
	</xsl:template>
	

	<xsl:template name="browser">
	
		<h2><i18n:text catalogue="default">xmlui.ArtifactBrowser.Navigation.head_browse</i18n:text></h2>
		
		<xsl:for-each select="//dri:options/dri:list[@n='browse']/dri:list[@n='global']">		
			<ul>
				<xsl:for-each select="dri:item/dri:xref">
					<li><a href="{@target}"><xsl:copy-of select="i18n:text" /></a></li>
				</xsl:for-each>
			</ul>
		</xsl:for-each>
		
		<xsl:if test="//dri:options/dri:list[@n='browse']/dri:list[@n='context']/dri:head">

			<h2><i18n:text catalogue="default">xmlui.ArtifactBrowser.Navigation.head_this_collection</i18n:text></h2>
			
			<xsl:for-each select="//dri:options/dri:list[@n='browse']/dri:list[@n='context']">		
				<ul>
					<xsl:for-each select="dri:item/dri:xref">
						<li><a href="{@target}"><xsl:copy-of select="i18n:text" /></a></li>
					</xsl:for-each>
				</ul>
			</xsl:for-each>
			
		</xsl:if>
	
	</xsl:template>

	<xsl:template name="admin">
	
		<xsl:for-each select="dri:options/dri:list[@n='administrative' or @n='context']">
		
			<xsl:if test="dri:head/i18n:text">
		
				<h2><xsl:copy-of select="dri:head/i18n:text" /></h2>
			
				<ul>			
					<xsl:for-each select="dri:list">
						<li>
							<xsl:copy-of select="dri:head/i18n:text" />
							<ul>
								<xsl:for-each select="dri:item/dri:xref">
									<li>
										<a href="{@target}"><xsl:copy-of select="i18n:text" /></a>
									</li>
								</xsl:for-each>
							</ul>
						</li>
					</xsl:for-each>
					<xsl:for-each select="dri:item/dri:xref">
						<li>
							<a href="{@target}"><xsl:copy-of select="i18n:text" /></a>
						</li>
					</xsl:for-each>				
				</ul>
				
			</xsl:if>
							
		</xsl:for-each>
		
	</xsl:template>
	
	<xsl:template name="brief_results">
	
		<ul class="brief-results">
			<xsl:for-each select="alchemy/results/mets:METS">
				<li>
					<xsl:call-template name="small_type_icon" />		
					<a href="{@OBJID}">
						<xsl:value-of select="mets:dmdSec//dim:field[@mdschema='dc' and @element='title']" />
					</a>
					<xsl:if test="mets:dmdSec//dim:field[@mdschema='dc' and @element='contributor']">
						<xsl:text>, </xsl:text> 
						<xsl:value-of select="mets:dmdSec//dim:field[@mdschema='dc' and @element='contributor']" />
					</xsl:if>
				</li>
			</xsl:for-each>
		</ul>
	
	</xsl:template>	
	
	<xsl:template name="brief_results_by_date">
	
		<xsl:if test="alchemy/results/mets:METS">
	
			<div class="results-by-date">
			
				<xsl:for-each select="alchemy/results/mets:METS">
			
					<xsl:call-template name="date_header" />
				
					<div class="result">
						<xsl:call-template name="small_type_icon" />
						<a href="{@OBJID}">
							<xsl:value-of select="mets:dmdSec//dim:field[@mdschema='dc' and @element='title']" />
						</a>
						<xsl:if test="mets:dmdSec//dim:field[@mdschema='dc' and @element='contributor']">
							<xsl:text>, </xsl:text> 
							<xsl:value-of select="mets:dmdSec//dim:field[@mdschema='dc' and @element='contributor']" />
						</xsl:if>
					</div>
					
				</xsl:for-each>
			
			</div>
			
		</xsl:if>

	</xsl:template>
	
	<xsl:template name="small_type_icon">
	
		<span class="type-icon">
			<xsl:for-each select="mets:fileSec/mets:fileGrp[@USE='CONTENT']/mets:file[position()=1]">
				<xsl:call-template name="file_types">
					<xsl:with-param name="size">small</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</span>
			
	</xsl:template>
	
	<xsl:template name="date_header">
	
		<xsl:variable name="year" select="substring(mets:dmdSec/mets:mdWrap/mets:xmlData/dim:dim/dim:field[@mdschema='dc' and @element='date' and @qualifier='issued'], 1, 4)" />
		<xsl:variable name="previous_year" select="substring(preceding-sibling::mets:METS[1]/mets:dmdSec/mets:mdWrap/mets:xmlData/dim:dim/dim:field[@mdschema='dc' and @element='date' and @qualifier='issued'], 1, 4)" />
	
		<xsl:if test="not($previous_year = $year)">
		
			<h2><xsl:value-of select="$year" /></h2>
			
		</xsl:if>	
	
	</xsl:template>
	
	<xsl:template name="community_results">
	
		<xsl:if test="alchemy/results/communities">
		
			<div class="communities">
		
				<h2><i18n:text catalogue="default">xmlui.ArtifactBrowser.CommunityBrowser.head</i18n:text></h2>
			
				<ul>
					<xsl:for-each select="alchemy/results/communities/community">
						<li>
							<a href="{link}"><xsl:value-of select="title" /></a>
						</li>
					</xsl:for-each>
				</ul>
				
			</div>
		
		</xsl:if>
	
	</xsl:template>
	
	<xsl:template name="medium_results">
	
		<ul class="medium-results">
			<xsl:for-each select="alchemy/results/mets:METS/mets:dmdSec/mets:mdWrap/mets:xmlData/dim:dim">
				<li>
					<div class="title">
						<a href="{../../../../@OBJID}"><xsl:value-of select="dim:field[@mdschema='dc' and @element='title']" /></a>
					</div>
					
					<xsl:if test="dim:field[@mdschema='dc' and @element='type']">
						<div class="type">
							<xsl:value-of select="dim:field[@mdschema='dc' and @element='type']" />
						</div>
					</xsl:if>
					
					<xsl:if test="dim:field[@mdschema='dc' and @element='publisher']">
						<div class="type">
							<xsl:value-of select="dim:field[@mdschema='dc' and @element='publisher']" />
						</div>
					</xsl:if>
					
					<div class="abstract">
						
						<xsl:variable name="summary" select="dim:field[@mdschema='dc' and @element='description' and @qualifier='abstract']" />
		
						<xsl:choose>
							<xsl:when test="string-length($summary) &gt; 300">
								<xsl:value-of select="substring($summary, 1, 300)" /> . . .
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$summary" />
							</xsl:otherwise>
						</xsl:choose>
		
					</div>
				</li>
			</xsl:for-each>
		</ul>
	
	</xsl:template>
	
	<xsl:template name="file_types">
		<xsl:param name="size">small</xsl:param>
	
		<xsl:variable name="path">
			<xsl:value-of select="$base_asset_url" />
			<xsl:text>/images/types/</xsl:text>
			<xsl:value-of select="$size" />
		</xsl:variable>
	
		<xsl:choose>
			<xsl:when test="@MIMETYPE = 'application/pdf'">
				<img src="{$path}/pdf.png" alt="Adobe PDF" />
			</xsl:when>
			<xsl:when test="@MIMETYPE = 'text/html'">
				<img src="{$path}/html.png" alt="HTML" />
			</xsl:when>
			<xsl:when test="@MIMETYPE = 'text/css'">
				<img src="{$path}/css.png" alt="CSS" />
			</xsl:when>
			<xsl:when test="@MIMETYPE = 'application/msword' or @MIMETYPE = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' or @MIMETYPE = 'text/richtext'">
				<img src="{$path}/doc.png" alt="Microsoft Word" />
			</xsl:when>
			<xsl:when test="@MIMETYPE = 'application/vnd.ms-powerpoint' or @MIMETYPE = 'application/vnd.openxmlformats-officedocument.presentationml.presentation'">
				<img src="{$path}/ppt.png" alt="Microsoft Powerpoint" />
				</xsl:when>
			<xsl:when test="@MIMETYPE = 'application/vnd.ms-excel' or @MIMETYPE = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'">
				<img src="{$path}/xls.png" alt="Microsoft Excel" />
			</xsl:when>
			<xsl:when test="@MIMETYPE = 'image/jpeg'">
				<img src="{$path}/jpg.png" alt="JPEG" />
			</xsl:when>				
			<xsl:when test="@MIMETYPE = 'image/gif'">
				<img src="{$path}/gif.png" alt="GIF" />
			</xsl:when>	
			<xsl:when test="@MIMETYPE = 'video/quicktime'">
				<img src="{$path}/mov.png" alt="Quicktime" />
			</xsl:when>	
			<xsl:when test="@MIMETYPE = 'audio/x-mpeg' or @MIMETYPE = 'audio/mpeg'">
				<img src="{$path}/mp3.png" alt="WAV" />
			</xsl:when>
			<xsl:when test="@MIMETYPE = 'text/plain'">
				<img src="{$path}/txt.png" alt="Text" />
			</xsl:when>			
			<xsl:otherwise>
				<img src="{$path}/file.png" alt="file" />
			</xsl:otherwise>
		</xsl:choose>
	
	</xsl:template>
	
	<xsl:template name="file_size">
	
		<xsl:variable name="size" select="string-length(@SIZE)" />
		
		<xsl:choose>
			<xsl:when test="$size &gt;= 4 and $size &lt;= 6">
				<xsl:value-of select="substring(@SIZE, 1, $size - 3)" />
				<xsl:text> KB</xsl:text>
			</xsl:when>
			<xsl:when test="$size &gt;= 7 and $size &lt;= 9">
				<xsl:value-of select="substring(@SIZE, 1, $size - 6)" />
				<xsl:text> MB</xsl:text>
			</xsl:when>
			<xsl:when test="$size &gt;= 10">
				<xsl:value-of select="substring(@SIZE, 1, $size - 9)" />
				<xsl:text> GB</xsl:text>
			</xsl:when>
		</xsl:choose>
	
	</xsl:template>
	
	
	
	<!-- this keeps Mirage from erroring out -->
	
	<xsl:template match="alchemy" />
	
	<!--
		copied from Mirage page-structure.xsl 
		but renamed so we can invoke it directly
	-->
	
    <xsl:template name="mirage">
 
        <html class="no-js">
            <!-- First of all, build the HTML head element -->
            <xsl:call-template name="buildHead"/>
            <!-- Then proceed to the body -->

            <!--paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/-->
            <xsl:text disable-output-escaping="yes">&lt;!--[if lt IE 7 ]&gt; &lt;body class="ie6"&gt; &lt;![endif]--&gt;
                &lt;!--[if IE 7 ]&gt;    &lt;body class="ie7"&gt; &lt;![endif]--&gt;
                &lt;!--[if IE 8 ]&gt;    &lt;body class="ie8"&gt; &lt;![endif]--&gt;
                &lt;!--[if IE 9 ]&gt;    &lt;body class="ie9"&gt; &lt;![endif]--&gt;
                &lt;!--[if (gt IE 9)|!(IE)]&gt;&lt;!--&gt;&lt;body&gt;&lt;!--&lt;![endif]--&gt;</xsl:text>

            <xsl:choose>
              <xsl:when test="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='framing'][@qualifier='popup']">
                <xsl:apply-templates select="dri:body/*"/>
              </xsl:when>
                  <xsl:otherwise>
                    <div id="ds-main">
                        <!--The header div, complete with title, subtitle and other junk-->
                        <xsl:call-template name="buildHeader"/>

                        <!--The trail is built by applying a template over pageMeta's trail children. -->
                        <xsl:call-template name="buildTrail"/>

                        <!--javascript-disabled warning, will be invisible if javascript is enabled-->
                        <div id="no-js-warning-wrapper" class="hidden">
                            <div id="no-js-warning">
                                <div class="notice failure">
                                    <xsl:text>JavaScript is disabled for your browser. Some features of this site may not work without it.</xsl:text>
                                </div>
                            </div>
                        </div>


                        <!--ds-content is a groups ds-body and the navigation together and used to put the clearfix on, center, etc.
                            ds-content-wrapper is necessary for IE6 to allow it to center the page content-->
                        <div id="ds-content-wrapper">
                            <div id="ds-content" class="clearfix">
                                <!--
                               Goes over the document tag's children elements: body, options, meta. The body template
                               generates the ds-body div that contains all the content. The options template generates
                               the ds-options div that contains the navigation and action options available to the
                               user. The meta element is ignored since its contents are not processed directly, but
                               instead referenced from the different points in the document. -->
                                <xsl:apply-templates/>
                            </div>
                        </div>


                        <!--
                            The footer div, dropping whatever extra information is needed on the page. It will
                            most likely be something similar in structure to the currently given example. -->
                        <xsl:call-template name="buildFooter"/>

                    </div>

                </xsl:otherwise>
            </xsl:choose>
                <!-- Javascript at the bottom for fast page loading -->
              <xsl:call-template name="addJavascript"/>

            <xsl:text disable-output-escaping="yes">&lt;/body&gt;</xsl:text>
        </html>
 
    </xsl:template>
	
	<xsl:template name="local_js" />
	
</xsl:stylesheet>
