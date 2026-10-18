package com.hst.service;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

//@Component
public class LoginUserMigrationRunner {
//	implements ApplicationRunner {


//    private final JdbcTemplate jdbcTemplate;
//    private final DataSource dataSource;
//
//    public LoginUserMigrationRunner(JdbcTemplate jdbcTemplate, DataSource dataSource) {
//        this.jdbcTemplate = jdbcTemplate;
//        this.dataSource = dataSource;
//    }
//
//    @Override
//    public void run(ApplicationArguments args) {
//        if (!hasLegacyMobileColumn()) {
//            return;
//        }
//
//        jdbcTemplate.update("""
//                INSERT INTO login_users (mobile, password, role, email, full_name, auth_provider, account_type, created_at)
//                SELECT u.mobile, u.password, COALESCE(u.role, 'USER'), u.email, u.full_name, u.auth_provider, 'MEMBER', NOW()
//                FROM users u
//                LEFT JOIN login_users l ON l.mobile = u.mobile
//                WHERE l.id IS NULL
//                """);
//        jdbcTemplate.update("""
//                UPDATE login_users l
//                JOIN users u ON u.mobile = l.mobile
//                SET l.email = COALESCE(l.email, u.email),
//                    l.full_name = COALESCE(l.full_name, u.full_name),
//                    l.auth_provider = COALESCE(l.auth_provider, u.auth_provider)
//                """);
//        jdbcTemplate.update("""
//                UPDATE users u
//                JOIN login_users l ON l.mobile = u.mobile
//                SET u.login_user_id = l.id
//                WHERE u.login_user_id IS NULL
//                """);
//    }
//
//    private boolean hasLegacyMobileColumn() {
//        try (Connection connection = dataSource.getConnection()) {
//            return connection.getMetaData()
//                    .getColumns(connection.getCatalog(), null, "users", "mobile")
//                    .next();
//        } catch (SQLException e) {
//            throw new IllegalStateException("Unable to inspect the legacy users schema", e);
//        }
//    }
}