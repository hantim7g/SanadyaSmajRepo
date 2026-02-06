package com.hst.service;

import java.time.LocalDate;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.hst.entity.BookingSys.RoomBlock;
import com.hst.repository.BookingRepository;
import com.hst.repository.RoomBlockRepository;
import jakarta.transaction.Transactional;

@Service
public class RoomBlockService {

    @Autowired private RoomBlockRepository blockRepo;
    @Autowired private BookingRepository bookingRepo;

    /**
     * वर्तमान और भविष्य के सभी सक्रिय ब्लॉक्स प्राप्त करें
     */
    public List<RoomBlock> getAllActiveBlocks() {
        return blockRepo.findAllActiveBlocks(LocalDate.now());
    }

    /**
     * रूम ब्लॉक को हटाएँ (Unblock)
     */
    @Transactional
    public void deleteBlock(Long id) {
        blockRepo.deleteById(id);
    }

    @Transactional
    public void createBlock(RoomBlock block) throws Exception {
        // 1. तारीखों की वैलिडिटी चेक करें
        if (block.getToDate().isBefore(block.getFromDate())) {
            throw new Exception("चेक-आउट तिथि चेक-इन से पहले नहीं हो सकती।");
        }

        // 2. क्या कोई अन्य Block ओवरलैप हो रहा है?
        if (blockRepo.hasConflict(block.getRoom().getId(), block.getFromDate(), block.getToDate())) {
            throw new Exception("इस अवधि में यह कमरा/फ्लोर पहले से ही ब्लॉक है।");
        }

        // 3. क्या इस अवधि में पहले से कोई CONFIRMED बुकिंग है?
        // नोट: यह चेक बिल्डिंग/फ्लोर/रूम तीनों स्तरों पर काम करेगा (Hierarchy Check)
        boolean alreadyBooked = bookingRepo.hasExistingBooking(
            block.getRoom().getId(), 
            block.getRoom().getFloor(), 
            block.getFromDate(), 
            block.getToDate()
        );

        if (alreadyBooked) {
            throw new Exception("क्षमा करें! इस अवधि में पहले से बुकिंग मौजूद है। कृपया पहले बुकिंग रद्द करें या तारीख बदलें।");
        }

        blockRepo.save(block);
    }
}