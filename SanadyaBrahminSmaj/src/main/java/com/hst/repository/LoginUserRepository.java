package com.hst.repository;

import com.hst.entity.LoginUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface LoginUserRepository extends JpaRepository<LoginUser, Long> {

    Optional<LoginUser> findByMobile(String mobile);

    Optional<LoginUser> findFirstByEmailOrderByIdAsc(String email);

    boolean existsByMobile(String mobile);
}