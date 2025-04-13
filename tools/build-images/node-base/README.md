# Generar la imagen de Node.js para desarrollo

Este proyecto incluye configuraciones para construir una imagen de Docker optimizada para el desarrollo con Node.js. A continuación, se describen los pasos necesarios para generar la imagen y utilizarla en tu entorno de desarrollo.

## Requisitos previos

Antes de comenzar, asegúrate de tener instalados los siguientes programas en tu sistema:

- [Docker](https://www.docker.com/): Para construir y ejecutar contenedores.
- [PowerShell](https://learn.microsoft.com/en-us/powershell/) (solo para Windows): Para ejecutar el script de construcción en sistemas Windows.
- [Bash](https://www.gnu.org/software/bash/) (incluido en la mayoría de distribuciones Linux y macOS): Para ejecutar el script de construcción en sistemas Linux y macOS.
- [jq](https://stedolan.github.io/jq/) (solo para Linux y macOS): Herramienta para procesar JSON. Si no está instalada, puedes hacerlo ejecutando:
  ```bash
  # En distribuciones basadas en Debian/Ubuntu
  sudo apt-get install jq

  # En macOS (usando Homebrew)
  brew install jq
  ```

## Pasos para generar la imagen

### En Windows

1. **Navega al directorio del script de construcción:**
   
   Abre una terminal PowerShell y dirígete al directorio donde se encuentra el script `build-node-image.ps1`:
   ```powershell
   cd tools/build-images/node-base
   ```

2. **Ejecuta el script de construcción:**
   
   Usa el script `build-node-image.ps1` para construir la imagen. Puedes especificar la versión de Node.js que deseas instalar y un tag personalizado para la imagen.

   - Para construir la imagen con la versión predeterminada de Node.js (22.0.0):
     ```powershell
     .\build-node-image.ps1
     ```

   - Para especificar una versión de Node.js:
     ```powershell
     .\build-node-image.ps1 -Version 22.14.0
     ```

   - Para agregar un tag personalizado:
     ```powershell
     .\build-node-image.ps1 -Version 22.14.0 -Tag custom-tag
     ```

3. **Verifica la imagen generada:**
   
   Una vez completada la construcción, puedes verificar que la imagen se haya creado correctamente ejecutando:
   ```powershell
   docker images
   ```

### En Linux y macOS

1. **Navega al directorio del script de construcción:**
   
   Abre una terminal Bash y dirígete al directorio donde se encuentra el script `build-node-image.sh`:
   ```bash
   cd tools/build-images/node-base
   ```

2. **Asigna permisos de ejecución al script (solo la primera vez):**
   ```bash
   chmod +x build-node-image.sh
   ```

3. **Ejecuta el script de construcción:**
   
   Usa el script `build-node-image.sh` para construir la imagen. Puedes especificar la versión de Node.js que deseas instalar y un tag personalizado para la imagen.

   - Para construir la imagen con la versión predeterminada de Node.js (22.0.0):
     ```bash
     ./build-node-image.sh
     ```

   - Para especificar una versión de Node.js:
     ```bash
     ./build-node-image.sh -v 22.14.0
     ```

   - Para agregar un tag personalizado:
     ```bash
     ./build-node-image.sh -v 22.14.0 -t custom-tag
     ```

4. **Verifica la imagen generada:**
   
   Una vez completada la construcción, puedes verificar que la imagen se haya creado correctamente ejecutando:
   ```bash
   docker images
   ```

## Uso de la imagen

Para usar la imagen generada en un contenedor, ejecuta el siguiente comando:

```bash
docker run -it --rm -p 3000:3000 -v $(pwd):/node-workspace devcontainer/node:22.14.0-ubuntu-dev bash
```

Este comando:
- Inicia un contenedor interactivo basado en la imagen generada.
- Mapea el puerto 3000 del contenedor al puerto 3000 de tu máquina local.
- Monta el directorio actual en el contenedor en la ruta `/node-workspace`.

## Notas adicionales

- La imagen expone los puertos 3000 y 8080, comunes para aplicaciones Node.js y frameworks como Next.js.
- El usuario predeterminado dentro del contenedor es `devuser`, configurado para un entorno de desarrollo seguro.
- Puedes personalizar aún más la configuración editando el archivo `Dockerfile` o los scripts de construcción.