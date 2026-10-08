--liquibase formatted sql

--changeset esteban:v1.1-ddl-fk-002-fk-pdev-place
--comment: place_devices.place_id -> places.places (cross-schema, ADR-002)
ALTER TABLE notification.place_devices
    ADD CONSTRAINT FK_pdev_place
    FOREIGN KEY (place_id) REFERENCES places.places (id);
--rollback ALTER TABLE notification.place_devices DROP CONSTRAINT FK_pdev_place;
