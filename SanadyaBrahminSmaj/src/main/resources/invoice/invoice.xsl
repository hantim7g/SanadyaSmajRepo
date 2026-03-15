<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:template match="/invoice">

<fo:root>

<!-- PAGE LAYOUT -->

<fo:layout-master-set>

<fo:simple-page-master master-name="A4"
page-height="29.7cm"
page-width="21cm"
margin="2cm">

<fo:region-body margin-bottom="2cm"/>
<fo:region-after extent="1.5cm"/>

</fo:simple-page-master>

</fo:layout-master-set>

<fo:page-sequence master-reference="A4">

<!-- FOOTER -->

<fo:static-content flow-name="xsl-region-after">

<fo:block font-family="NotoDeva"
font-size="9pt"
text-align="center"
color="#666666">

यह कंप्यूटर द्वारा जनरेट की गई रसीद है | धन्यवाद

</fo:block>

</fo:static-content>

<fo:flow flow-name="xsl-region-body"
font-family="NotoDeva"
font-size="11pt">

<!-- HEADER -->

<fo:block-container margin-bottom="16pt">

<fo:table width="100%" table-layout="fixed">

<fo:table-column column-width="70%"/>
<fo:table-column column-width="30%"/>

<fo:table-body>

<fo:table-row>

<fo:table-cell>

<fo:block
font-size="26pt"
font-weight="bold"
color="#7a4200">

सनाढ्य ब्राह्मण महासभा

</fo:block>

<fo:block
font-size="12pt"
font-weight="bold"
color="#5e3400">

बुकिंग रसीद

</fo:block>

</fo:table-cell>
<!--
<fo:table-cell text-align="right">

<fo:block>

<fo:external-graphic
src="url('classpath:/images/logo.png')"
content-width="90px"/>

</fo:block>

</fo:table-cell>
-->
</fo:table-row>

</fo:table-body>

</fo:table>

</fo:block-container>

<!-- BOOKING DETAILS -->

<fo:block>

<fo:block>
<fo:inline font-weight="bold">बुकिंग कोड :</fo:inline>
<xsl:value-of select="bookingCode"/>
</fo:block>

<fo:block>
<fo:inline font-weight="bold">अतिथि का नाम :</fo:inline>
<xsl:value-of select="guestName"/>
</fo:block>

<fo:block>
<fo:inline font-weight="bold">मोबाइल :</fo:inline>
<xsl:value-of select="phone"/>
</fo:block>

<fo:block>
<fo:inline font-weight="bold">रूम :</fo:inline>
<xsl:value-of select="room"/>
</fo:block>

<fo:block>
<fo:inline font-weight="bold">चेक-इन :</fo:inline>
<xsl:value-of select="checkIn"/>
</fo:block>

<fo:block>
<fo:inline font-weight="bold">चेक-आउट :</fo:inline>
<xsl:value-of select="checkOut"/>
</fo:block>

<fo:block>
<fo:inline font-weight="bold">कुल रातें :</fo:inline>
<xsl:value-of select="nights"/>
</fo:block>

<fo:block>
<fo:inline font-weight="bold">बुकिंग स्थिति :</fo:inline>
<xsl:value-of select="bookingStatus"/>
</fo:block>

</fo:block>

<!-- PAYMENT DETAILS -->

<fo:block 
font-weight="bold" padding="6pt"
font-size="13pt" background-color="#ffe0b3">

भुगतान विवरण

</fo:block>

<fo:table width="100%" border="0.5pt solid #999999">

<fo:table-column column-width="50%"/>
<fo:table-column column-width="50%"/>

<fo:table-body>

<fo:table-row>

<fo:table-cell padding="5pt">
<fo:block>ट्रांजैक्शन आईडी</fo:block>
</fo:table-cell>

<fo:table-cell padding="5pt">
<fo:block>
<xsl:value-of select="transactionId"/>
</fo:block>
</fo:table-cell>

</fo:table-row>

<fo:table-row>

<fo:table-cell padding="5pt">
<fo:block>भुगतान मोड</fo:block>
</fo:table-cell>

<fo:table-cell padding="5pt">
<fo:block>
<xsl:value-of select="paymentMode"/>
</fo:block>
</fo:table-cell>

</fo:table-row>

<fo:table-row>

<fo:table-cell padding="5pt">
<fo:block>भुगतान स्थिति</fo:block>
</fo:table-cell>

