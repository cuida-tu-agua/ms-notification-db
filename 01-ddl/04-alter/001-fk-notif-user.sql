--liquibase formatted sql

--changeset diego:ddl-fk-001-fk-notif-user
--comment: notifications.user_id -> security.users (cross-schema, ADR-002)
ALTER TABLE notification.notifications
    ADD CONSTRAINT FK_notif_user
    FOREIGN KEY (user_id) REFERENCES security.users (id);
--rollback ALTER TABLE notification.notifications DROP CONSTRAINT FK_notif_user;
