<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:template match="/invoice">

<fo:root>

  <!-- ================= पेज लेआउट ================= -->
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

    <!-- ================= फुटर ================= -->
    <fo:static-content flow-name="xsl-region-after">
      <fo:block font-family="NotoDeva"
                font-size="9pt"
                text-align="center"
                color="#666666">
        यह कंप्यूटर द्वारा जनरेट की गई रसीद है | धन्यवाद
      </fo:block>
    </fo:static-content>

    <!-- ================= मुख्य भाग ================= -->
    <fo:flow flow-name="xsl-region-body"
             font-family="NotoDeva"
             font-size="11pt">

      <!-- ================= हेडर ================= -->
     <!-- ================= HEADER ================= -->
<fo:block-container margin-bottom="16pt">

  <fo:table width="100%" table-layout="fixed">
    <fo:table-column column-width="70%"/>
    <fo:table-column column-width="30%"/>

    <fo:table-body>
      <fo:table-row>

        <!-- LEFT : BIG SOCIETY NAME -->
        <fo:table-cell>
          <fo:block
              font-family="NotoDeva"
              font-size="26pt"
              font-weight="bold"
              color="#7a4200"
              text-align="left">
            सनाढ्य ब्राह्मण समाज
          </fo:block>

          <fo:block
              font-family="NotoDeva"
              font-size="12pt"
              font-weight="bold"
              color="#5e3400"
              margin-top="4pt">
            बुकिंग रसीद
          </fo:block>
        </fo:table-cell>

        <!-- RIGHT : LOGO -->
        <fo:table-cell text-align="right" display-align="center">
          <fo:block>
            <fo:external-graphic
                src="url('classpath:/images/logo.png')"
                content-width="90px"/>
          </fo:block>
        </fo:table-cell>

      </fo:table-row>
    </fo:table-body>
  </fo:table>

</fo:block-container>


      <fo:block space-after="14pt"/>

      <!-- ================= बुकिंग विवरण ================= -->
      <fo:block>
        <fo:block>
          <fo:inline font-weight="bold">बुकिंग कोड:</fo:inline>
          <xsl:value-of select="bookingCode"/>
        </fo:block>

        <fo:block>
          <fo:inline font-weight="bold">अतिथि का नाम:</fo:inline>
          <xsl:value-of select="guestName"/>
        </fo:block>

        <fo:block>
          <fo:inline font-weight="bold">मोबाइल नंबर:</fo:inline>
          <xsl:value-of select="phone"/>
        </fo:block>

        <fo:block>
          <fo:inline font-weight="bold">रूम विवरण:</fo:inline>
          <xsl:value-of select="room"/>
        </fo:block>

        <fo:block>
          <fo:inline font-weight="bold">प्रवास अवधि:</fo:inline>
          <xsl:value-of select="checkIn"/> से
          <xsl:value-of select="checkOut"/> तक
        </fo:block>
      </fo:block>

      <fo:block space-before="16pt"/>

      <!-- ================= राशि तालिका ================= -->
      <fo:table width="100%"
                table-layout="fixed"
                border="0.5pt solid #999999">

        <fo:table-column column-width="70%"/>
        <fo:table-column column-width="30%"/>

        <fo:table-header>
          <fo:table-row background-color="#ffe0b3">
            <fo:table-cell padding="6pt">
              <fo:block font-weight="bold">विवरण</fo:block>
            </fo:table-cell>
            <fo:table-cell padding="6pt" text-align="right">
              <fo:block font-weight="bold">राशि (₹)</fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-header>

        <fo:table-body>

          <fo:table-row>
            <fo:table-cell padding="6pt">
              <fo:block>रूम शुल्क</fo:block>
            </fo:table-cell>
            <fo:table-cell padding="6pt" text-align="right">
              <fo:block><xsl:value-of select="roomPrice"/></fo:block>
            </fo:table-cell>
          </fo:table-row>

          <fo:table-row>
            <fo:table-cell padding="6pt">
              <fo:block>जीएसटी (12%)</fo:block>
            </fo:table-cell>
            <fo:table-cell padding="6pt" text-align="right">
              <fo:block><xsl:value-of select="gst"/></fo:block>
            </fo:table-cell>
          </fo:table-row>

          <fo:table-row background-color="#fff3d6">
            <fo:table-cell padding="6pt">
              <fo:block font-weight="bold">कुल देय राशि</fo:block>
            </fo:table-cell>
            <fo:table-cell padding="6pt" text-align="right">
              <fo:block font-weight="bold">
                <xsl:value-of select="total"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>

        </fo:table-body>
      </fo:table>

      <fo:block space-before="16pt"/>

      <!-- ================= नोट ================= -->
      <fo:block font-size="9pt">
        • जीएसटी लागू नियमों के अनुसार है  
        <fo:block/>
        • भुगतान के पश्चात यह रसीद मान्य है
      </fo:block>

    </fo:flow>
  </fo:page-sequence>
</fo:root>

</xsl:template>
</xsl:stylesheet>
