# Generar la imagen de Node.js para desarrollo

Este proyecto incluye configuraciones para construir una imagen de Docker optimizada para el desarrollo con Node.js. A continuación, se describen los pasos necesarios para generar la imagen y utilizarla en tu entorno de desarrollo.

## Requisitos previos

Antes de comenzar, asegúrate de tener instalados los siguientes programas en tu sistema:

- [Docker](https://www.docker.com/): Para construir y ejecutar contenedores.
- [PowerShell](https://learn.microsoft.com/en-us/powershell/): Para ejecutar el script de construcción.

## Pasos para generar la imagen

1. **Navega al directorio del script de construcción:**
   
   Abre una terminal y dirígete al directorio donde se encuentra el script `compiler.ps1`:
   ```powershell
   cd tools/build-images/node-base
   ```

2. **Ejecuta el script de construcción:**
   
   Usa el script `compiler.ps1` para construir la imagen. Puedes especificar la versión de Node.js que deseas instalar y un tag personalizado para la imagen.

   - Para construir la imagen con la versión predeterminada de Node.js (22.0.0):
     ```powershell
     .\compiler.ps1
     ```

   - Para especificar una versión de Node.js:
     ```powershell
     .\compiler.ps1 -Version 22.14.0
     ```

   - Para agregar un tag personalizado:
     ```powershell
     .\compiler.ps1 -Version 22.14.0 -Tag custom-tag
     ```

3. **Verifica la imagen generada:**
   
   Una vez completada la construcción, puedes verificar que la imagen se haya creado correctamente ejecutando:
   ```powershell
   docker images
   ```
   Busca la imagen con el tag que especificaste (por ejemplo, `devcontainer/node:22.14.0-ubuntu-dev`).

## Uso de la imagen

Para usar la imagen generada en un contenedor, ejecuta el siguiente comando:

```powershell
docker run -it --rm -p 3000:3000 -v ${PWD}:/node-workspace devcontainer/node:22.14.0-ubuntu-dev bash
```

Este comando:
- Inicia un contenedor interactivo basado en la imagen generada.
- Mapea el puerto 3000 del contenedor al puerto 3000 de tu máquina local.
- Monta el directorio actual en el contenedor en la ruta `/node-workspace`.

## Notas adicionales

- La imagen expone los puertos 3000 y 8080, comunes para aplicaciones Node.js y frameworks como Next.js.
- El usuario predeterminado dentro del contenedor es `devuser`, configurado para un entorno de desarrollo seguro.
- Puedes personalizar aún más la configuración editando el archivo `Dockerfile` o el script `compiler.ps1`.