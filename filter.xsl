<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cil="http://landskerfi.is"
	xmlns:array="http://www.w3.org/2005/xpath-functions/array"

    version="3.0"
    >
	<xsl:variable name="bbs" as="array(*)" select="[
			'BBAAA','BBFAA','BBGAA','BBKAA','BBLAA','BBRAA','BBSAA','BBUAA','BBYAA',
			'LINAA','KOPAA'
		]"/>
	
	<xsl:template match="/">
		<html>
			<head>
				<title>
                    Array:filter not working
				</title>
			</head>
			<body>
			    <p><xsl:value-of select="cil:remove($bbs,['BBLAA','LINAA'])"/></p>
                <!-- should return -->
                <!-- BBAAA BBFAA BBGAA BBKAA BBRAA BBSAA BBUAA BBYAA KOPAA -->
			</body>
		</html>
	</xsl:template>

    <xsl:function name="cil:remove" as="array(*)">
        <xsl:param name="sofn" as="array(*)"/>
        <xsl:param name="codes" as="array(*)"/>
        <xsl:sequence select="
            let $f := array:filter($sofn, function($e){not(index-of($codes,$e) != 0)})
            return $f
        "/>
    </xsl:function>

</xsl:stylesheet>
