package com.hst.repository;

import com.hst.entity.AuditLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Repository
public interface AuditLogRepository extends JpaRepository<AuditLog, Long> {
}