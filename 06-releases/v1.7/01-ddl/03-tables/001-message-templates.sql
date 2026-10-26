--liquibase formatted sql

--changeset diego:v1.7-ddl-table-001-message-templates
--comment: Texts of the WhatsApp / SMS messages that the admin customized (critical alert, phone code, collaborator invitation, guest link shared by WhatsApp). ONLY the customized ones are stored: a key without a row uses the default text of ms-notification, and "restore default" deletes the row. Placeholders such as {place} or {code} are checked by ms-notification when the admin saves. body fits the sms_outbox body (320)
CREATE TABLE notification.message_templates (
    template_key NVARCHAR(40)     NOT NULL,
    body         NVARCHAR(320)    NOT NULL,
    updated_by   UNIQUEIDENTIFIER NULL,
    updated_at   DATETIME2        NOT NULL CONSTRAINT DF_mtpl_updated_at DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_message_templates PRIMARY KEY (template_key),
    CONSTRAINT CK_mtpl_key  CHECK (template_key IN (N'ALERT_CRITICAL', N'PHONE_CODE', N'COLLABORATOR_INVITATION', N'GUEST_LINK_SHARE')),
    CONSTRAINT CK_mtpl_body CHECK (LEN(LTRIM(RTRIM(body))) > 0)
);
--rollback DROP TABLE notification.message_templates;
