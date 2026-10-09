--liquibase formatted sql

--changeset diego:v1.5-ddl-index-001-ix-push-tokens-user
--comment: The dispatcher looks for all the phones of one user when an alert arrives
CREATE INDEX IX_ptok_user ON notification.push_tokens (user_id);
--rollback DROP INDEX IX_ptok_user ON notification.push_tokens;
