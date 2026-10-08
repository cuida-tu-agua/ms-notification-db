--liquibase formatted sql

--changeset esteban:v1.3-ddl-table-001-email-outbox
--comment: HU-027 e-mails waiting to leave (outbox). The address is NOT stored: it is asked to ms-iam when the mail is sent. One row per (source event, user) so a redelivered event never sends two mails. Failed sends are retried with a growing delay
CREATE TABLE notification.email_outbox (
    id              UNIQUEIDENTIFIER NOT NULL,
    user_id         UNIQUEIDENTIFIER NOT NULL,
    source_event_id NVARCHAR(100)    NULL,
    subject         NVARCHAR(200)    NOT NULL,
    text_body       NVARCHAR(MAX)    NOT NULL,
    html_body       NVARCHAR(MAX)    NOT NULL,
    status          NVARCHAR(10)     NOT NULL CONSTRAINT DF_eout_status     DEFAULT (N'PENDING'),
    attempts        INT              NOT NULL CONSTRAINT DF_eout_attempts   DEFAULT (0),
    next_attempt_at DATETIME2        NOT NULL,
    last_error      NVARCHAR(500)    NULL,
    created_at      DATETIME2        NOT NULL CONSTRAINT DF_eout_created_at DEFAULT (SYSUTCDATETIME()),
    sent_at         DATETIME2        NULL,
    CONSTRAINT PK_email_outbox PRIMARY KEY (id),
    CONSTRAINT CK_eout_status  CHECK (status IN (N'PENDING', N'SENT', N'FAILED')),
    CONSTRAINT CK_eout_sent    CHECK ((status = N'SENT' AND sent_at IS NOT NULL) OR (status <> N'SENT' AND sent_at IS NULL))
);
--rollback DROP TABLE notification.email_outbox;
