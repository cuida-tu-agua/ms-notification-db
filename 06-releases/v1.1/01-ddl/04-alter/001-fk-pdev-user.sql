--liquibase formatted sql

--changeset esteban:v1.1-ddl-fk-001-fk-pdev-user
--comment: place_devices.user_id -> security.users (cross-schema, ADR-002)
ALTER TABLE notification.place_devices
    ADD CONSTRAINT FK_pdev_user
    FOREIGN KEY (user_id) REFERENCES security.users (id);
--rollback ALTER TABLE notification.place_devices DROP CONSTRAINT FK_pdev_user;
