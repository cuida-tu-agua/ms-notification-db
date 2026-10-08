--liquibase formatted sql

--changeset diego:ddl-fk-003-fk-nread-notification
--comment: notification_reads.notification_id -> notifications (same schema)
ALTER TABLE notification.notification_reads
    ADD CONSTRAINT FK_nread_notification
    FOREIGN KEY (notification_id) REFERENCES notification.notifications (id);
--rollback ALTER TABLE notification.notification_reads DROP CONSTRAINT FK_nread_notification;
