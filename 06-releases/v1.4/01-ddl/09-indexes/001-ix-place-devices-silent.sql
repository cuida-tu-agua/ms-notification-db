--liquibase formatted sql

--changeset esteban:v1.4-ddl-index-001-ix-place-devices-silent
--comment: The detector looks for devices that reported once, went silent and were not alerted yet
CREATE INDEX IX_pdev_silent ON notification.place_devices (last_reading_at) WHERE offline_alerted_at IS NULL AND last_reading_at IS NOT NULL;
--rollback DROP INDEX IX_pdev_silent ON notification.place_devices;
