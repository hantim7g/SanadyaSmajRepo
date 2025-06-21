package com.hst.repository;


import com.hst.entity.User;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
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
}
