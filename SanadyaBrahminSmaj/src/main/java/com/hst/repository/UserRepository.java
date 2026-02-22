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
    
    
    // Optional field filters (AND logic)
    @Query("SELECT u FROM User u " +
    	       "WHERE (:name IS NULL OR LOWER(u.fullName) LIKE LOWER(CONCAT('%', :name, '%'))) " +
    	       "AND (:mobile IS NULL OR LOWER(u.mobile) LIKE LOWER(CONCAT('%', :mobile, '%'))) " +
    	       "AND (:approved IS NULL OR u.approved = :approved) ")
    	List<User> filterUsersAll(@Param("name") String name,
    	                       @Param("mobile") String mobile,
    	                       @Param("approved") String approved
    	                       );
    
    
    List<User>  findAllBySmajRole(String smajRole);
    List<User> findAllByOrderBySmajRolePriorityAsc();

    
    @Query(value = "SELECT DISTINCT u FROM User u " +
    	       "WHERE (:name IS NULL OR LOWER(u.fullName) LIKE LOWER(CONCAT('%', :name, '%'))) " +
    	       "AND (:mobile IS NULL OR u.mobile LIKE CONCAT('%', :mobile, '%')) " +
    	       "AND (:approved IS NULL OR u.approved = :approved) " +
    	       "AND (" +
    	       "  :feeStatus IS NULL OR :feeStatus = '' OR " +
    	       "  (:feeStatus = 'सत्यापित/प्रक्रिया में' AND EXISTS (" +
    	       "     SELECT 1 FROM Payment p2 WHERE p2.user.id = u.id " +
    	       "     AND p2.description LIKE '%वार्षिक%' " +
    	       "     AND (p2.validated = 'सत्यापित' OR p2.validated = 'प्रक्रिया में') " +
    	       "     AND (:startYear IS NULL OR (YEAR(p2.feeFrom) <= :startYear AND YEAR(p2.feeTo) >= :startYear))" +
    	       "  )) OR " +
    	       "  (:feeStatus = 'प्रतीक्षारत' AND NOT EXISTS (" +
    	       "     SELECT 1 FROM Payment p2 WHERE p2.user.id = u.id " +
    	       "     AND p2.description LIKE '%वार्षिक%' " +
    	       "     AND (p2.validated = 'सत्यापित' OR p2.validated = 'प्रक्रिया में') " +
    	       "     AND (:startYear IS NULL OR (YEAR(p2.feeFrom) <= :startYear AND YEAR(p2.feeTo) >= :startYear))" +
    	       "  ))" +
    	       ")",
    	       countQuery = "SELECT COUNT(DISTINCT u) FROM User u " +
    	       "WHERE (:name IS NULL OR LOWER(u.fullName) LIKE LOWER(CONCAT('%', :name, '%'))) " +
    	       "AND (:mobile IS NULL OR u.mobile LIKE CONCAT('%', :mobile, '%')) " +
    	       "AND (:approved IS NULL OR u.approved = :approved) " +
    	       "AND (" +
    	       "  :feeStatus IS NULL OR :feeStatus = '' OR " +
    	       "  (:feeStatus = 'सत्यापित/प्रक्रिया में' AND EXISTS (" +
    	       "     SELECT 1 FROM Payment p2 WHERE p2.user.id = u.id " +
    	       "     AND p2.description LIKE '%वार्षिक%' " +
    	       "     AND (p2.validated = 'सत्यापित' OR p2.validated = 'प्रक्रिया में') " +
    	       "     AND (:startYear IS NULL OR (YEAR(p2.feeFrom) <= :startYear AND YEAR(p2.feeTo) >= :startYear))" +
    	       "  )) OR " +
    	       "  (:feeStatus = 'प्रतीक्षारत' AND NOT EXISTS (" +
    	       "     SELECT 1 FROM Payment p2 WHERE p2.user.id = u.id " +
    	       "     AND p2.description LIKE '%वार्षिक%' " +
    	       "     AND (p2.validated = 'सत्यापित' OR p2.validated = 'प्रक्रिया में') " +
    	       "     AND (:startYear IS NULL OR (YEAR(p2.feeFrom) <= :startYear AND YEAR(p2.feeTo) >= :startYear))" +
    	       "  ))" +
    	       ")")
    	Page<User> filterUsersWithPayments(
    	        @Param("name") String name,
    	        @Param("mobile") String mobile,
    	        @Param("approved") String approved,
    	        @Param("feeStatus") String feeStatus,
    	        @Param("startYear") Integer startYear,
    	        Pageable pageable);
        Page<User> findAllByOrderByFullNameAsc(Pageable pageable);
        }

