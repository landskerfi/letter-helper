<?xml version="1.0" encoding="utf-8"?>
<xsl:transform version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cil="http://landskerfi.is"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array"
>
    <!-- ################################# -->
    <!-- #### Functions and Constants #### -->
    <!-- ################################# -->
    
    <!--                nafn               skilar-->
    <xsl:function name="cil:allExcept" as="xs:boolean">
        <!-- og tekur inn fylki af libakóðum ['BBAAA','...',...] -->
        <xsl:param name="codes" as="array(*)"/>
        <xsl:sequence select="
            let $f := cil:libIsIn(cil:removeLibs($alm,$codes))
            return $f
                        "/>
    </xsl:function>
    <xsl:function name="cil:noneExcept" as="xs:boolean">
        <xsl:param name="codes" as="array(*)"/>
        <xsl:sequence select="
            let $f := cil:libIsIn(cil:addLibs([],$codes))
            return $f
                        "/>
    </xsl:function>
    <xsl:function name="cil:libIsIn" as="xs:boolean">
        <xsl:param name="sofn" as="array(*)"/>
        <!-- <xsl:param name="code" as="xs:string"/> -->
        <xsl:sequence select="
            let $f := if (index-of($sofn,$currentLibraryCode)) then true() else false()
            return $f
                        "/>
    </xsl:function>
    <xsl:function name="cil:libIsNotIn" as="xs:boolean">
        <xsl:param name="sofn" as="array(*)"/>
        <!-- <xsl:param name="code" as="xs:string"/> -->
        <xsl:sequence select="
            let $f := if (index-of($sofn,$currentLibraryCode)) then false() else true()
            return $f
                        "/>
    </xsl:function>
    <xsl:function name="cil:removeLibs" as="array(*)">
        <xsl:param name="sofn" as="array(*)"/>
        <xsl:param name="codes" as="array(*)"/>
        <xsl:sequence select="
            (: let $f := array:filter($sofn, function($e){not(index-of($codes,$e) > 0)}) :)
            let $f := array:filter($sofn, function($e){not($e = $codes)})
            return $f
                        "/>
    </xsl:function>
    <xsl:function name="cil:addLibs" as="array(*)">
        <xsl:param name="sofn" as="array(*)"/>
        <xsl:param name="codes" as="array(*)"/>
        <xsl:sequence select="
            let $s := array:append($sofn,$codes)
            return $s
                        "/>
    </xsl:function> 


    <xsl:variable name="fn" select="/notification_data/user_for_printing/name"/>
    <xsl:variable name="request_id" select="/notification_data/request_id"/>
    <xsl:variable name="additional_id" select="concat(/notification_data/additional_id,'0006893')"/>
    <xsl:variable name="kt" select='/notification_data/user_for_printing/identifiers/code_value[code="Primary Identifier"]/value'/>
    <xsl:variable name="nafnKt" select="tokenize($fn,'\B(.)',';j') => serialize() => translate(' ','') => concat($kt => substring(7))"/>
    <xsl:variable name="barcode" select='/notification_data/phys_item_display/barcode'/>
    <xsl:variable name="req" select="if ($request_id != '') then $request_id else $additional_id"/>
    <xsl:variable name="db_url" select="'http://82.221.98.30/radari/requests/'"/>
    <xsl:variable name="db_request" select="concat($db_url,lower-case($currentLibraryCode),'/',$req,'/',$kt,'/',$barcode)"/>
    <xsl:variable name="jsonres" select="parse-json(unparsed-text($db_request))" as="map(*)" />
    <xsl:variable name="library" select="/notification_data/request/library_id"/>
    <xsl:variable name="libraries" as="element()*">
        <library>
            <code>BESAA</code>
            <id>112178020006893</id>
            <name>Álftanessafn</name>
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
            <code>ADAAN</code>
            <id>112189610006893</id>
            <name>Bókasafn Aðaldæla</name>
        </library>
        <library>
            <code>AKRAV</code>
            <id>112179390006893</id>
            <name>Bókasafn Akraness</name>
        </library>
        <library>
            <code>EYRAS</code>
            <id>112182120006893</id>
            <name>Bókasafn Árborgar Eyrarbakka</name>
        </library>
        <library>
            <code>SELAS</code>
            <id>112183890006893</id>
            <name>Bókasafn Árborgar Selfossi</name>
        </library>
        <library>
            <code>STOAS</code>
            <id>112184300006893</id>
            <name>Bókasafn Árborgar Stokkseyri</name>
        </library>
        <library>
            <code>BOLAV</code>
            <id>112181060006893</id>
            <name>Bókasafn Bolungavíkur</name>
        </library>
        <library>
            <code>DALAN</code>
            <id>112188840006893</id>
            <name>Bókasafn Dalvíkurbyggðar</name>
        </library>
        <library>
            <code>DJUAU</code>
            <id>112186340006893</id>
            <name>Bókasafn Djúpavogs</name>
        </library>
        <library>
            <code>HRAAN</code>
            <id>112189430006893</id>
            <name>Bókasafn Eyjafjarðarsveitar</name>
        </library>
        <library>
            <code>FASAU</code>
            <id>112186930006893</id>
            <name>Bókasafn Fáskrúðsfjarðar</name>
        </library>
        <library>
            <code>OLAAN</code>
            <id>112190740006893</id>
            <name>Bókasafn Fjallabyggðar Ól.</name>
        </library>
        <library>
            <code>SIGAN</code>
            <id>112190920006893</id>
            <name>Bókasafn Fjallabyggðar Sigl.</name>
        </library>
        <library>
            <code>GARAA</code>
            <id>112176790006893</id>
            <name>Bókasafn Garðabæjar</name>
        </library>
        <library>
            <code>KERGS</code>
            <id>112185020006893</id>
            <name>Bókasafn Grímsnes- og Grafningshrepps</name>
        </library>
        <library>
            <code>GRIAS</code>
            <id>112182530006893</id>
            <name>Bókasafn Grindavíkur</name>
        </library>
        <library>
            <code>BGUAV</code>
            <id>112180160006893</id>
            <name>Bókasafn Grundarfjarðar</name>
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
            <code>HERAU</code>
            <id>112186700006893</id>
            <name>Bókasafn Héraðsbúa</name>
        </library>
        <library>
            <code>HRUAS</code>
            <id>112183480006893</id>
            <name>Bókasafn Hrunamanna</name>
        </library>
        <library>
            <code>VHUAN</code>
            <id>112189790006893</id>
            <name>Bókasafn Húnaþings vestra</name>
        </library>
        <library>
            <code>AHUAN</code>
            <id>112188070006893</id>
            <name>Bókasafnið á Blönduósi</name>
        </library>
        <library>
            <code>BREAU</code>
            <id>112187110006893</id>
            <name>Bókasafnið á Breiðdalsvík</name>
        </library>
        <library>
            <code>ESKAU</code>
            <id>112186520006893</id>
            <name>Bókasafnið á Eskifirði</name>
        </library>
        <library>
            <code>HOFAN</code>
            <id>112187890006893</id>
            <name>Bókasafnið á Hofsósi</name>
        </library>
        <library>
            <code>HUSAN</code>
            <id>112188430006893</id>
            <name>Bókasafnið á Húsavík</name>
        </library>
        <library>
            <code>RAUAN</code>
            <id>112187530006893</id>
            <name>Bókasafnið á Raufarhöfn</name>
        </library>
        <library>
            <code>REYAU</code>
            <id>112185620006893</id>
            <name>Bókasafnið á Reyðarfirði</name>
        </library>
        <library>
            <code>STOAU</code>
            <id>112186160006893</id>
            <name>Bókasafnið á Stöðvarfirði</name>
        </library>
        <library>
            <code>BILAV</code>
            <id>112179620006893</id>
            <name>Bókasafnið Bíldudal</name>
        </library>
        <library>
            <code>HELAS</code>
            <id>112183120006893</id>
            <name>Bókasafnið Hellu</name>
        </library>
        <library>
            <code>HRIAN</code>
            <id>112188250006893</id>
            <name>Bókasafnið í Hrísey</name>
        </library>
        <library>
            <code>HVEAS</code>
            <id>112181660006893</id>
            <name>Bókasafnið í Hveragerði</name>
        </library>
        <library>
            <code>NORAU</code>
            <id>112185800006893</id>
            <name>Bókasafnið í Neskaupstað</name>
        </library>
        <library>
            <code>ISAAV</code>
            <id>112180700006893</id>
            <name>Bókasafnið Ísafirði</name>
        </library>
        <library>
            <code>STOGN</code>
            <id>112187710006893</id>
            <name>Bókasafnið í Stórut.sk.</name>
        </library>
        <library>
            <code>LAUAS</code>
            <id>112182940006893</id>
            <name>Bókasafnið Laugalandi</name>
        </library>
        <library>
            <code>KOPAA</code>
            <id>112177610006893</id>
            <name>Bókasafn Kópavogs aðalsafn</name>
        </library>
        <library>
            <code>LINAA</code>
            <id>112176430006893</id>
            <name>Bókasafn Kópavogs Lindasafn</name>
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
            <code>OLFAS</code>
            <id>112184660006893</id>
            <name>Bókasafn Ölfuss</name>
        </library>
        <library>
            <code>KOPAN</code>
            <id>112191100006893</id>
            <name>Bókasafn Öxarfjarðar</name>
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
            <code>SELAA</code>
            <id>112176200006893</id>
            <name>Bókasafn Seltjarnarness</name>
        </library>
        <library>
            <code>SEYAU</code>
            <id>112185980006893</id>
            <name>Bókasafn Seyðisfjarðar</name>
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
            <code>SANAS</code>
            <id>112181480006893</id>
            <name>Bókasafn Suðurnesjabæjar</name>
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
            <code>VOPAU</code>
            <id>112187290006893</id>
            <name>Bókasafn Vopnafjarðar</name>
        </library>
        <library>
            <code>BBRAA</code>
            <id>112176610006893</id>
            <name>Borgarbókasafnið Árbæ</name>
        </library>
        <library>
            <code>BBGAA</code>
            <id>112177020006893</id>
            <name>Borgarbókasafnið Gerðubergi</name>
        </library>
        <library>
            <code>BBYAA</code>
            <id>112178790006893</id>
            <name>Borgarbókasafnið Geymsla</name>
        </library>
        <library>
            <code>BBAAA</code>
            <id>112178560006893</id>
            <name>Borgarbókasafnið Grófinni</name>
        </library>
        <library>
            <code>BBLAA</code>
            <id>112175840006893</id>
            <name>Borgarbókasafnið Klébergi</name>
        </library>
        <library>
            <code>BBKAA</code>
            <id>112177200006893</id>
            <name>Borgarbókasafnið Kringlunni</name>
        </library>
        <library>
            <code>BBSAA</code>
            <id>112175120006893</id>
            <name>Borgarbókasafnið Sólheimum</name>
        </library>
        <library>
            <code>BBFAA</code>
            <id>112178200006893</id>
            <name>Borgarbókasafnið Spönginni</name>
        </library>
        <library>
            <code>BBUAA</code>
            <id>112175300006893</id>
            <name>Borgarbókasafnið Úlfarsárdal</name>
        </library>
        <library>
            <code>DALGG</code>
            <id>112191520006893</id>
            <name>Dalskóli</name>
        </library>
        <library>
            <code>BORAV</code>
            <id>112179210006893</id>
            <name>Héraðsbókasafn Borgarfjarðar</name>
        </library>
        <library>
            <code>DALAV</code>
            <id>112180520006893</id>
            <name>Héraðsbókasafn Dalabyggðar</name>
        </library>
        <library>
            <code>KIRAS</code>
            <id>112183300006893</id>
            <name>Héraðsbókasafnið á Kirkjubæjarklaustri</name>
        </library>
        <library>
            <code>RAGAS</code>
            <id>112182300006893</id>
            <name>Héraðsbókasafn Rangæinga</name>
        </library>
        <library>
            <code>REYAV</code>
            <id>112180340006893</id>
            <name>Héraðsbókasafn Reykhólahrepps</name>
        </library>
        <library>
            <code>SKAAN</code>
            <id>112188660006893</id>
            <name>Héraðsbókasafn Skagfirðinga</name>
        </library>
        <library>
            <code>STRAV</code>
            <id>112181240006893</id>
            <name>Héraðsbókasafn Strandasýslu</name>
        </library>
        <library>
            <code>VBAAV</code>
            <id>112179800006893</id>
            <name>Héraðsbókasafn V-Barðastr.</name>
        </library>
        <library>
            <code>VSKAS</code>
            <id>112182760006893</id>
            <name>Héraðsbókasafn V-Skaft.</name>
        </library>
        <library>
            <code>BALAS</code>
            <id>112184120006893</id>
            <name>Lestrarfélagið Baldur</name>
        </library>
        <library>
            <code>SKEAS</code>
            <id>112184840006893</id>
            <name>Lestrarfél. Skeiða og Gnúp.</name>
        </library>
        <library>
            <code>LINGG</code>
            <id>112176020006893</id>
            <name>Lindaskóli</name>
        </library>
        <library>
            <code>ASKAS</code>
            <id>112185380006893</id>
            <name>Menningarmiðstöð Hornafjarðar</name>
        </library>
        <library>
            <code>NORAA</code>
            <id>112175480006893</id>
            <name>Norræna húsið</name>
        </library>
        <library>
            <code>RAFAA</code>
            <id>488692370006893</id>
            <name>Rafbókasafnið</name>
        </library>
        <library>
            <code>RUSAA</code>
            <id>112177840006893</id>
            <name>Rússneska bókasafnið</name>
        </library>
        <library>
            <code>STAAS</code>
            <id>112184480006893</id>
            <name>Stapasafn</name>
        </library>
        <library>
            <code>URRAA</code>
            <id>112178380006893</id>
            <name>Urriðaholtssafn</name>
        </library>
    </xsl:variable>
    <xsl:variable name="currentLibraryCode" select="$libraries[id=$library]/code"/>	
    <xsl:variable name="currentLibraryName" select="$libraries[id=$library]/name"/>	
    <xsl:variable name='alm' as="array(*)" select="array {$libraries/code/text()}"/>


</xsl:transform>
