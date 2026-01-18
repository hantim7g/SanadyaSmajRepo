<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<footer class="site-footer mt-5">
    <div class="container-fluid footer-top py-5">
        <div class="container">
            <div class="row gy-4">

                <!-- ABOUT -->
                <div class="col-lg-4 col-md-6">
                    <h5 class="footer-title">सनाढ्य ब्राह्मण सभा, कोटा</h5>
                    <p class="footer-text">
                        सनाढ्य ब्राह्मण समाज की आधिकारिक डिजिटल पहल,
                        जिसका उद्देश्य समाज को एक मंच पर लाना,
                        परंपरा, संस्कार और सेवा को आगे बढ़ाना है।
                    </p>
                </div>

                <!-- QUICK LINKS -->
                <div class="col-lg-2 col-md-6">
                    <h6 class="footer-title">त्वरित लिंक</h6>
                    <ul class="footer-links">
                        <li><a href="/">मुख्यपृष्ठ</a></li>
                        <li><a href="/guidance">मार्गदर्शन</a></li>
                        <li><a href="/officials">पदाधिकारी</a></li>
                        <li><a href="/events">कार्यक्रम</a></li>
                        <li><a href="/contact/details">संपर्क करें</a></li>
                    </ul>
                </div>

                <!-- ABOUT SOCIETY -->
                <div class="col-lg-3 col-md-6">
                    <h6 class="footer-title">समाज के बारे में</h6>
                    <ul class="footer-links">
                        <li><a href="/smajHistory">समाज का इतिहास</a></li>
                        <li><a href="/smajUddeshLakshya">उद्देश्य एवं लक्ष्य</a></li>
                        <li><a href="/constitution">संविधान</a></li>
                        <li><a href="/donate">दान एवं सहयोग</a></li>
                        <li><a href="/volunteer">स्वयंसेवा</a></li>
                    </ul>
                </div>

                <!-- CONTACT -->
                <div class="col-lg-3 col-md-6">
                    <h6 class="footer-title">संपर्क</h6>
                    <p class="footer-text mb-1">
                        <i class="fas fa-map-marker-alt me-2"></i>
                        कोटा, राजस्थान
                    </p>
                    <p class="footer-text mb-1">
                        <i class="fas fa-phone me-2"></i>
                        +91 XXXXX XXXXX
                    </p>
                    <p class="footer-text">
                        <i class="fas fa-envelope me-2"></i>
                        info@sanadhyasabha.org
                    </p>

                    <!-- SOCIAL -->
                    <div class="footer-social mt-3">
                        <a href="#" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" title="YouTube"><i class="fab fa-youtube"></i></a>
                        <a href="#" title="WhatsApp"><i class="fab fa-whatsapp"></i></a>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- BOTTOM BAR -->
    <div class="footer-bottom text-center py-3">
        <div class="container">
            <small>
                © <span id="currentYear"></span> सनाढ्य ब्राह्मण सभा, कोटा |
                सर्वाधिकार सुरक्षित
            </small>
        </div>
    </div>
</footer>

<script>
    document.getElementById("currentYear").textContent = new Date().getFullYear();
</script>
