--liquibase formatted sql

--changeset diego:v1.2-ddl-fk-001-fk-nprefs-user
--comment: notification_preferences.user_id -> security.users (cross-schema, ADR-002)
ALTER TABLE notification.notification_preferences
    ADD CONSTRAINT FK_nprefs_user
    FOREIGN KEY (user_id) REFERENCES security.users (id);
--rollback ALTER TABLE notification.notification_preferences DROP CONSTRAINT FK_nprefs_user;
