package com.hst.repository;


import com.hst.entity.User;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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
    
    Page<User> findAllByOrderByFullNameAsc(Pageable pageable);


    @Query("SELECT u FROM User u WHERE (:name IS NULL OR LOWER(u.fullName) LIKE LOWER(CONCAT('%', :name, '%'))) AND (:city IS NULL OR LOWER(u.homeDistrict) LIKE LOWER(CONCAT('%', :city, '%'))) AND (:approved IS NULL OR u.approved = :approved)")
     List<User> findFiltered(@Param("name") String name,
                             @Param("city") String city,
                             @Param("approved") Boolean approved);
    
    
//    Page<User> findByFullNameContainingIgnoreCaseAndCityContainingIgnoreCaseAndApprovedAndFeeDue(
//    	    String name, String city, Boolean approved, Boolean due, Pageable pageable);
//    
    
    
    // Optional field filters (AND logic)
    @Query("SELECT u FROM User u " +
    	       "WHERE (:name IS NULL OR LOWER(u.fullName) LIKE LOWER(CONCAT('%', :name, '%'))) " +
    	       "AND (:city IS NULL OR LOWER(u.homeDistrict) LIKE LOWER(CONCAT('%', :city, '%'))) " +
    	       "AND (:approved IS NULL OR u.approved = :approved) " +
    	       "AND (:due IS NULL OR (:due = true AND u.annualFeeDue > 0) OR (:due = false AND u.annualFeeDue = 0))")
    	Page<User> filterUsers(@Param("name") String name,
    	                       @Param("city") String city,
    	                       @Param("approved") Boolean approved,
    	                       @Param("due") Boolean due,
    	                       Pageable pageable);


}
