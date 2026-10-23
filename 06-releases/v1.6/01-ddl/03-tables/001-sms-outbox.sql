--liquibase formatted sql

--changeset diego:v1.6-ddl-table-001-sms-outbox
--comment: HU-028 short messages (SMS or WhatsApp) of CRITICAL alerts waiting to leave (outbox, same pattern as email_outbox). The phone is NOT stored: it is asked to ms-iam when the message is sent, with the mode (SMS / WHATSAPP) the user verified it with. SKIPPED = at sending time the user had no verified phone (not retried). channel and provider_message_id record how it left (Twilio SID). Verification codes do NOT go through this table: they are sent at once and never stored here
CREATE TABLE notification.sms_outbox (
    id                  UNIQUEIDENTIFIER NOT NULL,
    user_id             UNIQUEIDENTIFIER NOT NULL,
    source_event_id     NVARCHAR(100)    NULL,
    body                NVARCHAR(320)    NOT NULL,
    status              NVARCHAR(10)     NOT NULL CONSTRAINT DF_sout_status     DEFAULT (N'PENDING'),
    channel             NVARCHAR(10)     NULL,
    provider_message_id NVARCHAR(64)     NULL,
    attempts            INT              NOT NULL CONSTRAINT DF_sout_attempts   DEFAULT (0),
    next_attempt_at     DATETIME2        NOT NULL,
    last_error          NVARCHAR(500)    NULL,
    created_at          DATETIME2        NOT NULL CONSTRAINT DF_sout_created_at DEFAULT (SYSUTCDATETIME()),
    sent_at             DATETIME2        NULL,
    CONSTRAINT PK_sms_outbox  PRIMARY KEY (id),
    CONSTRAINT CK_sout_status CHECK (status IN (N'PENDING', N'SENT', N'FAILED', N'SKIPPED')),
    CONSTRAINT CK_sout_sent   CHECK ((status = N'SENT' AND sent_at IS NOT NULL AND channel IS NOT NULL)
                                     OR (status <> N'SENT' AND sent_at IS NULL)),
    CONSTRAINT CK_sout_channel  CHECK (channel IS NULL OR channel IN (N'SMS', N'WHATSAPP')),
    CONSTRAINT CK_sout_attempts CHECK (attempts >= 0)
);
--rollback DROP TABLE notification.sms_outbox;
