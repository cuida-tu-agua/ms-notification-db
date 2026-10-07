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

## Reglas

- No editar un changeset ya aplicado. Todo cambio nuevo va en `06-releases/vX.Y/`.
- Nunca subir `.env`.
