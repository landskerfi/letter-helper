<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:cil="http://landskerfi.is"
    >
    <xsl:import href="https://github.com/landskerfi/letter-helper/raw/main/alm-helper.xsl"/>
    
    <xsl:template match="/">
        <html>
            <head>
                
                <!-- <link rel="stylesheet" type="text/css" href="https://api.landskerfi.is/xml/alm-styles.css" /> -->
                <!-- <link rel="stylesheet" type="text/css" href="alm-styles.css" /> -->
                <style>
                    @import url('https://fonts.googleapis.com/css2?family=Libre+Barcode+39+Text');
                    *, *::before, *::after {
                    box-sizing: border-box;
                    }
                    * {
                    margin: 0;
                    }
                    body {
                    line-height: 1.5;
                    background-color: white; 
                    color: #000000; 
                    font-family: 'Calibri', sans-serif; 
                    font-size: 20px; 
                    max-width: 600px; 
                    padding: 20px 20px 20px 20px;
                    }
                    img, svg {
                    display: block;
                    max-width: 100%;
                    padding: 10px;
                    margin: auto;
                    }
                    p, h1, h2, h3, h4, h5, h6 {
                    overflow-wrap: break-word;
                    }
                    hr {
                    margin-top: 10px;
                    margin-bottom: 10px;
                    }
                    .barcode {
                    font-family: "Libre Barcode 39 Text", system-ui;
                    font-weight: 400;
                    font-style: normal;
                    font-size: 36px;
                    text-align: center;
                    
                    }
                </style>
            </head>
            <body>
                <div xsl:expand-text="yes">
                    
                    <!-- Röðun -->
                    <xsl:apply-templates select="notification_data/general_data/current_date"/>   
                    <hr/>
                    
                    <xsl:if test="cil:allExcept(['AMLAN','AMAAN'])">
                        <!-- Lánþegi -->
                        <xsl:apply-templates select="/notification_data/user_for_printing"/>
                        <hr/>
                    </xsl:if>
                    
                    <!-- Útlánið -->
                    <xsl:apply-templates select="/notification_data/phys_item_display"/>
                    <hr/>
                    
                    <!-- Afhendigastaður -->
                    <xsl:apply-templates select="/notification_data/destination"/>
                    
                    <xsl:if test="cil:noneExcept(['AMLAN','AMAAN'])">
                        <hr/>
                        <!-- Lánþegi -->
                        <xsl:apply-templates select="/notification_data/user_for_printing"/>
                    </xsl:if> 
                    
                    <!-- Athugasemd -->
                    <xsl:variable name="ath" as="xs:string" select="/notification_data/request/note"/>
                    <xsl:if test="cil:noneExcept([$nafnlaus])">
                        <xsl:if test="$ath"> 
                            <hr/>
                            <div><strong>Ath: </strong> { $ath }</div>
                        </xsl:if>
                    </xsl:if>
                    
                </div>
            </body>
        </html>
    </xsl:template>
    
    <!-- Röðun og dagsettning --> 
    <xsl:template match="current_date" expand-text="yes">
        <h1>
            #{$nafnKt}
            <!-- #{$res?shelf} -->
        </h1>
        <div style="text-align: right;">{cil:formatDate(.)}</div>
    </xsl:template>
    
    <!-- Lánþegi -->
    <xsl:template match="user_for_printing" expand-text="yes">
        <xsl:variable name="email" select="/notification_data/user_for_printing/email"/>
        <!-- <div><strong>@@requested_for@@:</strong></div> -->
        <div>
            <!-- Nafn -->
            <div>{if (cil:allExcept([$nafnlaus])) then ./name else ""}</div>
            
            <!-- Sími -->
            <div>{if (cil:allExcept([$nafnlaus])) then (concat('&#9742; ',./phone)) else ''}</div>
            
            <!-- geNumer (bara firsta eintak)-->
            <xsl:variable name="geNumer" as="xs:string" select="./identifiers/code_value[code='01'][1]/value"/>
            <div>{if (cil:allExcept([$nafnlaus])) then $geNumer else ''}</div>
            
            <!-- strikamerki -->
            <div style="text-align: center;">
                <xsl:variable name="geNumer" as="xs:string" select="./identifiers/code_value[code='01'][1]/value"/>
                <xsl:if test="cil:noneExcept([$nafnlaus])">
                    <div class="barcode">*{upper-case($geNumer)}*</div>
                    <!-- <xsl:variable name="bc" select="unparsed-text(concat('http://82.221.98.30/barcode/',$geNumer))"/> -->
                    <!-- <img src="{$bc}" width="200"/> -->
                </xsl:if>
            </div>
            <!-- Kennitala -->
            <div>
                <xsl:if test="cil:noneExcept([''])">
                    {replace(./identifiers/code_value[code="Primary Identifier"]/value,
                        '[0-9]{6}',
                        'xxxxxx-')}
                </xsl:if>
            </div>
            
            <!-- Tölvupóstur -->
            <div>{if ($email = '') then ('ATH! Ekkert Netfang') else ""}</div>
            <div>{if (cil:allExcept([$nafnlaus])) then $email else ""}</div>
        </div>
    </xsl:template>
    
    <!-- Útlánið -->
    <xsl:template match="phys_item_display" expand-text="yes">
        <div style="text-align: center;">
            
            <!-- Titill -->
            <div style="line-height: 20px">
                {./title}
                {./author}
            </div>
            
            <!-- Strikamerki -->
            <xsl:if test="cil:allExcept($nafnlaus)">
                <div style="text-align: center">
                    <xsl:if test="/notification_data/request/selected_inventory_type='ITEM'" >
                        <img src="cid:item_id_barcode.png" alt="Item Barcode"/>
                    </xsl:if>
                </div>
            </xsl:if>
            
            <!-- Staðsettning -->
            <xsl:if test="cil:allExcept($anStadsetningu)">
                <h4>
                    {./location_name} <br/>
                    {./call_number}
                </h4>
            </xsl:if>
        </div>
    </xsl:template>
    
    <!-- Endastaður -->
    <xsl:template match="destination" expand-text="yes">
        <div style="text-align: center;">
            <div>@@move_to_library@@:</div>
            <h2>{.}</h2>
            <!-- Tegund beiðni-->
            <div>{/notification_data/request_type}</div>
            <!--Strikamerki RequestId -->
            <xsl:if test="cil:allExcept(['KOPAA'])">
                <img src="cid:request_id_barcode.png"/>
            </xsl:if>
        </div>
    </xsl:template>
    
    <!-- ### Constants ### -->
    <xsl:variable name="request_id" select="/notification_data/request_id"/>
    <xsl:variable name="letter" select="/notification_data/general_data/letter_type"/>
    <xsl:variable name="destination" select="/notification_data/destination"/>
    <xsl:variable name="destinationCode" select="$libraries[name=$destination]/code"/>
    <xsl:variable name="kt" select='/notification_data/user_for_printing/identifiers/code_value[code="Primary Identifier"]/value'/>
    <xsl:variable name="barcode" select='/notification_data/phys_item_display/barcode'/>
    <xsl:variable name="db_request" select="concat($db_url,lower-case($destinationCode),'/',$request_id,'/',$kt,'/',$barcode,'/',$letter)"/>
    <xsl:variable name="res" select="parse-json(unparsed-text($db_request))" as="map(*)" />
    
    <!-- Safnalistar -->
    <xsl:variable name="anStadsetningu" as="array(xs:string)" select="[
            'BBAAA','BBFAA','BBGAA','BBKAA','BBLAA','BBRAA','BBSAA','BBUAA','BBYAA', 
            'AMAAN','AMLAN'
        ]"/>
    <xsl:variable name="bbsofn" as="array(xs:string)" select="[
            'BBAAA','BBFAA','BBGAA','BBKAA','BBLAA','BBRAA','BBSAA','BBUAA','BBYAA', 
            'LINAA','KOPAA'
        ]"/>
    <xsl:variable name="nafnlaus" as="array(xs:string)" select="[
            'BBAAA','BBFAA','BBGAA','BBKAA','BBLAA','BBRAA','BBSAA','BBUAA','BBYAA','MOSAA'
        ]"/>
</xsl:stylesheet>
