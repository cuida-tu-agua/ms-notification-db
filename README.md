# ms-notification-db

Repositorio de **base de datos** del dominio de Notificaciones de **Sy Water**. Administra el schema `notification` de `sy-water-db` con **Liquibase**. notification-service solo se conecta, no crea tablas.

## Requisitos

- `ms-iam-db` y `ms-places-db` aplicados (FKs a `security.users` y `places.places`).
- Contenedor `sy_water_db_dev` arriba (puerto 1433).

## Puesta en marcha

```powershell
Copy-Item .env.example .env        # fill in passwords (same sa as ms-iam-db)
docker compose up                  # sqlserver-init + liquibase update
```

## Releases

| Tag | Contenido |
|-----|-----------|
| `v1.0-baseline` | `notification.notifications` (un mensaje para UN usuario o para TODOS los de un rol), `notification.notification_reads` (quién leyó qué), FKs, índices de bandeja, idempotencia por evento de origen, rol `notification_rw` (sin UPDATE/DELETE de notificaciones) |
| `v1.1-place-devices` | `notification.place_devices`: dueño del dispositivo de cada lugar (de `device.linked`) y último estado de la válvula, para notificar solo los cambios (HU-033) |
| `v1.2-preferences` | `notification.notification_preferences`: canales que el usuario quiere por nivel de urgencia (HU-034); las críticas siempre conservan la app |
| `v1.3-email-outbox` | `notification.email_outbox`: correos pendientes de enviar (HU-027) con reintentos; no guarda la dirección, se pide a ms-iam al enviar |

## Reglas

- No editar un changeset ya aplicado. Todo cambio nuevo va en `06-releases/vX.Y/`.
- Nunca subir `.env`.
