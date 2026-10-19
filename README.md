# podman-dev-stack

Pila de desarrollo local con Podman: **SQL Server, MongoDB, Redis, Redpanda (+ Console) y Mailpit (SMTP)**.

Credenciales de desarrollo: usuario `developer` / contraseña `Puppy.1518` (solo para entornos locales).

## Estructura

```
compose.yaml          # incluye todos los servicios
mssql/                # SQL Server 2022 + init.sql (crea login developer)
mongodb/              # MongoDB 7
redis/                # Redis 7 (ACL: developer)
redpanda/             # Redpanda + Console
mailpit/              # SMTP de pruebas + UI
docs/podman-install.md
```

## Uso

Instalar Podman primero: [docs/podman-install.md](docs/podman-install.md).

```bash
podman compose up -d                          # todo
podman compose -f mongodb/compose.yaml up -d  # un solo servicio
podman compose down                           # detener (agregar -v borra datos)
podman ps
```

## Servicios y conexión

| Servicio | Puerto(s) | Usuario / Password | Conexión |
|---|---|---|---|
| SQL Server | 1433 | `developer` / `Puppy.1518` (`sa` con la misma clave, obligatorio en MSSQL) | `Server=localhost,1433;User Id=developer;Password=Puppy.1518;TrustServerCertificate=True` |
| MongoDB | 27017 | `developer` / `Puppy.1518` | `mongodb://developer:Puppy.1518@localhost:27017/?authSource=admin` |
| Redis | 6379 | `developer` / `Puppy.1518` | `redis-cli --user developer --pass Puppy.1518` |
| Redpanda Kafka | 19092 (desde el host), `redpanda:9092` (entre contenedores) | sin autenticación | `localhost:19092` |
| Redpanda Console | 8080 | sin autenticación | http://localhost:8080 |
| Schema Registry / HTTP Proxy / Admin | 18081 / 18082 / 9644 | sin autenticación | |
| Mailpit SMTP | 1025 | acepta cualquier usuario/clave (sin TLS) | `localhost:1025` |
| Mailpit UI | 8025 | — | http://localhost:8025 |

## Notas

- **SQL Server**: el contenedor `mssql-init` ejecuta `mssql/init.sql` y crea el login `developer` (sysadmin). El `sa` no se puede eliminar.
- **Redis**: el usuario `default` está deshabilitado.
- **Redpanda**: modo `dev-container`, sin SASL (no es obligatorio). Probar: `podman exec -it redpanda rpk topic create demo`.
- **Mailpit**: apuntar las aplicaciones a `localhost:1025` y ver correos en la UI.
- Entre contenedores en la misma red, usar nombres de servicio; para comunicar stacks distintos usar `host.containers.internal`.
- Persistencia mediante volúmenes nombrados de Podman.
