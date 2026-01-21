package com.hst.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hst.entity.VivhaUser;

import jakarta.transaction.Transactional;

public interface VivhaUserRepository extends JpaRepository<VivhaUser, Long> {

	List<VivhaUser> findByMobile(String mobile);
	List<VivhaUser> findByLoginMobile(String loginMobile);

	@Query("""
			SELECT v FROM VivhaUser v
			WHERE v.approved=true
			AND (:manglik IS NULL OR v.manglik = :manglik)
			AND (:income IS NULL OR v.income LIKE %:income%)
			""")
	List<VivhaUser> search(@Param("manglik") String manglik, @Param("income") String income);

	@Query("""
			SELECT v FROM VivhaUser v
			WHERE v.approved=true
			AND (:city IS NULL OR v.city LIKE %:city%)
			""")
	List<VivhaUser> searchByCity(@Param("city") String city);

	@Query("""
			SELECT v FROM VivhaUser v
			WHERE v.approved = true
			AND (
			    :excludeGotras IS NULL OR NOT (
			        (v.gotra IS NOT NULL AND v.gotra IN :excludeGotras)
			        OR (v.customGotra IS NOT NULL AND v.customGotra <> '' AND v.customGotra IN :excludeGotras)
			        OR (v.motherGotra IS NOT NULL AND v.motherGotra IN :excludeGotras)
			        OR (v.motherCustomGotra IS NOT NULL AND v.motherCustomGotra <> '' AND v.motherCustomGotra IN :excludeGotras)
			        OR (v.dadiGotra IS NOT NULL AND v.dadiGotra IN :excludeGotras)
			        OR (v.dadiCustomGotra IS NOT NULL AND v.dadiCustomGotra <> '' AND v.dadiCustomGotra IN :excludeGotras)
			        OR (v.naniGotra IS NOT NULL AND v.naniGotra IN :excludeGotras)
			        OR (v.naniCustomGotra IS NOT NULL AND v.naniCustomGotra <> '' AND v.naniCustomGotra IN :excludeGotras)
			    )
			)
			AND (:gender IS NULL OR v.gender = :gender)
			AND (:manglik IS NULL OR v.manglik = :manglik)
			AND (:city IS NULL OR v.city LIKE %:city%)
			AND (:district IS NULL OR v.district LIKE %:district%)
			AND (:qualification IS NULL OR v.qualification LIKE %:qualification%)
			AND (:occupation IS NULL OR v.occupation LIKE %:occupation%)
			AND (:income IS NULL OR v.income LIKE %:income%)
			ORDER BY v.id DESC
			""")
			Page<VivhaUser> searchWithPagination(
			    @Param("excludeGotras") List<String> excludeGotras,
			    @Param("gender") String gender,
			    @Param("manglik") String manglik,
			    @Param("city") String city,
			    @Param("district") String district,
			    @Param("qualification") String qualification,
			    @Param("occupation") String occupation,
			    @Param("income") String income,
			    Pageable pageable
			);


	@Query("""
			SELECT v FROM VivhaUser v
			WHERE  (
			    :excludeGotras IS NULL OR NOT (
			        (v.gotra IS NOT NULL AND v.gotra IN :excludeGotras)
			        OR (v.customGotra IS NOT NULL AND v.customGotra <> '' AND v.customGotra IN :excludeGotras)
			        OR (v.motherGotra IS NOT NULL AND v.motherGotra IN :excludeGotras)
			        OR (v.motherCustomGotra IS NOT NULL AND v.motherCustomGotra <> '' AND v.motherCustomGotra IN :excludeGotras)
			        OR (v.dadiGotra IS NOT NULL AND v.dadiGotra IN :excludeGotras)
			        OR (v.dadiCustomGotra IS NOT NULL AND v.dadiCustomGotra <> '' AND v.dadiCustomGotra IN :excludeGotras)
			        OR (v.naniGotra IS NOT NULL AND v.naniGotra IN :excludeGotras)
			        OR (v.naniCustomGotra IS NOT NULL AND v.naniCustomGotra <> '' AND v.naniCustomGotra IN :excludeGotras)
			    )
			)
			AND (:gender IS NULL OR v.gender = :gender)
			AND (:manglik IS NULL OR v.manglik = :manglik)
			AND (:city IS NULL OR v.city LIKE %:city%)
			AND (:district IS NULL OR v.district LIKE %:district%)
			AND (:qualification IS NULL OR v.qualification LIKE %:qualification%)
			AND (:occupation IS NULL OR v.occupation LIKE %:occupation%)
			AND (:income IS NULL OR v.income LIKE %:income%)
			AND (:approved IS NULL OR v.approved = :approved)
			AND (:active IS NULL OR v.active = :active)
			ORDER BY v.id DESC
			""")
			Page<VivhaUser> searchWithPaginationAdmin(
			    @Param("excludeGotras") List<String> excludeGotras,
			    @Param("gender") String gender,
			    @Param("manglik") String manglik,
			    @Param("city") String city,
			    @Param("district") String district,
			    @Param("qualification") String qualification,
			    @Param("occupation") String occupation,
			    @Param("income") String income,
			    @Param("approved")  Boolean approved,
			    @Param("active") Boolean active,
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
	Page<VivhaUser> searchWithPaginationAndAge(String gender, String manglik, String city, String district,
			String gotra, String qualification, String occupation, String income, Integer minAge, Integer maxAge,
			Pageable pageable);

	
	
	@Transactional
	@Modifying
	@Query("UPDATE VivhaUser u SET u.approved = :approved WHERE u.id = :id")
	void updateApproved(@Param("id") Long id, @Param("approved") boolean approved);

	@Transactional
	@Modifying
	@Query("UPDATE VivhaUser u SET u.active = :active WHERE u.id = :id")
	void updateActive(@Param("id") Long id, @Param("active") boolean active);

}
