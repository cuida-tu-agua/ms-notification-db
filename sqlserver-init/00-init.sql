-- sqlserver-init/00-init.sql
-- Runs once as sa. The database and security.users come from ms-iam-db, places.places from ms-places-db:
-- run those two first.
IF DB_ID('sy-water-db') IS NULL
    THROW 50001, 'Database sy-water-db does not exist. Run ms-iam-db first.', 1;
GO

USE [sy-water-db];
GO

IF OBJECT_ID(N'places.places', N'U') IS NULL
    THROW 50002, 'Table places.places does not exist. Run ms-places-db first.', 1;
GO

IF SCHEMA_ID('notification') IS NULL
    EXEC('CREATE SCHEMA notification');
GO

-- Runtime user for notification-service
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name='notification_app')
    CREATE LOGIN notification_app WITH PASSWORD='$(NOTIFICATION_APP_PASSWORD)';
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name='notification_app')
BEGIN
    CREATE USER notification_app FOR LOGIN notification_app
        WITH DEFAULT_SCHEMA = notification;
END
GO

-- Migration user for Liquibase
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name='notification_migrator')
    CREATE LOGIN notification_migrator WITH PASSWORD='$(NOTIFICATION_MIGRATOR_PASSWORD)';
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name='notification_migrator')
BEGIN
    CREATE USER notification_migrator FOR LOGIN notification_migrator
        WITH DEFAULT_SCHEMA = notification;
END
GO

GRANT CONTROL ON SCHEMA::notification TO notification_migrator;
GRANT CREATE TABLE TO notification_migrator;
GRANT CREATE ROLE TO notification_migrator;
GRANT ALTER ANY ROLE TO notification_migrator;
GO

-- Needed to create the cross-schema FKs (places.places and security.users)
GRANT REFERENCES ON OBJECT::places.places   TO notification_migrator;
GRANT REFERENCES ON OBJECT::security.users  TO notification_migrator;
GO
