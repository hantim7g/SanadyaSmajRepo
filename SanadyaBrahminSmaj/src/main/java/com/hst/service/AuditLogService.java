package com.hst.service;

import com.hst.entity.AuditLog;
import com.hst.repository.AuditLogRepository;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class AuditLogService {
    private static final Logger log = LoggerFactory.getLogger(AuditLogService.class);

    @Autowired
    private AuditLogRepository auditLogRepository;

    public void log(String action,
                    String entityName,
                    Long entityId,
                    Long userId,
                    String username,
                    String details,
                    HttpServletRequest request) {

        log.info("Creating audit log - Action: {}, Entity: {}, EntityId: {}, User: {}, Details: {}", 
                action, entityName, entityId, username, details);
        
        try {
            AuditLog auditLog = new AuditLog();
            auditLog.setAction(action);
            auditLog.setEntityName(entityName);
            auditLog.setEntityId(entityId);
            auditLog.setUserId(userId);
            auditLog.setUsername(username);
            auditLog.setDetails(details);
            auditLog.setIpAddress(request.getRemoteAddr());
            auditLog.setUserAgent(request.getHeader("User-Agent"));

            auditLogRepository.save(auditLog);
            
            log.debug("Audit log created successfully - ID: {}", auditLog.getId());
        } catch (Exception e) {
            log.error("Error creating audit log - Action: {}, Entity: {}, User: {}", 
                    action, entityName, username, e);
        }
    }
    
    // Convenience method for transaction logging
    public void logTransaction(Long userId, String action, String details) {
        log.info("Logging transaction - User: {}, Action: {}, Details: {}", userId, action, details);
        try {
            AuditLog auditLog = new AuditLog();
            auditLog.setAction(action);
            auditLog.setEntityName("TRANSACTION");
            auditLog.setEntityId(userId);
            auditLog.setUserId(userId);
            auditLog.setUsername("SYSTEM");
            auditLog.setDetails(details);
            auditLog.setIpAddress("SYSTEM");
            auditLog.setUserAgent("SYSTEM");

            auditLogRepository.save(auditLog);
            
            log.debug("Transaction log created successfully - ID: {}", auditLog.getId());
        } catch (Exception e) {
            log.error("Error creating transaction log - User: {}, Action: {}", userId, action, e);
        }
    }
    
    // Convenience method for security event logging
    public void logSecurityEvent(String action, String username, String details, HttpServletRequest request) {
        log.warn("Logging security event - Action: {}, User: {}, Details: {}", action, username, details);
        try {
            AuditLog auditLog = new AuditLog();
            auditLog.setAction(action);
            auditLog.setEntityName("SECURITY");
            auditLog.setEntityId(null);
            auditLog.setUserId(null);
            auditLog.setUsername(username);
            auditLog.setDetails(details);
            auditLog.setIpAddress(request.getRemoteAddr());
            auditLog.setUserAgent(request.getHeader("User-Agent"));

            auditLogRepository.save(auditLog);
            
            log.debug("Security event log created successfully - ID: {}", auditLog.getId());
        } catch (Exception e) {
            log.error("Error creating security event log - Action: {}, User: {}", action, username, e);
        }
    }
}