--liquibase formatted sql

--changeset esteban:v1.1-ddl-table-001-place-devices
--comment: Local copy of "who owns the device of each place" (from device.linked / device.unlinked) so that a device event with no user id (device.valve.reported) can be turned into a notification for the right person. Also remembers the last valve state to notify only CHANGES
CREATE TABLE notification.place_devices (
    place_id           UNIQUEIDENTIFIER NOT NULL,
    device_id          UNIQUEIDENTIFIER NOT NULL,
    user_id            UNIQUEIDENTIFIER NOT NULL,
    serial_number      NVARCHAR(50)     NOT NULL,
    valve_state        NVARCHAR(10)     NULL,
    valve_reported_at  DATETIME2        NULL,
    created_at         DATETIME2        NOT NULL CONSTRAINT DF_pdev_created_at DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_place_devices PRIMARY KEY (place_id),
    CONSTRAINT UQ_pdev_device   UNIQUE (device_id),
    CONSTRAINT CK_pdev_state    CHECK (valve_state IS NULL OR valve_state IN (N'OPEN', N'CLOSED'))
);
--rollback DROP TABLE notification.place_devices;
