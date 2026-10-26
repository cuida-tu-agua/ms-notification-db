--liquibase formatted sql

--changeset diego:v1.7-ddl-fk-001-fk-mtpl-user
--comment: message_templates.updated_by -> security.users (cross-schema, ADR-002): the admin who saved the text
ALTER TABLE notification.message_templates
    ADD CONSTRAINT FK_mtpl_user
    FOREIGN KEY (updated_by) REFERENCES security.users (id);
--rollback ALTER TABLE notification.message_templates DROP CONSTRAINT FK_mtpl_user;
