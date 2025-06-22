package com.hst.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hst.entity.VivhaUser;

public interface VivhaUserRepository extends JpaRepository<VivhaUser, Long> {

	 List<VivhaUser>	findByMobile(String mobile);
}
