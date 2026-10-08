--liquibase formatted sql

--changeset esteban:v1.3-ddl-fk-001-fk-eout-user
--comment: email_outbox.user_id -> security.users (cross-schema, ADR-002)
ALTER TABLE notification.email_outbox
    ADD CONSTRAINT FK_eout_user
    FOREIGN KEY (user_id) REFERENCES security.users (id);
--rollback ALTER TABLE notification.email_outbox DROP CONSTRAINT FK_eout_user;
