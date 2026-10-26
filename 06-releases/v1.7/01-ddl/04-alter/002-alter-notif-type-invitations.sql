--liquibase formatted sql

--changeset diego:v1.7-ddl-alter-002-notif-type-invitations
--comment: HU-042 / HU-043 new notification types: COLLABORATOR_INVITATION (a registered user is invited to collaborate in a place) and INVITATION_ANSWERED (the owner learns the invitation was accepted or rejected)
ALTER TABLE notification.notifications DROP CONSTRAINT CK_notif_type;
ALTER TABLE notification.notifications ADD CONSTRAINT CK_notif_type
    CHECK (type IN (N'DEVICE_LINKED', N'DEVICE_UNLINKED', N'VALVE_CHANGED', N'DEVICE_OFFLINE', N'SYSTEM_ANNOUNCEMENT',
                    N'COLLABORATOR_INVITATION', N'INVITATION_ANSWERED'));
--rollback ALTER TABLE notification.notifications DROP CONSTRAINT CK_notif_type;
--rollback ALTER TABLE notification.notifications ADD CONSTRAINT CK_notif_type CHECK (type IN (N'DEVICE_LINKED', N'DEVICE_UNLINKED', N'VALVE_CHANGED', N'DEVICE_OFFLINE', N'SYSTEM_ANNOUNCEMENT'));
