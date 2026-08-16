package com.hst.config;

import com.hst.entity.CityVillageMaster;
import com.hst.repository.CityVillageMasterRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

/**
 * Seeds the city_village_master table with Rajasthan master data on startup.
 * Runs only when the table is empty, so it is safe to re-run.
 */
@Component
public class CityVillageDataSeeder implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(CityVillageDataSeeder.class);
    private static final String STATE = "राजस्थान";

    private final CityVillageMasterRepository repository;

    public CityVillageDataSeeder(CityVillageMasterRepository repository) {
        this.repository = repository;
    }

    @Override
    public void run(String... args) {
        if (repository.count() > 0) {
            log.info("city_village_master already has {} records — skipping Rajasthan seed.", repository.count());
            return;
        }

        log.info("Seeding Rajasthan master data into city_village_master...");

        // Districts (is_city = 0) -> "जिला" dropdown
        List<String[]> districts = Arrays.asList(
                new String[]{"अजमेर", "अजमेर"},
                new String[]{"अलवर", "अलवर"},
                new String[]{"बांसवाड़ा", "बांसवाड़ा"},
                new String[]{"बारां", "बारां"},
                new String[]{"बाड़मेर", "बाड़मेर"},
                new String[]{"भरतपुर", "भरतपुर"},
                new String[]{"भीलवाड़ा", "भीलवाड़ा"},
                new String[]{"बीकानेर", "बीकानेर"},
                new String[]{"बूंदी", "बूंदी"},
                new String[]{"चित्तौड़गढ़", "चित्तौड़गढ़"},
                new String[]{"चूरू", "चूरू"},
                new String[]{"दौसा", "दौसा"},
                new String[]{"धौलपुर", "धौलपुर"},
                new String[]{"डूंगरपुर", "डूंगरपुर"},
                new String[]{"हनुमानगढ़", "हनुमानगढ़"},
                new String[]{"जयपुर", "जयपुर"},
                new String[]{"जैसलमेर", "जैसलमेर"},
                new String[]{"जालौर", "जालौर"},
                new String[]{"झालावाड़", "झालावाड़"},
                new String[]{"झुंझुनूं", "झुंझुनूं"},
                new String[]{"जोधपुर", "जोधपुर"},
                new String[]{"करौली", "करौली"},
                new String[]{"कोटा", "कोटा"},
                new String[]{"नागौर", "नागौर"},
                new String[]{"पाली", "पाली"},
                new String[]{"प्रतापगढ़", "प्रतापगढ़"},
                new String[]{"राजसमंद", "राजसमंद"},
                new String[]{"सवाई माधोपुर", "सवाई माधोपुर"},
                new String[]{"सीकर", "सीकर"},
                new String[]{"सिरोही", "सिरोही"},
                new String[]{"श्रीगंगानगर", "श्रीगंगानगर"},
                new String[]{"टोंक", "टोंक"},
                new String[]{"उदयपुर", "उदयपुर"},
                new String[]{"बालोतरा", "बालोतरा"},
                new String[]{"ब्यावर", "ब्यावर"},
                new String[]{"डीग", "डीग"},
                new String[]{"दीदवाना-कुचामन", "दीदवाना-कुचामन"},
                new String[]{"गंगापुर सिटी", "गंगापुर सिटी"},
                new String[]{"खैरथल-तिजारा", "खैरथल-तिजारा"},
                new String[]{"कोटपूतली-बहरोड़", "कोटपूतली-बहरोड़"},
                new String[]{"नीम का थाना", "नीम का थाना"},
                new String[]{"फलोदी", "फलोदी"},
                new String[]{"सालूम्बर", "सालूम्बर"},
                new String[]{"सांचौर", "सांचौर"},
                new String[]{"शाहपुरा", "शाहपुरा"}
        );

        // Major cities (is_city = 1) -> "शहर" dropdown
        List<String[]> cities = Arrays.asList(
                new String[]{"जयपुर", "जयपुर"},
                new String[]{"जोधपुर", "जोधपुर"},
                new String[]{"उदयपुर", "उदयपुर"},
                new String[]{"कोटा", "कोटा"},
                new String[]{"बीकानेर", "बीकानेर"},
                new String[]{"अजमेर", "अजमेर"},
                new String[]{"भरतपुर", "भरतपुर"},
                new String[]{"अलवर", "अलवर"},
                new String[]{"सीकर", "सीकर"},
                new String[]{"भीलवाड़ा", "भीलवाड़ा"},
                new String[]{"श्रीगंगानगर", "श्रीगंगानगर"},
                new String[]{"पाली", "पाली"},
                new String[]{"टोंक", "टोंक"},
                new String[]{"किशनगढ़", "अजमेर"},
                new String[]{"ब्यावर", "ब्यावर"},
                new String[]{"सवाई माधोपुर", "सवाई माधोपुर"},
                new String[]{"चूरू", "चूरू"},
                new String[]{"हनुमानगढ़", "हनुमानगढ़"},
                new String[]{"नागौर", "नागौर"},
                new String[]{"बाड़मेर", "बाड़मेर"},
                new String[]{"जैसलमेर", "जैसलमेर"},
                new String[]{"चित्तौड़गढ़", "चित्तौड़गढ़"},
                new String[]{"दौसा", "दौसा"},
                new String[]{"धौलपुर", "धौलपुर"},
                new String[]{"झुंझुनूं", "झुंझुनूं"},
                new String[]{"करौली", "करौली"},
                new String[]{"बूंदी", "बूंदी"},
                new String[]{"झालावाड़", "झालावाड़"},
                new String[]{"बांसवाड़ा", "बांसवाड़ा"},
                new String[]{"डूंगरपुर", "डूंगरपुर"},
                new String[]{"सिरोही", "सिरोही"},
                new String[]{"जालौर", "जालौर"},
                new String[]{"राजसमंद", "राजसमंद"},
                new String[]{"प्रतापगढ़", "प्रतापगढ़"},
                new String[]{"बारां", "बारां"},
                new String[]{"गंगापुर सिटी", "गंगापुर सिटी"},
                new String[]{"नीम का थाना", "नीम का थाना"},
                new String[]{"खैरथल", "खैरथल-तिजारा"},
                new String[]{"कोटपूतली", "कोटपूतली-बहरोड़"},
                new String[]{"शाहपुरा", "शाहपुरा"},
                new String[]{"डीग", "डीग"},
                new String[]{"दीदवाना", "दीदवाना-कुचामन"},
                new String[]{"फलोदी", "फलोदी"},
                new String[]{"बालोतरा", "बालोतरा"},
                new String[]{"सांचौर", "सांचौर"},
                new String[]{"सालूम्बर", "सालूम्बर"}
        );

        int count = 0;
        for (String[] d : districts) {
            repository.save(build(d[0], d[1], false));
            count++;
        }
        for (String[] c : cities) {
            repository.save(build(c[0], c[1], true));
            count++;
        }

        log.info("Seeded {} Rajasthan records into city_village_master.", count);
    }

    private CityVillageMaster build(String name, String district, boolean isCity) {
        CityVillageMaster cvm = new CityVillageMaster(name, district, isCity);
        cvm.setState(STATE);
        cvm.setActive(true);
        return cvm;
    }
}