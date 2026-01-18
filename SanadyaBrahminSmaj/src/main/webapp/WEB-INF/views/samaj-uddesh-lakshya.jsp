<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html lang="hi">
<head>
    <meta charset="UTF-8">
    <title>समाज का उद्देश्य एवं लक्ष्य</title>

   
    <style>
        body {
            background: #fff7e6;
            font-family: 'Noto Serif Devanagari', serif;
            color: #3a2a1a;
        }

        /* Book Container */
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

        /* Section */
        .section {
            margin-bottom: 55px;
        }

        .section-title {
            font-size: 22px;
            font-weight: 600;
            color: #d65f00;
            margin-bottom: 18px;
            border-bottom: 2px solid #f2c89b;
            padding-bottom: 8px;
        }

        .section-content {
            font-size: 17px;
            line-height: 2;
            text-align: justify;
            white-space: pre-line;
        }

        /* Bullet list */
        .heritage-list {
            margin-top: 15px;
            padding-left: 20px;
        }

        .heritage-list li {
            margin-bottom: 12px;
            line-height: 1.9;
        }

        /* Highlight Box */
        .heritage-highlight {
            background: #fff3dc;
            border-left: 5px solid #e86c00;
            padding: 22px 25px;
            margin: 45px 0;
            font-style: italic;
        }

        /* Footer */
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
        समाज का उद्देश्य एवं लक्ष्य
    </div>

    <!-- उद्देश्य -->
    <div class="section">
        <div class="section-title">समाज का उद्देश्य</div>
        <div class="section-content">
सनाढ्य ब्राह्मण समाज का मुख्य उद्देश्य समाज के सदस्यों को
एकता के सूत्र में बाँधना, सांस्कृतिक मूल्यों की रक्षा करना तथा
शिक्षा, संस्कार और सेवा के माध्यम से सामाजिक उत्थान करना है।
        </div>

        <ul class="heritage-list">
            <li>सनाढ्य ब्राह्मण समाज की परंपराओं एवं संस्कारों का संरक्षण</li>
            <li>समाज में शिक्षा, नैतिकता एवं संस्कारों का प्रसार</li>
            <li>आपसी सहयोग, एकता एवं भाईचारे को सुदृढ़ बनाना</li>
            <li>आवश्यकता पड़ने पर समाज के कमजोर वर्गों की सहायता</li>
            <li>सांस्कृतिक, धार्मिक एवं सामाजिक गतिविधियों का संचालन</li>
        </ul>
    </div>

    <!-- Highlight -->
    <div class="heritage-highlight">
        “समाज की सशक्तता, संस्कारों की दृढ़ता और सेवा की भावना — यही हमारा उद्देश्य है।”
    </div>

    <!-- लक्ष्य -->
    <div class="section">
        <div class="section-title">समाज के लक्ष्य</div>
        <div class="section-content">
समाज के लक्ष्य दूरदर्शी एवं समावेशी हैं, जिनका उद्देश्य
वर्तमान एवं भविष्य की पीढ़ियों को सशक्त बनाना है।
        </div>

        <ul class="heritage-list">
            <li>शिक्षा के क्षेत्र में समाज के युवाओं को प्रोत्साहित करना</li>
            <li>आधुनिक तकनीक के साथ पारंपरिक मूल्यों का संतुलन</li>
            <li>रोज़गार, मार्गदर्शन एवं आत्मनिर्भरता को बढ़ावा देना</li>
            <li>सामाजिक कुरीतियों के विरुद्ध जागरूकता फैलाना</li>
            <li>राष्ट्र निर्माण में सक्रिय एवं सकारात्मक भूमिका निभाना</li>
        </ul>
    </div>

    <!-- Footer -->
    <div class="page-footer">
        © सनाढ्य ब्राह्मण समाज | उद्देश्य • एकता • प्रगति
    </div>

</div>


</body>
</html> 			<%@ include file="/WEB-INF/views/includes/footer.jsp" %>