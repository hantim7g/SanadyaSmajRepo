package com.hst.service;

import com.hst.entity.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

/**
 * Service for sending email and SMS notifications.
 * SMS is currently logged (placeholder) — integrate with a provider like MSG91, Twilio, etc.
 */
@Service
public class NotificationService {

    private static final Logger log = LoggerFactory.getLogger(NotificationService.class);

    @Autowired(required = false)
    private JavaMailSender mailSender;

    @Value("${app.notification.from-email:}")
    private String fromEmail;

    /**
     * Send approval notification to a user via email and/or SMS.
     */
    @Async
    public void notifyApproval(User user, String approvedBy) {
        String subject = "सनाढ्य ब्राह्मण सभा - पंजीकरण स्वीकृत";
        String message = String.format(
                "प्रिय %s,\n\n" +
                "आपका सनाढ्य ब्राह्मण सभा में पंजीकरण स्वीकृत कर दिया गया है।\n\n" +
                "पंजीकरण संख्या: %s\n" +
                "अनुमोदन दिनांक: %s\n" +
                "अनुमोदनकर्ता: %s\n\n" +
                "अब आप लॉगिन कर सकते हैं और सभी सुविधाओं का लाभ उठा सकते हैं।\n\n" +
                "धन्यवाद,\nसनाढ्य ब्राह्मण सभा",
                user.getFullName(), user.getRegistrationNo(), java.time.LocalDate.now(), approvedBy
        );

        sendEmail(user.getEmail(), subject, message);
        sendSms(user.getMobile(), "आपका पंजीकरण स्वीकृत कर दिया गया है। पंजीकरण संख्या: " + user.getRegistrationNo());
    }

    /**
     * Send rejection notification to a user via email and/or SMS.
     */
    @Async
    public void notifyRejection(User user, String rejectedBy) {
        String subject = "सनाढ्य ब्राह्मण सभा - पंजीकरण अस्वीकृत";
        String message = String.format(
                "प्रिय %s,\n\n" +
                "हमें खेद है कि आपका सनाढ्य ब्राह्मण सभा में पंजीकरण अनुमोदित नहीं किया जा सका।\n\n" +
                "अस्वीकृति दिनांक: %s\n" +
                "अस्वीकृति कर्ता: %s\n\n" +
                "कृपया अधिक जानकारी के लिए प्रशासक से संपर्क करें।\n\n" +
                "धन्यवाद,\nसनाढ्य ब्राह्मण सभा",
                user.getFullName(), java.time.LocalDate.now(), rejectedBy
        );

        sendEmail(user.getEmail(), subject, message);
        sendSms(user.getMobile(), "आपका पंजीकरण अनुमोदित नहीं किया जा सका। कृपया प्रशासक से संपर्क करें।");
    }

    /**
     * Send an email.
     */
    private void sendEmail(String to, String subject, String text) {
        if (mailSender == null) {
            log.warn("JavaMailSender not configured — skipping email to {}", to);
            return;
        }
        if (to == null || to.isBlank()) {
            log.warn("No email address for user — skipping email");
            return;
        }
        try {
            SimpleMailMessage msg = new SimpleMailMessage();
            msg.setFrom(fromEmail);
            msg.setTo(to);
            msg.setSubject(subject);
            msg.setText(text);
            mailSender.send(msg);
            log.info("✅ Email sent to {}", to);
        } catch (Exception e) {
            log.error("❌ Failed to send email to {}: {}", to, e.getMessage());
        }
    }

    /**
     * Send an SMS (placeholder — logs the message).
     * Integrate with MSG91, Twilio, or any SMS gateway here.
     */
    private void sendSms(String mobile, String text) {
        if (mobile == null || mobile.isBlank()) {
            log.warn("No mobile number — skipping SMS");
            return;
        }
        // TODO: Integrate with actual SMS provider (e.g., Twilio, MSG91, TextLocal)
        log.info("📱 SMS to {}: {}", mobile, text);
    }
}
