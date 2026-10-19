# Instalación y configuración de Podman

## Windows (10/11)

1. Habilitar WSL2 (PowerShell como administrador):
   ```powershell
   wsl --install --no-distribution
   ```
   Reiniciar el equipo si lo solicita.
2. Instalar Podman y compose:
   ```powershell
   winget install RedHat.Podman
   winget install RedHat.Podman-Desktop   # opcional (interfaz gráfica)
   pip install podman-compose             # opcional si no se usa docker-compose
   ```
   Abrir una nueva terminal.
3. Crear e iniciar la máquina virtual:
   ```powershell
   podman machine init --cpus 4 --memory 6144 --disk-size 60
   podman machine start
   podman info
   ```
   SQL Server requiere **al menos 2 GB** de RAM libre; se recomiendan 6 GB para toda la pila.
4. Verificar: `podman run --rm hello-world` y `podman compose version`.

## Linux (Fedora/RHEL/Ubuntu/Debian)

```bash
# Fedora/RHEL
sudo dnf install -y podman podman-compose
# Debian/Ubuntu
sudo apt update && sudo apt install -y podman podman-compose
```
Para exponer puertos < 1024 en modo rootless (no necesario aquí) ajustar `net.ipv4.ip_unprivileged_port_start`.

## macOS

```bash
brew install podman podman-compose
podman machine init --cpus 4 --memory 6144
podman machine start
```

## Notas

- `podman compose` delega en `docker-compose` o `podman-compose`; cualquiera sirve. El `compose.yaml` raíz usa `include`, que requiere docker-compose v2.20+ o podman-compose 1.1+. Si no está disponible, levantar cada servicio por separado (ver README).
- Los volúmenes llevan `:Z` donde se montan archivos locales (SELinux).
- Registries: si Podman pregunta de qué registry bajar una imagen, elegir el indicado en el compose (se usan nombres completos).
