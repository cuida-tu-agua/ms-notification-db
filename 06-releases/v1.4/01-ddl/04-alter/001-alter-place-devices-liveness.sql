--liquibase formatted sql

--changeset esteban:v1.4-ddl-alter-001-place-devices-liveness
--comment: HU-032 when the device last reported (server time) and when we told the owner it went silent. offline_alerted_at IS NOT NULL = already alerted: ONE alert until the device reports again
ALTER TABLE notification.place_devices ADD
    last_reading_at   DATETIME2 NULL,
    offline_alerted_at DATETIME2 NULL;
--rollback ALTER TABLE notification.place_devices DROP COLUMN last_reading_at, offline_alerted_at;
