--liquibase formatted sql

--changeset diego:v1.6-ddl-index-001-ix-sms-outbox-pending
--comment: The sender looks for the messages that are due: only PENDING ones, oldest attempt first
CREATE INDEX IX_sout_pending ON notification.sms_outbox (next_attempt_at) WHERE status = N'PENDING';
--rollback DROP INDEX IX_sout_pending ON notification.sms_outbox;

--changeset diego:v1.6-ddl-index-002-ux-sms-outbox-source
--comment: A RabbitMQ event delivered twice queues ONE message per user (idempotent: never two SMS for the same alert)
CREATE UNIQUE INDEX UX_sout_source_user ON notification.sms_outbox (source_event_id, user_id) WHERE source_event_id IS NOT NULL;
--rollback DROP INDEX UX_sout_source_user ON notification.sms_outbox;
