--liquibase formatted sql

--changeset esteban:ddl-table-001-notifications
--comment: One message for ONE user (user_id) or for EVERY user with a role (role). Never both, never none. Immutable: reading is stored in notification_reads
CREATE TABLE notification.notifications (
    id              UNIQUEIDENTIFIER NOT NULL,
    user_id         UNIQUEIDENTIFIER NULL,
    role            NVARCHAR(30)     NULL,
    type            NVARCHAR(30)     NOT NULL,
    severity        NVARCHAR(10)     NOT NULL CONSTRAINT DF_notif_severity   DEFAULT (N'INFO'),
    title           NVARCHAR(150)    NOT NULL,
    body            NVARCHAR(1000)   NOT NULL,
    place_id        UNIQUEIDENTIFIER NULL,
    source_event_id NVARCHAR(100)    NULL,
    created_at      DATETIME2        NOT NULL CONSTRAINT DF_notif_created_at DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_notifications PRIMARY KEY (id),
    CONSTRAINT CK_notif_audience CHECK ((user_id IS NOT NULL AND role IS NULL) OR (user_id IS NULL AND role IS NOT NULL)),
    CONSTRAINT CK_notif_severity CHECK (severity IN (N'INFO', N'WARNING', N'CRITICAL')),
    CONSTRAINT CK_notif_type     CHECK (type IN (N'DEVICE_LINKED', N'DEVICE_UNLINKED', N'VALVE_CHANGED', N'DEVICE_OFFLINE', N'SYSTEM_ANNOUNCEMENT'))
);
--rollback DROP TABLE notification.notifications;
