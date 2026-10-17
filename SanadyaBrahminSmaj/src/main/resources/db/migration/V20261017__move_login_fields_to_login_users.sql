-- Deploy the new application version and let LoginUserMigrationRunner finish
-- the backfill before running this script. Verify no member profiles are unlinked.
SELECT COUNT(*) AS unlinked_member_profiles
FROM users
WHERE login_user_id IS NULL;

UPDATE login_users l
LEFT JOIN users u ON u.login_user_id = l.id
SET l.account_type = CASE WHEN u.id IS NULL THEN 'ROOM_MATRIMONY' ELSE 'MEMBER' END
WHERE l.account_type IS NULL;

ALTER TABLE users
    MODIFY COLUMN login_user_id BIGINT NOT NULL,
    DROP COLUMN mobile,
    DROP COLUMN password,
    DROP COLUMN email,
    DROP COLUMN full_name,
    DROP COLUMN role,
    DROP COLUMN auth_provider;

ALTER TABLE payment_history
    MODIFY COLUMN user_id BIGINT NULL;

ALTER TABLE login_users
    MODIFY COLUMN account_type VARCHAR(32) NOT NULL DEFAULT 'MEMBER';