<fo:table-cell padding="5pt">
<fo:block>
<xsl:value-of select="paymentStatus"/>
</fo:block>
</fo:table-cell>

</fo:table-row>

<fo:table-row >

<fo:table-cell padding="5pt">
<fo:block>भुगतान तिथि</fo:block>
</fo:table-cell>

<fo:table-cell padding="5pt">
<fo:block>
<xsl:value-of select="paymentDate"/>
</fo:block>
</fo:table-cell>

</fo:table-row>

</fo:table-body>

</fo:table>

<!-- GST TABLE -->

<fo:block space-before="16pt"
font-weight="bold"
font-size="13pt">

GST विवरण

</fo:block>

<fo:table width="100%"
border="0.5pt solid #999999">

<fo:table-column column-width="70%"/>
<fo:table-column column-width="30%"/>

<fo:table-header>

<fo:table-row background-color="#ffe0b3">

<fo:table-cell padding="6pt">
<fo:block font-weight="bold">विवरण</fo:block>
</fo:table-cell>

<fo:table-cell padding="6pt"
text-align="right">

<fo:block font-weight="bold">

राशि (₹)

</fo:block>

</fo:table-cell>

</fo:table-row>

</fo:table-header>

<fo:table-body>

<fo:table-row>

<fo:table-cell padding="6pt">
<fo:block>रूम शुल्क</fo:block>
</fo:table-cell>

<fo:table-cell padding="6pt" text-align="right">
<fo:block>
<xsl:value-of select="roomPrice"/>
</fo:block>
</fo:table-cell>

</fo:table-row>

<fo:table-row>

<fo:table-cell padding="6pt">
<fo:block>GST</fo:block>
</fo:table-cell>

<fo:table-cell padding="6pt" text-align="right">
<fo:block>
<xsl:value-of select="gst"/>
</fo:block>
</fo:table-cell>

</fo:table-row>

<fo:table-row background-color="#fff3d6">

<fo:table-cell padding="6pt">
<fo:block font-weight="bold">

कुल राशि

</fo:block>
</fo:table-cell>

<fo:table-cell padding="6pt" text-align="right">

<fo:block font-weight="bold">

<xsl:value-of select="total"/>

</fo:block>

</fo:table-cell>

</fo:table-row>

</fo:table-body>

</fo:table>

<!-- GUEST TABLE -->
<!-- GUEST TABLE -->

<fo:block space-before="16pt"
font-weight="bold"
font-size="13pt">

अतिथि सूची

</fo:block>

<fo:table width="100%" border="0.5pt solid #999999">

<fo:table-column column-width="10%"/>
<fo:table-column column-width="60%"/>
<fo:table-column column-width="30%"/>

<fo:table-header>

<fo:table-row background-color="#ffe0b3">

<fo:table-cell padding="6pt">
<fo:block>#</fo:block>
</fo:table-cell>

<fo:table-cell padding="6pt">
<fo:block>नाम</fo:block>
</fo:table-cell>

<fo:table-cell padding="6pt">
<fo:block>आयु</fo:block>
</fo:table-cell>

</fo:table-row>

</fo:table-header>

<fo:table-body>

<xsl:choose>

<xsl:when test="count(guests/guest) &gt; 0">

<xsl:for-each select="guests/guest">

<fo:table-row>

<fo:table-cell padding="5pt">
<fo:block>
<xsl:value-of select="position()"/>
</fo:block>
</fo:table-cell>

<fo:table-cell padding="5pt">
<fo:block>
<xsl:value-of select="name"/>
</fo:block>
</fo:table-cell>

<fo:table-cell padding="5pt">
<fo:block>
<xsl:value-of select="age"/>
</fo:block>
</fo:table-cell>

</fo:table-row>

</xsl:for-each>

</xsl:when>

<xsl:otherwise>

<fo:table-row>

<fo:table-cell padding="5pt">
<fo:block>-</fo:block>
</fo:table-cell>

<fo:table-cell padding="5pt">
<fo:block>No Guests</fo:block>
</fo:table-cell>

<fo:table-cell padding="5pt">
<fo:block>-</fo:block>
</fo:table-cell>

</fo:table-row>

</xsl:otherwise>

</xsl:choose>

</fo:table-body>

</fo:table>
 

<fo:block>

<fo:external-graphic
src="url('{qrCodePath}')"
content-width="100px"/>

</fo:block>

</fo:flow>

</fo:page-sequence>

</fo:root>

</xsl:template>

</xsl:stylesheet>