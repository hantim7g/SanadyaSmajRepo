package com.hst.repository;


import org.springframework.data.jpa.repository.JpaRepository;

import com.hst.entity.VivhaUser;

public interface VivhaUserRepository extends JpaRepository<VivhaUser, Long> {
}
