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
	
	 @Query("SELECT u.id FROM User u WHERE u.mobile = :mobile")
	Long findIdByMobile(String mobile) ;
	
    boolean existsByMobile(String mobile);
    List<User> findByApprovedFalse();
    @Query("SELECT COUNT(u) FROM User u")
    long countUsers();
    
    Page<User> findAllByOrderByFullNameAsc(Pageable pageable);


    @Query("SELECT u FROM User u WHERE (:name IS NULL OR LOWER(u.fullName) LIKE LOWER(CONCAT('%', :name, '%'))) AND (:city IS NULL OR LOWER(u.homeDistrict) LIKE LOWER(CONCAT('%', :city, '%'))) AND (:approved IS NULL OR u.approved = :approved)")
     List<User> findFiltered(@Param("name") String name,
                             @Param("city") String city,
                             @Param("approved") String approved);
    
    
//    Page<User> findByFullNameContainingIgnoreCaseAndCityContainingIgnoreCaseAndApprovedAndFeeDue(
//    	    String name, String city, Boolean approved, Boolean due, Pageable pageable);
//    
    
    
    // Optional field filters (AND logic)
    @Query("SELECT u FROM User u " +
    	       "WHERE (:name IS NULL OR LOWER(u.fullName) LIKE LOWER(CONCAT('%', :name, '%'))) " +
    	       "AND (:mobile IS NULL OR LOWER(u.mobile) LIKE LOWER(CONCAT('%', :mobile, '%'))) " +
    	       "AND (:approved IS NULL OR u.approved = :approved) ")
    	Page<User> filterUsers(@Param("name") String name,
    	                       @Param("mobile") String mobile,
    	                       @Param("approved") String approved,
    	                       Pageable pageable);
    
    
    
    List<User>  findAllBySmajRole(String smajRole);
    List<User> findAllByOrderBySmajRolePriorityAsc();

}
