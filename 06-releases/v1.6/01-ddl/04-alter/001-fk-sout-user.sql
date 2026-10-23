--liquibase formatted sql

--changeset diego:v1.6-ddl-fk-001-fk-sout-user
--comment: sms_outbox.user_id -> security.users (cross-schema, ADR-002)
ALTER TABLE notification.sms_outbox
    ADD CONSTRAINT FK_sout_user
    FOREIGN KEY (user_id) REFERENCES security.users (id);
--rollback ALTER TABLE notification.sms_outbox DROP CONSTRAINT FK_sout_user;
