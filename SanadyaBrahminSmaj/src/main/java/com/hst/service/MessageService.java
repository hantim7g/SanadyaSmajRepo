package com.hst.service;

import com.hst.dto.MessageDto;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class MessageService {

    public List<MessageDto> getAllMessage() {
        MessageDto dto = new MessageDto();

        dto.setAuthorName("ओम कृष्ण बिरला");
        dto.setAuthorTitle("लोकसभा अध्यक्ष एवं सांसद");
        dto.setAuthorSubtitle("कोटा-बूंदी लोकसभा क्षेत्र");
        dto.setPhotoUrl("/images/ombirla.jpg"); // keep photo in static/images/
        dto.setCityOrArea("कोटा");

        dto.setTitle("शुभकामना संदेश");
        dto.setLead("अत्यंत हर्ष की बात है कि सनाड्य ब्राह्मण सभा समिति, महावीर नगर, कोटा के तत्वावधान में...");
        dto.setContent("13 अक्टूबर 2019 को कोटा शहर में युवक-युवती परिचय सम्मेलन का आयोजन किया जा रहा है। "
                + "वर्तमान समय में इस तरह के सामाजिक आयोजन का होना अत्यंत आवश्यक है। "
                + "समाज की प्रगति के लिए ऐसे आयोजन प्रेरणास्रोत बनते हैं। "
                + "मैं इस अवसर पर सनाड्य ब्राह्मण सभा समिति, महावीर नगर, कोटा को सफल आयोजन के लिए बधाई देता हूँ।");

        dto.setQuote("मैं आशा करता हूँ कि इस अवसर पर प्रकाशित की जा रही स्मारिका समाज के लोगों के लिए उपयोगी एवं साधक सिद्ध होगी।");

        dto.setSignatureName("ओम बिरला");
        dto.setSignatureDesignation("(लोकसभा अध्यक्ष)");

        dto.setDateText("13 अक्टूबर 2019");
        dto.setPageNumber("009");
        List<MessageDto> messages =new  ArrayList<MessageDto>();
        messages.add(dto);
        messages.add(dto);
        messages.add(dto);
        return messages;
    }
}
