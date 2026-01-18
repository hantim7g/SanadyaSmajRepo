package com.hst.repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hst.entity.VivhaUser;

public interface VivhaUserRepository extends JpaRepository<VivhaUser, Long> {

	 List<VivhaUser>	findByMobile(String mobile);

	 @Query("""
			 SELECT v FROM VivhaUser v
			 WHERE v.approved=true
			 AND (:manglik IS NULL OR v.manglik = :manglik)
			 AND (:income IS NULL OR v.income LIKE %:income%)
			 """)
			 List<VivhaUser> search(@Param("manglik") String manglik,
			                        @Param("income") String income);
	 @Query("""
			 SELECT v FROM VivhaUser v
			 WHERE v.approved=true
			 AND (:city IS NULL OR v.city LIKE %:city%)
			 """)
			 List<VivhaUser> searchByCity(@Param("city") String city);
	 
	 @Query("""
			    SELECT v FROM VivhaUser v
			    WHERE v.approved = true
			    AND (:gender IS NULL OR v.gender = :gender)
			    AND (:manglik IS NULL OR v.manglik = :manglik)
			    AND (:city IS NULL OR v.city LIKE %:city%)
			    AND (:district IS NULL OR v.district LIKE %:district%)
			    AND (:gotra IS NULL OR v.gotra LIKE %:gotra%)
			    AND (:qualification IS NULL OR v.qualification LIKE %:qualification%)
			    AND (:occupation IS NULL OR v.occupation LIKE %:occupation%)
			    AND (:income IS NULL OR v.income LIKE %:income%)
			    """)
			    Page<VivhaUser> searchWithPagination(
			        @Param("gender") String gender,
			        @Param("manglik") String manglik,
			        @Param("city") String city,
			        @Param("district") String district,
			        @Param("gotra") String gotra,
			        @Param("qualification") String qualification,
			        @Param("occupation") String occupation,
			        @Param("income") String income,
			        Pageable pageable
			    );

	 @Query("""
			 SELECT v FROM VivhaUser v
			 WHERE v.approved = true
			 AND (:gender IS NULL OR v.gender = :gender)
			 AND (:manglik IS NULL OR v.manglik = :manglik)
			 AND (:city IS NULL OR v.city LIKE %:city%)
			 AND (:district IS NULL OR v.district LIKE %:district%)
			 AND (:gotra IS NULL OR v.gotra LIKE %:gotra%)
			 AND (:qualification IS NULL OR v.qualification LIKE %:qualification%)
			 AND (:occupation IS NULL OR v.occupation LIKE %:occupation%)
			 AND (:income IS NULL OR v.income LIKE %:income%)
			 AND (:minAge IS NULL OR FUNCTION('YEAR', CURRENT_DATE) - FUNCTION('YEAR', v.dob) >= :minAge)
			 AND (:maxAge IS NULL OR FUNCTION('YEAR', CURRENT_DATE) - FUNCTION('YEAR', v.dob) <= :maxAge)
			 """)
			 Page<VivhaUser> searchWithPaginationAndAge(
			         String gender,
			         String manglik,
			         String city,
			         String district,
			         String gotra,
			         String qualification,
			         String occupation,
			         String income,
			         Integer minAge,
			         Integer maxAge,
			         Pageable pageable
			 );


}
