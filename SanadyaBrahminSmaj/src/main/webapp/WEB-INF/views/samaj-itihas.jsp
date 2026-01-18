<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html lang="hi">
<head>
    <meta charset="UTF-8">
    <title>सनाढ्य ब्राह्मण समाज का इतिहास</title>

    <!-- Bootstrap -->
   
    <style>
        body {
            background: #fff7e6;
            font-family: 'Noto Serif Devanagari', serif;
            color: #3a2a1a;
        }

        /* Main Book Container */
        .heritage-book {
            max-width: 950px;
            margin: 40px auto 80px;
            background: #ffffff;
            padding: 50px 60px;
            border: 1px solid #ead7b7;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        }

        /* Title */
        .book-heading {
            display: flex;
            align-items: center;
            font-size: 30px;
            font-weight: 700;
            color: #e86c00;
            margin-bottom: 45px;
        }

        .book-heading span {
            width: 7px;
            height: 36px;
            background: #f37000;
            margin-right: 15px;
        }

        /* Chapter Block */
        .chapter {
            margin-bottom: 55px;
        }

        .chapter-title {
            font-size: 22px;
            font-weight: 600;
            color: #d65f00;
            margin-bottom: 15px;
            border-bottom: 2px solid #f2c89b;
            padding-bottom: 8px;
        }

        .chapter-content {
            font-size: 17px;
            line-height: 2;
            text-align: justify;
            white-space: pre-line;
        }

        /* Quote / Highlight */
        .heritage-quote {
            background: #fff3dc;
            border-left: 5px solid #e86c00;
            padding: 20px 25px;
            margin: 40px 0;
            font-style: italic;
        }

        /* Footer note */
        .page-footer {
            text-align: center;
            font-size: 14px;
            color: #8a6b4f;
            margin-top: 70px;
        }
    </style>
</head>

<body>

<div class="heritage-book">

    <!-- Page Title -->
    <div class="book-heading">
        <span></span>
        सनाढ्य ब्राह्मण समाज का इतिहास
    </div>

    <!-- Chapter 1 -->
    <div class="chapter">
        <div class="chapter-title">प्राचीन उत्पत्ति</div>
        <div class="chapter-content">
सनाढ्य ब्राह्मण समाज की उत्पत्ति वैदिक काल से मानी जाती है।
यह समाज वेद, शास्त्र, यज्ञ, अध्यापन और संस्कारों की परंपरा से जुड़ा रहा है।
“सनाढ्य” शब्द का उल्लेख विभिन्न प्राचीन ग्रंथों और ऐतिहासिक साक्ष्यों में मिलता है।
        </div>
    </div>

    <!-- Chapter 2 -->
    <div class="chapter">
        <div class="chapter-title">ऐतिहासिक योगदान</div>
        <div class="chapter-content">
सनाढ्य ब्राह्मणों ने शिक्षा, प्रशासन, धार्मिक अनुष्ठानों और सामाजिक सुधारों में
महत्वपूर्ण भूमिका निभाई है। मुगल एवं राजपूत काल में यह समाज
राजगुरु, दीवान, शिक्षक और परामर्शदाता के रूप में प्रतिष्ठित रहा।
        </div>
    </div>

    <!-- Quote -->
    <div class="heritage-quote">
        “संस्कार, सेवा और संस्कृति – यही सनाढ्य ब्राह्मण समाज की पहचान है।”
    </div>

    <!-- Chapter 3 -->
    <div class="chapter">
        <div class="chapter-title">आधुनिक युग में समाज</div>
        <div class="chapter-content">
आधुनिक युग में सनाढ्य ब्राह्मण समाज शिक्षा, तकनीक,
सामाजिक सेवा और राष्ट्र निर्माण में निरंतर योगदान दे रहा है।
समाज आज भी अपनी परंपराओं के साथ आधुनिकता को आत्मसात कर रहा है।
        </div>
    </div>

    <!-- Footer -->
    <div class="page-footer">
        © सनाढ्य ब्राह्मण समाज | परंपरा • संस्कार • सेवा
    </div>

</div>

</body>
</html> 			<%@ include file="/WEB-INF/views/includes/footer.jsp" %>