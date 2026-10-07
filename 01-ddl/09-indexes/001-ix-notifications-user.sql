--liquibase formatted sql

--changeset esteban:ddl-index-001-ix-notifications-user
--comment: Inbox of one user, newest first
CREATE INDEX IX_notif_user_time ON notification.notifications (user_id, created_at DESC) WHERE user_id IS NOT NULL;
--rollback DROP INDEX IX_notif_user_time ON notification.notifications;
