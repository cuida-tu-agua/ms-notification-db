--liquibase formatted sql

--changeset diego:v1.5-ddl-fk-001-fk-ptok-user
--comment: push_tokens.user_id -> security.users (cross-schema, ADR-002)
ALTER TABLE notification.push_tokens
    ADD CONSTRAINT FK_ptok_user
    FOREIGN KEY (user_id) REFERENCES security.users (id);
--rollback ALTER TABLE notification.push_tokens DROP CONSTRAINT FK_ptok_user;
