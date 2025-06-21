<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="hi">
<head>
    <title>मुख्य पृष्ठ - सनाढ्य ब्राह्मण सभा, कोटा</title>
    <style>
        body {
            background-color: #fffaf0;
            font-family: 'Segoe UI', 'Noto Sans Devanagari', sans-serif;
        }

        .scroll-wrapper {
            height: 200px; /* Approx height of 2 cards */
            overflow: hidden;
            position: relative;
        }

        .scroll-content {
            animation: scrollUp 15s linear infinite;
        }

        .scroll-wrapper:hover .scroll-content {
            animation-play-state: paused;
        }

        @keyframes scrollUp {
            0% { transform: translateY(0); }
            100% { transform: translateY(-50%); } /* Scroll half the height (for seamless loop) */
        }

        .card-custom {
            /* border: 8px solid #e65100; */
            border-radius: 12px;
            background-color: #fff;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 24px;
            width: 100%;
        }

        .card-title-custom {
            color: #e65100;
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .card-text-custom {
            font-size: 1rem;
            font-weight: 500;
            color: #333;
            line-height: 1.5;
        }

        .view-button {
            background: linear-gradient(to right, #f95c08, #e65100);
            color: white;
            padding: 6px 18px;
            border-radius: 6px;
            font-weight: 500;
            border: none;
            transition: background 0.3s ease;
        }

        .view-button:hover {
            background: linear-gradient(to right, #8e4103, #b46a03);
        }
    </style>
</head>
<body>
<h4 class="text-center mb-4 text-danger fw-bold" style="margin-bottom: -20px;">📅 आगामी कार्यक्रम</h4>

<div class="container py-4">
    
    <div class="scroll-wrapper"  style="margin-top: -20px;margin-bottom: -20px;">
        <div class="scroll-content">
            <%-- Duplicate content block for smooth loop --%>
            <c:forEach var="i" begin="1" end="2"> 
                <!-- 🔶 Event 1 -->
                <div class="card-custom">
                    <div class="card-title-custom">15 जुलाई: अखिल भारतीय सम्मेलन <span class="text-danger">NEW!</span></div>
                    <div class="card-text-custom">
                        यह कार्यक्रम कोटा के सभागृह में आयोजित किया जाएगा जिसमें समाज के सभी सदस्यों को आमंत्रित किया गया है। कृपया समय से पधारें।
                    </div>
                    <!-- <div class="text-end mt-3">
                        <a href="/events/1"><button class="view-button">View Details</button></a>
                    </div> -->
                </div>

                <!-- 🔶 Event 2 -->
                <div class="card-custom">
                    <div class="card-title-custom">20 जुलाई: रक्तदान शिविर</div>
                    <div class="card-text-custom">
                        मेडिकल कॉलेज में आयोजित इस शिविर में सभी से आग्रह है कि वे रक्तदान करें और मानवता की सेवा में योगदान दें।
                    </div>
                   
                </div>

                <!-- 🔶 Event 3 -->
                <div class="card-custom">
                    <div class="card-title-custom">1 अगस्त: सामूहिक विवाह सम्मेलन</div>
                    <div class="card-text-custom">
                        योग्य वर-वधु के लिए सामूहिक विवाह का आयोजन किया जा रहा है। आवेदन शीघ्र करें।
                    </div>
                    
                </div>

                <!-- 🔶 Event 4 -->
                <div class="card-custom">
                    <div class="card-title-custom">10 अगस्त: महिला सशक्तिकरण वर्कशॉप</div>
                    <div class="card-text-custom">
                        समाज की महिलाओं के लिए कार्यशाला - प्रेरणा, आत्मनिर्भरता और नेतृत्व के विषयों पर।
                    </div>
                   
                </div>

                <!-- 🔶 Event 5 -->
                <div class="card-custom">
                    <div class="card-title-custom">25 अगस्त: युवा संवाद सत्र</div>
                    <div class="card-text-custom">
                        समाज के युवा साथियों के लिए विशेष संवाद सत्र - नेटवर्किंग और प्रेरणा से भरपूर।
                    </div>
                    
                </div>
            </c:forEach>
        </div>
    </div>

</div>

</body>
</html>
