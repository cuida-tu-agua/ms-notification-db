--liquibase formatted sql

--changeset esteban:v1.2-ddl-table-001-notification-preferences
--comment: HU-034 channels the user wants for each urgency level. A missing row = the default of the channel matrix. A CRITICAL level always keeps the in-app channel (CK_nprefs_critical_in_app)
CREATE TABLE notification.notification_preferences (
    user_id    UNIQUEIDENTIFIER NOT NULL,
    severity   NVARCHAR(10)     NOT NULL,
    in_app     BIT              NOT NULL,
    push       BIT              NOT NULL,
    email      BIT              NOT NULL,
    sms        BIT              NOT NULL,
    updated_at DATETIME2        NOT NULL CONSTRAINT DF_nprefs_updated_at DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_notification_preferences PRIMARY KEY (user_id, severity),
    CONSTRAINT CK_nprefs_severity CHECK (severity IN (N'INFO', N'WARNING', N'CRITICAL')),
    CONSTRAINT CK_nprefs_critical_in_app CHECK (severity <> N'CRITICAL' OR in_app = 1)
);
--rollback DROP TABLE notification.notification_preferences;
