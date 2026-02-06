package com.hst.repository;


import com.hst.entity.BookingSys.RoomBlock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface RoomBlockRepository extends JpaRepository<RoomBlock, Long> {

    // 1. किसी विशिष्ट कमरे के सभी ब्लॉक्स प्राप्त करें
    List<RoomBlock> findByRoomId(Long roomId);

    // 2. वर्तमान और भविष्य के सक्रिय ब्लॉक्स प्राप्त करें

    /**
     * 3. ओवरलैप चेक (Conflict Detection):
     * यह चेक करता है कि क्या नया ब्लॉक (newFrom - newTo) किसी पुराने ब्लॉक से टकरा रहा है।
     * Logic: (ExistingFrom < NewTo) AND (ExistingTo > NewFrom)
     */


    // 4. किसी विशिष्ट तिथि सीमा में ब्लॉक किए गए कमरों की सूची (Search के लिए उपयोगी)
    @Query("""
        SELECT rb.room.id FROM RoomBlock rb 
        WHERE rb.fromDate < :toDate 
        AND rb.toDate > :fromDate
    """)
    List<Long> findBlockedRoomIds(
        @Param("fromDate") LocalDate fromDate, 
        @Param("toDate") LocalDate toDate
    );
    @Query("SELECT rb FROM RoomBlock rb WHERE rb.toDate >= :today ORDER BY rb.fromDate ASC")
    List<RoomBlock> findAllActiveBlocks(@Param("today") LocalDate today);

    @Query("SELECT COUNT(rb) > 0 FROM RoomBlock rb WHERE rb.room.id = :roomId AND rb.fromDate < :toDate AND rb.toDate > :fromDate")
    boolean hasConflict(@Param("roomId") Long roomId, @Param("fromDate") LocalDate fromDate, @Param("toDate") LocalDate toDate);
}