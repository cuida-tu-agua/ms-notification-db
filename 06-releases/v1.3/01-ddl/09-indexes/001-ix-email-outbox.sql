--liquibase formatted sql

--changeset diego:v1.3-ddl-index-001-ix-email-outbox-pending
--comment: The sender looks for the mails that are due: only PENDING ones, oldest attempt first
CREATE INDEX IX_eout_pending ON notification.email_outbox (next_attempt_at) WHERE status = N'PENDING';
--rollback DROP INDEX IX_eout_pending ON notification.email_outbox;

--changeset diego:v1.3-ddl-index-002-ux-email-outbox-source
--comment: A RabbitMQ event delivered twice queues ONE mail per user (idempotent)
CREATE UNIQUE INDEX UX_eout_source_user ON notification.email_outbox (source_event_id, user_id) WHERE source_event_id IS NOT NULL;
--rollback DROP INDEX UX_eout_source_user ON notification.email_outbox;
