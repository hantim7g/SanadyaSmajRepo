package com.hst.repository;


import com.hst.entity.User;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
	Optional<User> findByMobile(String mobile);

    boolean existsByMobile(String mobile);
    List<User> findByApprovedFalse();
    @Query("SELECT COUNT(u) FROM User u")
    long countUsers();
    
    List<User> findAllByOrderByFullNameAsc();

    @Query("SELECT u FROM User u WHERE (:name IS NULL OR LOWER(u.fullName) LIKE LOWER(CONCAT('%', :name, '%'))) AND (:city IS NULL OR LOWER(u.homeDistrict) LIKE LOWER(CONCAT('%', :city, '%'))) AND (:approved IS NULL OR u.approved = :approved)")
     List<User> findFiltered(@Param("name") String name,
                             @Param("city") String city,
                             @Param("approved") Boolean approved);
}
