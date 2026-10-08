--liquibase formatted sql

--changeset diego:dcl-grant-001-notification-rw runInTransaction:false
--comment: Notifications and reads are history (no UPDATE/DELETE of notifications, no DELETE of reads); Liquibase tables are read only
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::notification TO notification_rw;
DENY  UPDATE, DELETE ON OBJECT::notification.notifications            TO notification_rw;
DENY  UPDATE, DELETE ON OBJECT::notification.notification_reads       TO notification_rw;
DENY  INSERT, UPDATE, DELETE ON OBJECT::notification.DATABASECHANGELOG     TO notification_rw;
DENY  INSERT, UPDATE, DELETE ON OBJECT::notification.DATABASECHANGELOGLOCK TO notification_rw;
--rollback REVOKE INSERT, UPDATE, DELETE ON OBJECT::notification.DATABASECHANGELOGLOCK FROM notification_rw;
--rollback REVOKE INSERT, UPDATE, DELETE ON OBJECT::notification.DATABASECHANGELOG     FROM notification_rw;
--rollback REVOKE UPDATE, DELETE ON OBJECT::notification.notification_reads FROM notification_rw;
--rollback REVOKE UPDATE, DELETE ON OBJECT::notification.notifications      FROM notification_rw;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON SCHEMA::notification FROM notification_rw;
