--liquibase formatted sql

--changeset esteban:ddl-table-002-notification-reads
--comment: Who already read which notification. One row per (notification, user): a role notification is read by each person separately
CREATE TABLE notification.notification_reads (
    notification_id UNIQUEIDENTIFIER NOT NULL,
    user_id         UNIQUEIDENTIFIER NOT NULL,
    read_at         DATETIME2        NOT NULL CONSTRAINT DF_nread_read_at DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_notification_reads PRIMARY KEY (notification_id, user_id)
);
--rollback DROP TABLE notification.notification_reads;
