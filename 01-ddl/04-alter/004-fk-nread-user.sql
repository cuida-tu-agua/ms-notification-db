--liquibase formatted sql

--changeset esteban:ddl-fk-004-fk-nread-user
--comment: notification_reads.user_id -> security.users (cross-schema, ADR-002)
ALTER TABLE notification.notification_reads
    ADD CONSTRAINT FK_nread_user
    FOREIGN KEY (user_id) REFERENCES security.users (id);
--rollback ALTER TABLE notification.notification_reads DROP CONSTRAINT FK_nread_user;
