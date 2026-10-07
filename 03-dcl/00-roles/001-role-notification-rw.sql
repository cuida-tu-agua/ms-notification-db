--liquibase formatted sql

--changeset esteban:dcl-role-001-notification-rw runInTransaction:false
--comment: DB role for app read/write + notification_app membership
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name='notification_rw' AND type='R')
    CREATE ROLE notification_rw;
ALTER ROLE notification_rw ADD MEMBER notification_app;
--rollback ALTER ROLE notification_rw DROP MEMBER notification_app;
--rollback DROP ROLE notification_rw;
