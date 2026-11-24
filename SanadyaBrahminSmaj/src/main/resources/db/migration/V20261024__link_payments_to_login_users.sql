-- Run after deploying the version that adds payment_history.login_user_id.
-- Existing payments were associated with member profiles through users.id.
UPDATE payment_history p
INNER JOIN users u ON u.id = p.user_id
SET p.login_user_id = u.login_user_id
WHERE p.login_user_id IS NULL
  AND u.login_user_id IS NOT NULL;
