package com.hst.util;

import com.hst.entity.User;
import com.hst.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.Year;
import java.util.List;

@Component
public class FeeScheduler {

    @Autowired
    private UserRepository userRepository;

    // Every year on Jan 1st at 00:00 AM
    @Scheduled(cron = "0 0 0 1 1 *")
    public void markAnnualFeeDueForNewYear() {
        List<User> users = userRepository.findAll();
        int currentYear = Year.now().getValue();

        for (User user : users) {
            if (user.getLastAnnualFeePaid() == null || user.getLastAnnualFeePaid().getYear() < currentYear) {
                user.setAnnualFeeStatus("प्रतीक्षारत");
                userRepository.save(user);
            }
        }

        System.out.println("✅ Annual fee status updated for users not paid in year: " + currentYear);
    }
}
