package com.hst.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hst.entity.MemberRule;

public interface MemberRuleRepository extends JpaRepository<MemberRule, Long> {

    List<MemberRule> findByActiveTrue();
}
