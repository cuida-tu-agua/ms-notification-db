--liquibase formatted sql

--changeset diego:ddl-index-002-ix-notifications-role
--comment: Broadcast notifications of a role, newest first
CREATE INDEX IX_notif_role_time ON notification.notifications (role, created_at DESC) WHERE role IS NOT NULL;
--rollback DROP INDEX IX_notif_role_time ON notification.notifications;
