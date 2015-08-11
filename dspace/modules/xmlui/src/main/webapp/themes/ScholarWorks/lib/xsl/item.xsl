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
	full record page

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
	
	<xsl:template name="item_view">
	
		<div class="container">
			<div class="item-view">
			
				<div class="row">
			
					<div class="col-sm-8">
				
						<xsl:for-each select="variable/results/mets:METS/mets:dmdSec/mets:mdWrap/mets:xmlData/dim:dim">
							<xsl:call-template name="full_record" />
						</xsl:for-each>
												
					</div>
					
					<div class="col-sm-4">
					
						<div class="sidebar">
							<xsl:call-template name="browser" />
							<xsl:call-template name="admin" />
						</div>
						
					</div>
					
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="full_record">
				
		<h1><xsl:value-of select="dim:field[@mdschema='dc' and @element='title']" /></h1>
		
		<ul class="authors">
			<xsl:for-each select="dim:field[@mdschema='dc' and @element='contributor']">
				
				<li>
					<a href="#"><xsl:value-of select="text()" /></a>
				
					<xsl:if test="following-sibling::dim:field[@mdschema='dc' and @element='contributor']">
						<xsl:text> ; </xsl:text>
					</xsl:if>
				</li>
			
			</xsl:for-each>
		</ul>
		
        <xsl:if test="dim:field[@mdschema='dc' and @element='description' and @qualifier='abstract']">
    
            <div class="abstract">
                <xsl:value-of select="dim:field[@mdschema='dc' and @element='description' and @qualifier='abstract']" />
            </div>
            
       </xsl:if>
		
		<xsl:call-template name="files" />
			
		<dl>
			
			<xsl:if test="dim:field[@mdschema='dc' and @element='type']/text()">
		
				<div>
					<dt>Date:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='dc' and @element='date' and @qualifier='issued']" />
					</dd>
				</div>
				
			</xsl:if>
			
			<xsl:if test="dim:field[@mdschema='dc' and @element='type']/text()">
			
				<div>
					<dt>Primary Material Type:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='dc' and @element='type']" />
					</dd>
				</div>
				
			</xsl:if>
	
			<xsl:if test="dim:field[@mdschema='taaccct' and @element='type' and @qualifier='secondary']/text()">
			
				<div>
					<dt>Other Material Types:</dt>
					<dd>
						<xsl:for-each select="dim:field[@mdschema='taaccct' and @element='type' and @qualifier='secondary']">
							<xsl:value-of select="text()" />
							<xsl:if test="following-sibling::dim:field[@mdschema='taaccct' and @element='type' and @qualifier='secondary']">
								<xsl:text>, </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</dd>
				</div>
				
			</xsl:if>
			
			<xsl:if test="dim:field[@mdschema='dc' and @element='publisher']/text()">
			
				<div>
					<dt>Institution:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='dc' and @element='publisher']" />
					</dd>
				</div>
				
			</xsl:if>
	
			<xsl:if test="dim:field[@mdschema='taaccct' and @element='projectName']/text()">
			
				<div>
					<dt>Project Name:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='taaccct' and @element='projectName']" />
					</dd>
				</div>
				
			</xsl:if>

			<xsl:if test="dim:field[@mdschema='taaccct' and @element='round']/text()">
			
				<div>
					<dt>TAACCCT Round:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='taaccct' and @element='round']" />
					</dd>
				</div>
				
			</xsl:if>
			
			<xsl:if test="dim:field[@mdschema='dc' and @element='subject']/text()">
				
				<div>
					<dt>Subjects:</dt>
					<dd>
						<xsl:for-each select="dim:field[@mdschema='dc' and @element='subject']">
							
							<xsl:value-of select="text()" />
							
							<xsl:if test="following-sibling::dim:field[@mdschema='dc' and @element='subject']">
								<xsl:text>, </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</dd>
				</div>
				
			</xsl:if>
			
		</dl>
		
		<h2>Industry / Occupation</h2>
		
		<dl>
		
			<xsl:if test="dim:field[@mdschema='dc' and @element='description' and @qualifier='sponsorship']/text()">
			
				<div>
					<dt>Industry Partner:</dt>
					<dd>
						<xsl:for-each select="dim:field[@mdschema='dc' and @element='description' and @qualifier='sponsorship']">
							
							<xsl:value-of select="text()" />
						
							<xsl:if test="following-sibling::dim:field[@mdschema='dc' and @element='description' and @qualifier='sponsorship']">
								<xsl:text>, </xsl:text>

							</xsl:if>
						</xsl:for-each>
					</dd>
				</div>
				
			</xsl:if>
	
			<xsl:if test="dim:field[@mdschema='taaccct' and @element='industry']/text()">
			
				<div>
					<dt>Industry Sector:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='taaccct' and @element='industry']" />
					</dd>
				</div>
				
			</xsl:if>
	
			<xsl:if test="dim:field[@mdschema='taaccct' and @element='occupation']/text()">
			
				<div>
					<dt>Occupation:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='taaccct' and @element='occupation']" />
					</dd>
				</div>
				
			</xsl:if>
			
		</dl>
		
		<h2>Education / Instructional Information</h2>
		
		<dl>
	
			<xsl:if test="dim:field[@mdschema='taaccct' and @element='instructional']/text()">
			
				<div>
					<dt>Instructional Program:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='taaccct' and @element='instructional']" />
					</dd>
				</div>
				
			</xsl:if>
			
			<xsl:if test="dim:field[@mdschema='taaccct' and @element='creditType']/text()">
			
				<div>
					<dt>Credit Type:</dt>
					<dd>
						<ul>
							<xsl:for-each select="dim:field[@mdschema='taaccct' and @element='creditType']">
								
								<li><xsl:value-of select="text()" /></li>
								
							</xsl:for-each>
						</ul>
					</dd>
				</div>
				
			</xsl:if>
            
            <xsl:if test="dim:field[@mdschema='taaccct' and @element='credentialType']/text()">
			
				<div>
					<dt>Credential Type:</dt>
					<dd>
						<ul>
							<xsl:for-each select="dim:field[@mdschema='taaccct' and @element='credentialType']">
								
								<li><xsl:value-of select="text()" /></li>
								
							</xsl:for-each>
						</ul>
					</dd>
				</div>
				
			</xsl:if>
			
			<xsl:if test="dim:field[@mdschema='taaccct' and @element='level']/text()">
			
				<div>
					<dt>Educational Level of Materials:</dt>
					<dd>
                    	<ul>
							<xsl:for-each select="dim:field[@mdschema='taaccct' and @element='level']">
						
								<li><xsl:value-of select="text()" /> </li>
							
							</xsl:for-each>
                      	</ul>
					</dd>
				</div>
				
			</xsl:if>
	
			<xsl:if test="dim:field[@mdschema='cw' and @element='educationalUse']/text()">
			
				<div>
					<dt>Educational Use:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='cw' and @element='educationalUse']" />
					</dd>
				</div>
				
			</xsl:if>
	
			<xsl:if test="dim:field[@mdschema='cw' and @element='timeRequired']/text()">
			
				<div>
					<dt>Time Required:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='cw' and @element='timeRequired']" />
					</dd>
				</div>
				
			</xsl:if>

			<xsl:if test="dim:field[@mdschema='dc' and @element='language']/text()">
			
				<div>
					<dt>Language:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='dc' and @element='language']" />
                        
					</dd>
				</div>
				
			</xsl:if>
	
			<xsl:if test="dim:field[@mdschema='cw' and @element='interactivityType']/text()">
			
				<div>
					<dt>Interactivity Type:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='cw' and @element='interactivityType']" />
					</dd>
				</div>
				
			</xsl:if>

			<xsl:if test="dim:field[@mdschema='taaccct' and @element='quality']/text()">
			
				<div>
					<dt>Quality Rubric:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='taaccct' and @element='quality']" />
					</dd>
				</div>
				
			</xsl:if>

			<xsl:if test="dim:field[@mdschema='taaccct' and @element='qualityNote']/text()">
			
				<div>
					<dt>Quality Note:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='taaccct' and @element='qualityNote']" />
					</dd>
				</div>
				
			</xsl:if>
			
			<xsl:if test="dim:field[@mdschema='taaccct' and @element='SMQuality']/text()">
			
				<div>
					<dt>Quality of Subject Matter was assured by:</dt>
					<dd>
						<ul>
							<xsl:for-each select="dim:field[@mdschema='taaccct' and @element='SMQuality']">
								
								<li><xsl:value-of select="text()" /></li>
	
							</xsl:for-each>
						</ul>
					</dd>
				</div>
				
			</xsl:if>
			
			<xsl:if test="dim:field[@mdschema='taaccct' and @element='OCDQuality']/text()">
			
				<div>
					<dt>Quality of Online/Hybrid Course Design assured by:</dt>
					<dd>
						<ul>
							<xsl:for-each select="dim:field[@mdschema='taaccct' and @element='OCDQuality']">
								
								<li><xsl:value-of select="text()" /></li>

							</xsl:for-each>
						</ul>
					</dd>
				</div>
				
			</xsl:if>
			
			<xsl:if test="dim:field[@mdschema='taaccct' and @element='courseNote']/text()">
			
				<div>
					<dt>Course Note:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='taaccct' and @element='courseNote']" />
					</dd>
				</div>
				
			</xsl:if>
			
			<xsl:if test="dim:field[@mdschema='taaccct' and @element='object' and @qualifier='uri']/text()">
			
				<div>
					<dt>Additional Public Access To Materials:</dt>
					<dd>
						<xsl:for-each select="dim:field[@mdschema='taaccct' and @element='object' and @qualifier='uri']">
							<a href="{text()}">
								<xsl:value-of select="text()" />
							</a>
							<xsl:if test="following-sibling::dim:field[@mdschema='taaccct' and @element='object' and @qualifier='uri']">
								<br />
							</xsl:if>
						</xsl:for-each>
					</dd>
				</div>
				
			</xsl:if>
	
			<xsl:if test="dim:field[@mdschema='cw' and @element='isBasedOnUrl']/text()">
			
				<div>
					<dt>Derivative Work from Other's Materials:</dt>
					<dd>
						<xsl:for-each select="dim:field[@mdschema='cw' and @element='isBasedOnUrl']">
							<a href="{text()}">
								<xsl:value-of select="text()" />
							</a>
							<xsl:if test="following-sibling::dim:field[@mdschema='cw' and @element='isBasedOnUrl']">
								<br />
							</xsl:if>
						</xsl:for-each>
					</dd>
				</div>
				
			</xsl:if>
            
            <xsl:if test="dim:field[@mdschema='taaccct' and @element='courseSchedule']/text()">
			
				<div>
					<dt>Number of weeks per course:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='taaccct' and @element='courseSchedule']" />
                        
					</dd>
				</div>
				
			</xsl:if>
            
            
            <xsl:if test="dim:field[@mdschema='taaccct' and @element='programSchedule']/text()">
			
				<div>
					<dt>Number of courses in the program:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='taaccct' and @element='programSchedule']" />
                        
					</dd>
				</div>
				
			</xsl:if>
            
            <xsl:if test="dim:field[@mdschema='taaccct' and @element='deliveryFormat']/text()">
			
				<div>
					<dt>Program Delivery Format:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='taaccct' and @element='deliveryFormat']" />
                        
					</dd>
				</div>
				
			</xsl:if>
			
		</dl>

	<xsl:if test="dim:field[@mdschema='merlot']">

        <h2>Accessibility</h2>
            
            <dl>
            
                <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='formalPolicy']/text()">
                
                    <div>
                        <dt>Formal Accessibility Policy:</dt>
                        <dd>
                            <xsl:for-each select="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='formalPolicy']">
                                <a href="{text()}">
                                    <xsl:value-of select="text()" />
                                </a>
                                <xsl:if test="following-sibling::dim:field[@mdschema='merlot' and @element='ada' and @qualifier='formalPolicy']">
                                    <br />
                                </xsl:if>
                            </xsl:for-each>
                        </dd>
                    </div>
                    
                </xsl:if>
        
                <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='statement']/text()">
                
                    <div>
                        <dt>Accessibility Statement:</dt>
                        <dd>
                            <xsl:for-each select="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='statement']">
                                <a href="{text()}">
                                    <xsl:value-of select="text()" />
                                </a>
                                <xsl:if test="following-sibling::dim:field[@mdschema='merlot' and @element='ada' and @qualifier='statement']">
                                    <br />
                                </xsl:if>
                            </xsl:for-each>
                        </dd>
                    </div>
                    
                </xsl:if>
        
                <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='organization']/text()">
                
                    <div>
                        <dt>Accessibility Evaluation Report:</dt>
                        <dd>
                            <xsl:for-each select="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='organization']">
                                <a href="{text()}">
                                    <xsl:value-of select="text()" />
                                </a>
                                <xsl:if test="following-sibling::dim:field[@mdschema='merlot' and @element='ada' and @qualifier='organization']">
                                    <br />
                                </xsl:if>
                            </xsl:for-each>
                        </dd>
                    </div>
                    
                </xsl:if>
                
                <xsl:if test="dim:field[@mdschema='merlot'] = 'Yes'">
    
                    <div>
                        <dt>Accessibility Features:</dt>
                        <dd>
                        <ul>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='textAccess'] = 'Yes'">
                            
                                <li>Text Access - Text to Speech</li>
                                
                            </xsl:if>		
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='textAdjustmentCompatible'] = 'Yes'">
                            
                                <li>Text Adjust - Compatible</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='textAdjustable'] = 'Yes'">
                            
                                <li>Text Adjustment - Adjust Font and Colors</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='readingLayoutCompatible'] = 'Yes'">
                            
                                <li>Reading Layout - Reflow the Text</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='readingLayoutPageNumbers'] = 'Yes'">
                            
                                <li>Reading Layout - Page numbers match printed material</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='readingLayoutPageNumbersAlt'] = 'Yes'">
                            
                                <li>Reading Layout - Reflow the Text</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='readingOrder'] = 'Yes'">
                            
                                <li>Reading Order - Digital resource layout</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='structuralMarkupText'] = 'Yes'">
                            
                                <li>Structural Markup - Navigation Text</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='structuralMarkupLists'] = 'Yes'">
                            
                                <li>Structural Markup - Lists</li>
                                
                            </xsl:if>				
                            
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='structuralMarkupReaders'] = 'Yes'">
                            
                                <li>Structural Markup - eReader application</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='tableMarkup'] = 'Yes'">
                            
                                <li>Table Markup</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='hyperlinkActive'] = 'Yes'">
                            
                                <li>Hyperlinks Rendered As Active</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='color'] = 'Yes'">
                            
                                <li>Colors Compatible With Assistive Technology</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='contrast'] = 'Yes'">
                            
                                <li>Contrast Ratio of at Least 4.5:1.</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='languageMarkup'] = 'Yes'">
                            
                                <li>Language - Markup</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='languageMarkupAlt'] = 'Yes'">
                            
                                <li>Language - Passage Markup</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='imageAltText'] = 'Yes'">
                            
                                <li>Non-Decorative Images Have Alt Text</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='decorativeImages'] = 'Yes'">
                            
                                <li>Decorative Images Marked With Null Alt Text</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='complextImageText'] = 'Yes'">
                            
                                <li>Complex Images, Charts, and Graphs Have Text Descriptions</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='multimediaTextTrack'] = 'Yes'">
                            
                                <li>Synchronized Text Track</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='multimediaTranscript'] = 'Yes'">
                            
                                <li>Transcript Provided With Audio Content</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='multimediaAccessiblePlayer'] = 'Yes'">
                            
                                <li>Audio/Video Delivered Via Media Player</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='noFlickering'] = 'Yes'">
                            
                                <li>Non Flickering Content</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='stemMarkup'] = 'Yes'">
                            
                                <li>STEM Content (e.g. Mathematics, Chemistry) Markup</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='stemNotationMarkup'] = 'Yes'">
                            
                                <li>STEM - Notation markup</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='keyboardInteractive'] = 'Yes'">
                            
                                <li>Interactive - Keyboard</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='interactiveMarkup'] = 'Yes'">
                            
                                <li>Interactive - Markup</li>
                                
                            </xsl:if>
                            
                            <xsl:if test="dim:field[@mdschema='merlot' and @element='ada' and @qualifier='interactivePromptText'] = 'Yes'">
                            
                                <li>Interactive - Text prompts</li>
                                
                            </xsl:if>
    
                        </ul>
    
                        </dd>
                    </div>
    
                </xsl:if>
                
            </dl>
            
    </xsl:if>

	<h2>Copyright / Licensing</h2>
		
		<dl>
		
			<xsl:if test="dim:field[@mdschema='dcterms' and @element='rightsHolder']/text()">
			
				<div>
					<dt>Copyright Owner:</dt>
					<dd>
						<xsl:value-of select="dim:field[@mdschema='dcterms' and @element='rightsHolder']" />
					</dd>
				</div>
				
			</xsl:if>
	
			<xsl:if test="dim:field[@mdschema='dcterms' and @element='license']/text()">
			
				<div>
					<dt>Primary License:</dt>
					<dd>
						<xsl:call-template name="licenses">
							<xsl:with-param name="license" select="dim:field[@mdschema='dcterms' and @element='license']" />
						</xsl:call-template>
					</dd>
				</div>
				
			</xsl:if>
	
			<xsl:if test="dim:field[@mdschema='taaccct' and @element='license' and @qualifier='secondary']/text()">
			
				<div>
					<dt>Additional License(s):</dt>
					<dd>
						<xsl:for-each select="dim:field[@mdschema='taaccct' and @element='license' and @qualifier='secondary']" >

							<div>
								<xsl:call-template name="licenses">
									<xsl:with-param name="license" select="text()" />
								</xsl:call-template>
							</div>

							
						</xsl:for-each>

					</dd>
				</div>
				
			</xsl:if>
			&nbsp;
		</dl>
	
	</xsl:template>
	
	<xsl:template name="licenses">
	
		<xsl:param name="license"/>

		<xsl:choose>
			<xsl:when test="$license = 'CC BY'">

				<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.

			</xsl:when>

			<xsl:when test="$license = 'CC BY-SA'">

				<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

			</xsl:when>

			<xsl:when test="$license = 'CC BY-ND'">

				<a rel="license" href="http://creativecommons.org/licenses/by-nd/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nd/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nd/4.0/">Creative Commons Attribution-NoDerivatives 4.0 International License</a>.
			
			</xsl:when>

			<xsl:when test="$license = 'CC BY-NC'">
			
				<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.

			</xsl:when>

			<xsl:when test="$license = 'CC BY-NC-SA'">

				<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.

			</xsl:when>

			<xsl:when test="$license = 'CC BY-NC-ND'">

				<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License</a>.

			</xsl:when>

			<xsl:when test="$license = 'Public Domain'">

				<p>
					<a rel="license" href="http://creativecommons.org/publicdomain/mark/1.0/">
						<img src="http://i.creativecommons.org/p/mark/1.0/88x31.png" style="border-style: none;" alt="Public Domain Mark" />
					</a>
					<br />
						This work is free of known copyright restrictions.
				</p>

			</xsl:when>
            
            <xsl:when test="$license = 'CC0'">

				  	<a rel="license" href="http://creativecommons.org/publicdomain/zero/1.0/"><img src="http://i.creativecommons.org/p/zero/1.0/88x31.png" style="border-style: none;" alt="CC0" /></a> <br />To the extent possible under law, the person who associated CC0 with this work has waived all copyright and related or neighboring rights to this work.

			</xsl:when>

			<xsl:when test="$license = 'Other'">
            	Other - Please see material for licensing information.
			</xsl:when>
		
		</xsl:choose>
	</xsl:template>

	<xsl:template name="files">
	
		<div class="files">
			<xsl:if test="../../../../mets:fileSec/mets:fileGrp[@USE='CONTENT']/mets:file">
			<table>
				<xsl:for-each select="../../../../mets:fileSec/mets:fileGrp[@USE='CONTENT']/mets:file">				
					<tr>
						<td class="icon" title="file type">
							<xsl:call-template name="file_types" />
						</td>
						<td class="file-information" title="file information">
							<a href="{mets:FLocat/@xlink:href}">
								<xsl:choose>
									<xsl:when test="string-length(mets:FLocat/@xlink:label) &gt; 0">
										<xsl:value-of select="mets:FLocat/@xlink:label" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="mets:FLocat/@xlink:title" />
									</xsl:otherwise>
								</xsl:choose>
							</a>
							<xsl:text> </xsl:text>
							(<xsl:call-template name="file_size" />)
						</td>
					</tr>
				</xsl:for-each>
			</table>
			</xsl:if>
            &nbsp;
		</div>	
	
	</xsl:template>
		
</xsl:stylesheet>
