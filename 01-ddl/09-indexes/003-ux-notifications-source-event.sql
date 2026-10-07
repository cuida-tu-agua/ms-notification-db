--liquibase formatted sql

--changeset esteban:ddl-index-003-ux-notifications-source-event
--comment: A RabbitMQ event delivered twice creates ONE notification per audience (idempotent consumer)
CREATE UNIQUE INDEX UX_notif_source_audience ON notification.notifications (source_event_id, user_id, role) WHERE source_event_id IS NOT NULL;
--rollback DROP INDEX UX_notif_source_audience ON notification.notifications;
