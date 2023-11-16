<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <script>console.log('xcvxcvxcv');</script>
	<xsl:template name="patronDetails">
		<div class="lkb-patron">
			
			<h1>
				<strong>@@requested_for@@ :
					<xsl:value-of select="notification_data/user_for_printing/name"/>
				</strong>
			</h1>
			<div>
				<xsl:for-each select="/notification_data/user_for_printing/identifiers/code_value">
					<xsl:if test="./code = 'Primary Identifier'">
						<xsl:value-of select="./value"/>
					</xsl:if>
				</xsl:for-each>
			</div>
			<xsl:if  test="/notification_data/user_for_printing/email != ''" >
				<div><xsl:value-of select="/notification_data/user_for_printing/email"/></div>
			</xsl:if>
			<xsl:if test="/notification_data/user_for_printing/phone != ''">
				<div><xsl:value-of select="/notification_data/user_for_printing/phone"/></div>
			</xsl:if>
			
		</div>
		
	</xsl:template>
	<xsl:template name="locationDetails">
		<div><h2><strong>@@location@@: </strong><xsl:value-of select="notification_data/phys_item_display/location_name"/></h2></div>
		<xsl:if test="notification_data/phys_item_display/call_number != ''">
			<div><h2><strong>@@call_number@@: </strong><xsl:value-of select="notification_data/phys_item_display/call_number"/></h2></div>
		</xsl:if>
		<xsl:if test="notification_data/phys_item_display/accession_number != ''">
			<div><h2><strong>@@accession_number@@: </strong><xsl:value-of select="notification_data/phys_item_display/accession_number"/></h2></div>
		</xsl:if>
		<xsl:if  test="notification_data/phys_item_display/shelving_location/string" >
			<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
				<div><strong>@@shelving_location_for_item@@: </strong>
					<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
						<xsl:value-of select="."/>
						&#160;
					</xsl:for-each>
				</div>
			</xsl:if>
			<xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
				<div><strong>@@shelving_locations_for_holding@@: </strong>
					<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
						<xsl:value-of select="."/>
						&#160;
					</xsl:for-each>
				</div>
			</xsl:if>
			<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
				<div><strong>@@shelving_locations_for_holding@@: </strong>
					<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
						<xsl:value-of select="."/>
						&#160;
					</xsl:for-each>
				</div>
			</xsl:if>
		</xsl:if>
		<xsl:if  test="notification_data/phys_item_display/display_alt_call_numbers/string" >
			<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
				<div><strong>@@alt_call_number@@: </strong>
					<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
						<xsl:value-of select="."/>
						&#160;
					</xsl:for-each>
				</div>
			</xsl:if>
			<xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
				<div><strong>@@alt_call_number@@: </strong>
					<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
						<xsl:value-of select="."/>
						&#160;
					</xsl:for-each>
				</div>
			</xsl:if>
			<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
				<div><strong>@@alt_call_number@@: </strong>
					<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
						<xsl:value-of select="."/>
						&#160;
					</xsl:for-each>
				</div>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="titleDetails">
		<!-- <div><xsl:call-template name="recordTitle" /> </div> -->
		<xsl:if test="notification_data/phys_item_display/author !=''">
			<div>
				<xsl:value-of select="notification_data/phys_item_display/author"/>
			</div>
		</xsl:if>
		<xsl:if test="notification_data/phys_item_display/issue_level_description !=''">
			<div>
				@@description@@ <xsl:value-of select="notification_data/phys_item_display/issue_level_description"/>
			</div>
		</xsl:if>
		
		
		<xsl:if test="notification_data/phys_item_display/issn != ''">
			<div><xsl:value-of select="notification_data/phys_item_display/issn"/></div>
		</xsl:if>
		<xsl:if test="notification_data/phys_item_display/edition != ''">
			<div><xsl:value-of select="notification_data/phys_item_display/edition"/></div>
		</xsl:if>
		<xsl:if test="notification_data/phys_item_display/imprint != ''">
			<div><xsl:value-of select="notification_data/phys_item_display/imprint"/></div>
		</xsl:if>
		
	</xsl:template>
	<xsl:template name="sortByCreationDate">
		<xsl:param name="toSortDate"/>
		<xsl:analyze-string select="$toSortDate" regex="([0-9]{{2}})/([0-9]{{2}})/([0-9]{{4}})">
			<xsl:matching-substring>
				<xsl:value-of select="regex-group(3)"/>
				<xsl:text>/</xsl:text>
				<xsl:value-of select="regex-group(2)"/>
				<xsl:text>/</xsl:text>
				<xsl:value-of select="regex-group(1)"/>
			</xsl:matching-substring>	
		</xsl:analyze-string>
	</xsl:template>
</xsl:stylesheet>
