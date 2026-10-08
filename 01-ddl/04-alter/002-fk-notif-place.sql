--liquibase formatted sql

--changeset diego:ddl-fk-002-fk-notif-place
--comment: notifications.place_id -> places.places (cross-schema, ADR-002)
ALTER TABLE notification.notifications
    ADD CONSTRAINT FK_notif_place
    FOREIGN KEY (place_id) REFERENCES places.places (id);
--rollback ALTER TABLE notification.notifications DROP CONSTRAINT FK_notif_place;
