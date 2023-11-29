<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
        xmlns:cil="http://landskerfi.is"
        xmlns:array="http://www.w3.org/2005/xpath-functions/array"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        version="3.0" 
        expand-text="no">
    <xsl:template name="cilStyle">
        <style>
            body {
                font-family: 'Calibri', sans-serif;
            }
            h1 {
                font-size: 1.6em;
            }
            h2 {
                font-size: 1.3em;
            }
            h3 {
                <!-- same as normal text but bold -->
                font-size: 1em;
                font-weight: bold;
            }
            cil-patron {
            <!-- font-style: strong; -->
            }
            <!--1cm = 37.8px = 25.2/64in-->
            @media print and (max-width: 453px) {  
                body {
                    font-size: 120%;
                    color: green;
                }
            }
            @media print and (min-width: 454px) {  
                body {
                    font-size: 200%;
                    color: red;
                }
            }
        </style>
    </xsl:template>

    <xsl:template name="cilPatronDefault">
        <xsl:param name="sofn"/>
            <xsl:if test="array:size($sofn) = 0">
            <div>patronDefault</div>
            <xsl:value-of select="$currentLibraryCode"/>
            </xsl:if>
    </xsl:template>

    <xsl:template name="cilPatronDetails">
        <xsl:param name="sofn"/>
            <xsl:if test="($currentLibraryCode = $sofn)">
                <div>
                    <xsl:value-of select="notification_data/user_for_printing/name"/>
                </div>
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
            </xsl:if>
    </xsl:template>
   
    <xsl:template name="cilPatronKennitala">
        <xsl:param name="sofn"/>
            <xsl:if test="($currentLibraryCode = $sofn)">
                <div>
                    <xsl:for-each select="/notification_data/user_for_printing/identifiers/code_value">
                        <xsl:if test="./code = 'Primary Identifier'">
                            <xsl:value-of select="replace(./value,'[0-9]{6}','xxxxxx')"/>
                        </xsl:if>
                    </xsl:for-each>
                </div>
        </xsl:if>
    </xsl:template>
    <xsl:template name="cilLocationDetails">
        <xsl:param name="include"/>
        <xsl:choose>
            <xsl:when test="contains($include,$currentLibraryCode)">
        <h2>@@location@@:<xsl:value-of select="notification_data/phys_item_display/location_name"/></h2>
        <xsl:if test="notification_data/phys_item_display/call_number != ''">
            <h2>@@call_number@@:<xsl:value-of select="notification_data/phys_item_display/call_number"/></h2>
        </xsl:if>
        <xsl:if test="notification_data/phys_item_display/accession_number != ''">
            <h2>@@accession_number@@:<xsl:value-of select="notification_data/phys_item_display/accession_number"/></h2>
        </xsl:if>
        <xsl:if  test="notification_data/phys_item_display/shelving_location/string" >
            <xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
                <div>@@shelving_location_for_item@@: 
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
        </xsl:when>
        <xsl:otherwise>
            
        </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="cilTitleDetails">
        <xsl:param name="include"/>

        <xsl:choose>
            <xsl:when test="contains($include,$currentLibraryCode)">
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
        </xsl:when>
        <xsl:otherwise>
            
        </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="cilSortableByDate">
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
    <xsl:function name="cil:isEmpty" >
        <xsl:param name="sofn" as="array(*)"/>
        <xsl:sequence select="
            let $s := array:size($sofn)
            return $s = 0
                        "/>
    </xsl:function>
    <xsl:function name="cil:remove" as="array(*)">
        <xsl:param name="sofn" as="array(*)"/>
        <xsl:param name="codes" as="array(*)"/>
        <xsl:sequence select="
            let $f := array:filter($sofn, function($e){not(index-of($codes,$e) != 0)})
            return $f
                    "/>
    </xsl:function>
    <xsl:function name="cil:add" as="array(*)">
        <xsl:param name="sofn" as="array(*)"/>
        <xsl:param name="codes" as="array(*)"/>
        <xsl:sequence select="
            let $s := array:append($sofn,$codes)
            return $s
                        "/>
    </xsl:function>
    <xsl:variable name="library" select="/notification_data/organization_unit/org_scope/library_id"/>
    <xsl:variable name="libraries" as="element()*">
        <library>
            <code>ADAAN</code>
            <id>112189610006893</id>
            <name>Bókasafn Aðaldæla</name>
        </library>
        <library>
            <code>AHUAN</code>
            <id>112188070006893</id>
            <name>Bókasafnið á Blönduósi</name>
        </library>
        <library>
            <code>AKRAV</code>
            <id>112179390006893</id>
            <name>Bókasafn Akraness</name>
        </library>
        <library>
            <code>ALFGA</code>
            <id>112175660006893</id>
            <name>Álftanesskóli</name>
        </library>
        <library>
            <code>AMAAN</code>
            <id>112190150006893</id>
            <name>Amtsbókasafnið á Akureyri</name>
        </library>
        <library>
            <code>AMLAN</code>
            <id>112189250006893</id>
            <name>Amtsbókasafnið á Akureyri(les)</name>
        </library>
        <library>
            <code>AMSAV</code>
            <id>112180880006893</id>
            <name>Amtsbókasafnið Stykkishólmi</name>
        </library>
        <library>
            <code>ASKAS</code>
            <id>112185380006893</id>
            <name>Menningarmiðstöð Hornafjarðar</name>
        </library>
        <library>
            <code>BALAS</code>
            <id>112184120006893</id>
            <name>Lestrarfélagið Baldur</name>
        </library>
        <library>
            <code>BBAAA</code>
            <id>112178560006893</id>
            <name>Borgarbókasafnið Grófinni</name>
        </library>
        <library>
            <code>BBFAA</code>
            <id>112178200006893</id>
            <name>Borgarbókasafnið Spönginni</name>
        </library>
        <library>
            <code>BBGAA</code>
            <id>112177020006893</id>
            <name>Borgarbókasafnið Gerðubergi</name>
        </library>
        <library>
            <code>BBKAA</code>
            <id>112177200006893</id>
            <name>Borgarbókasafnið Kringlunni</name>
        </library>
        <library>
            <code>BBLAA</code>
            <id>112175840006893</id>
            <name>Borgarbókasafnið Klébergi</name>
        </library>
        <library>
            <code>BBRAA</code>
            <id>112176610006893</id>
            <name>Borgarbókasafnið Árbæ</name>
        </library>
        <library>
            <code>BBSAA</code>
            <id>112175120006893</id>
            <name>Borgarbókasafnið Sólheimum</name>
        </library>
        <library>
            <code>BBUAA</code>
            <id>112175300006893</id>
            <name>Borgarbókasafnið Úlfarsárdal</name>
        </library>
        <library>
            <code>BBYAA</code>
            <id>112178790006893</id>
            <name>Borgarbókasafnið Geymsla</name>
        </library>
        <library>
            <code>BESAA</code>
            <id>112178020006893</id>
            <name>Álftanessafn</name>
        </library>
        <library>
            <code>BGUAV</code>
            <id>112180160006893</id>
            <name>Bókasafn Grundarfjarðar</name>
        </library>
        <library>
            <code>BILAV</code>
            <id>112179620006893</id>
            <name>Bókasafnið Bíldudal</name>
        </library>
        <library>
            <code>BOLAV</code>
            <id>112181060006893</id>
            <name>Bókasafn Bolungavíkur</name>
        </library>
        <library>
            <code>BORAV</code>
            <id>112179210006893</id>
            <name>Héraðsbókasafn Borgarfjarðar</name>
        </library>
        <library>
            <code>BREAU</code>
            <id>112187110006893</id>
            <name>Bókasafnið á Breiðdalsvík</name>
        </library>
        <library>
            <code>DALAN</code>
            <id>112188840006893</id>
            <name>Bókasafn Dalvíkurbyggðar</name>
        </library>
        <library>
            <code>DALAV</code>
            <id>112180520006893</id>
            <name>Héraðsbókasafn Dalabyggðar</name>
        </library>
        <library>
            <code>DALGG</code>
            <id>112191520006893</id>
            <name>Dalskóli</name>
        </library>
        <library>
            <code>DJUAU</code>
            <id>112186340006893</id>
            <name>Bókasafn Djúpavogs</name>
        </library>
        <library>
            <code>ESKAU</code>
            <id>112186520006893</id>
            <name>Bókasafnið á Eskifirði</name>
        </library>
        <library>
            <code>EYRAS</code>
            <id>112182120006893</id>
            <name>Bókasafn Árborgar Eyrarbakka</name>
        </library>
        <library>
            <code>FASAU</code>
            <id>112186930006893</id>
            <name>Bókasafn Fáskrúðsfjarðar</name>
        </library>
        <library>
            <code>GARAA</code>
            <id>112176790006893</id>
            <name>Bókasafn Garðabæjar</name>
        </library>
        <library>
            <code>GRIAS</code>
            <id>112182530006893</id>
            <name>Bókasafn Grindavíkur</name>
        </library>
        <library>
            <code>GRYAN</code>
            <id>112189070006893</id>
            <name>Bókasafn Grýtubakkahrepps</name>
        </library>
        <library>
            <code>HAFAA</code>
            <id>112177380006893</id>
            <name>Bókasafn Hafnarfjarðar</name>
        </library>
        <library>
            <code>HELAS</code>
            <id>112183120006893</id>
            <name>Bókasafnið Hellu</name>
        </library>
        <library>
            <code>HERAU</code>
            <id>112186700006893</id>
            <name>Bókasafn Héraðsbúa</name>
        </library>
        <library>
            <code>HOFAN</code>
            <id>112187890006893</id>
            <name>Bókasafnið á Hofsósi</name>
        </library>
        <library>
            <code>HRAAN</code>
            <id>112189430006893</id>
            <name>Bókasafn Eyjafjarðarsveitar</name>
        </library>
        <library>
            <code>HRIAN</code>
            <id>112188250006893</id>
            <name>Bókasafnið í Hrísey</name>
        </library>
        <library>
            <code>HRUAS</code>
            <id>112183480006893</id>
            <name>Bókasafn Hrunamanna</name>
        </library>
        <library>
            <code>HUSAN</code>
            <id>112188430006893</id>
            <name>Bókasafnið á Húsavík</name>
        </library>
        <library>
            <code>HVEAS</code>
            <id>112181660006893</id>
            <name>Bókasafnið í Hveragerði</name>
        </library>
        <library>
            <code>ISAAV</code>
            <id>112180700006893</id>
            <name>Bókasafnið Ísafirði</name>
        </library>
        <library>
            <code>KERGS</code>
            <id>112185020006893</id>
            <name>Bókasafn Grímsnes- og Grafningshrepps</name>
        </library>
        <library>
            <code>KIRAS</code>
            <id>112183300006893</id>
            <name>Héraðsbókasafnið á Kirkjubæjarklaustri</name>
        </library>
        <library>
            <code>KOPAA</code>
            <id>112177610006893</id>
            <name>Bókasafn Kópavogs aðalsafn</name>
        </library>
        <library>
            <code>KOPAN</code>
            <id>112191100006893</id>
            <name>Bókasafn Öxarfjarðar</name>
        </library>
        <library>
            <code>LAUAS</code>
            <id>112182940006893</id>
            <name>Bókasafnið Laugalandi</name>
        </library>
        <library>
            <code>LINAA</code>
            <id>112176430006893</id>
            <name>Bókasafn Kópavogs Lindasafn</name>
        </library>
        <library>
            <code>LINGG</code>
            <id>112176020006893</id>
            <name>Lindaskóli</name>
        </library>
        <library>
            <code>MOSAA</code>
            <id>112174890006893</id>
            <name>Bókasafn Mosfellsbæjar</name>
        </library>
        <library>
            <code>MYVAN</code>
            <id>112189970006893</id>
            <name>Bókasafn Mývatnssveitar</name>
        </library>
        <library>
            <code>NORAA</code>
            <id>112175480006893</id>
            <name>Norræna húsið</name>
        </library>
        <library>
            <code>NORAU</code>
            <id>112185800006893</id>
            <name>Bókasafnið í Neskaupstað</name>
        </library>
        <library>
            <code>OLAAN</code>
            <id>112190740006893</id>
            <name>Bókasafn Fjallabyggðar Ól.</name>
        </library>
        <library>
            <code>OLFAS</code>
            <id>112184660006893</id>
            <name>Bókasafn Ölfuss</name>
        </library>
        <library>
            <code>RAFAA</code>
            <id>488692370006893</id>
            <name>Rafbókasafnið</name>
        </library>
        <library>
            <code>RAGAS</code>
            <id>112182300006893</id>
            <name>Héraðsbókasafn Rangæinga</name>
        </library>
        <library>
            <code>RAUAN</code>
            <id>112187530006893</id>
            <name>Bókasafnið á Raufarhöfn</name>
        </library>
        <library>
            <code>RES_SHARE</code>
            <id>12900830000231</id>
            <name>Resource Sharing Library</name>
        </library>
        <library>
            <code>REYAN</code>
            <id>112190380006893</id>
            <name>Bókasafn Reykdæla</name>
        </library>
        <library>
            <code>REYAS</code>
            <id>112183660006893</id>
            <name>Bókasafn Reykjanesbæjar</name>
        </library>
        <library>
            <code>REYAU</code>
            <id>112185620006893</id>
            <name>Bókasafnið á Reyðarfirði</name>
        </library>
        <library>
            <code>REYAV</code>
            <id>112180340006893</id>
            <name>Héraðsbókasafn Reykhólahrepps</name>
        </library>
        <library>
            <code>RUSAA</code>
            <id>112177840006893</id>
            <name>Rússneska bókasafnið</name>
        </library>
        <library>
            <code>SANAS</code>
            <id>112181480006893</id>
            <name>Bókasafn Suðurnesjabæjar</name>
        </library>
        <library>
            <code>SELAA</code>
            <id>112176200006893</id>
            <name>Bókasafn Seltjarnarness</name>
        </library>
        <library>
            <code>SELAS</code>
            <id>112183890006893</id>
            <name>Bókasafn Árborgar Selfossi</name>
        </library>
        <library>
            <code>SEYAU</code>
            <id>112185980006893</id>
            <name>Bókasafn Seyðisfjarðar</name>
        </library>
        <library>
            <code>SIGAN</code>
            <id>112190920006893</id>
            <name>Bókasafn Fjallabyggðar Sigl.</name>
        </library>
        <library>
            <code>SKAAN</code>
            <id>112188660006893</id>
            <name>Héraðsbókasafn Skagfirðinga</name>
        </library>
        <library>
            <code>SKEAS</code>
            <id>112184840006893</id>
            <name>Lestrarfél. Skeiða og Gnúp.</name>
        </library>
        <library>
            <code>SKGAN</code>
            <id>112191280006893</id>
            <name>Bókasafn Skagastrandar</name>
        </library>
        <library>
            <code>SNAAV</code>
            <id>112179030006893</id>
            <name>Bókasafn Snæfellsbæjar</name>
        </library>
        <library>
            <code>STAAS</code>
            <id>112184480006893</id>
            <name>Stapasafn</name>
        </library>
        <library>
            <code>STOAS</code>
            <id>112184300006893</id>
            <name>Bókasafn Árborgar Stokkseyri</name>
        </library>
        <library>
            <code>STOAU</code>
            <id>112186160006893</id>
            <name>Bókasafnið á Stöðvarfirði</name>
        </library>
        <library>
            <code>STOGN</code>
            <id>112187710006893</id>
            <name>Bókasafnið í Stórut.sk.</name>
        </library>
        <library>
            <code>STRAV</code>
            <id>112181240006893</id>
            <name>Héraðsbókasafn Strandasýslu</name>
        </library>
        <library>
            <code>SVAAN</code>
            <id>112190560006893</id>
            <name>Bókasafn Svalbarðsstrandar</name>
        </library>
        <library>
            <code>TALAV</code>
            <id>112179980006893</id>
            <name>Bókasafn Tálknafjarðar</name>
        </library>
        <library>
            <code>URRAA</code>
            <id>112178380006893</id>
            <name>Urriðaholtssafn</name>
        </library>
        <library>
            <code>VBAAV</code>
            <id>112179800006893</id>
            <name>Héraðsbókasafn V-Barðastr.</name>
        </library>
        <library>
            <code>VESAS</code>
            <id>112181890006893</id>
            <name>Bókasafn Vestmannaeyja</name>
        </library>
        <library>
            <code>VEYAS</code>
            <id>112185200006893</id>
            <name>Bókasafn V-Eyjafjallahrepps</name>
        </library>
        <library>
            <code>VHUAN</code>
            <id>112189790006893</id>
            <name>Bókasafn Húnaþings vestra</name>
        </library>
        <library>
            <code>VOPAU</code>
            <id>112187290006893</id>
            <name>Bókasafn Vopnafjarðar</name>
        </library>
        <library>
            <code>VSKAS</code>
            <id>112182760006893</id>
            <name>Héraðsbókasafn V-Skaft.</name>
        </library>
    </xsl:variable>
    <xsl:variable name="currentLibraryCode" select="$libraries[id=$library]/code"/>	
</xsl:stylesheet>
