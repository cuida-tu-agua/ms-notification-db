--liquibase formatted sql

--changeset diego:v1.5-ddl-table-001-push-tokens
--comment: HU-026 Expo push tokens of the phones where a user is signed in. The token is unique: if another user signs in on the same phone the row changes owner (a phone never alerts the previous user)
CREATE TABLE notification.push_tokens (
    id           UNIQUEIDENTIFIER NOT NULL,
    user_id      UNIQUEIDENTIFIER NOT NULL,
    token        NVARCHAR(200)    NOT NULL,
    platform     NVARCHAR(10)     NOT NULL,
    created_at   DATETIME2        NOT NULL CONSTRAINT DF_ptok_created_at DEFAULT (SYSUTCDATETIME()),
    last_seen_at DATETIME2        NOT NULL CONSTRAINT DF_ptok_last_seen  DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_push_tokens PRIMARY KEY (id),
    CONSTRAINT UQ_ptok_token  UNIQUE (token),
    CONSTRAINT CK_ptok_platform CHECK (platform IN (N'ANDROID', N'IOS'))
);
--rollback DROP TABLE notification.push_tokens;
