# Configuración de Dev Container para Node.js

Este proyecto incluye una configuración de Dev Container para facilitar el desarrollo de aplicaciones en Node.js. A continuación, se describen los pasos necesarios para iniciar el entorno de desarrollo.

## Requisitos previos

Antes de comenzar, asegúrate de tener instalados los siguientes programas en tu sistema:

- [Docker](https://www.docker.com/): Para ejecutar contenedores.
- [Visual Studio Code](https://code.visualstudio.com/): Editor de código.
- Extensión [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) para Visual Studio Code.
- Tener generada la imagen `devcontainer/node:22.14.0-ubuntu-dev`

## Pasos para iniciar el entorno

1. **Clona el repositorio:**
   
   Si aún no lo has hecho, clona este repositorio en tu máquina local:
   ```bash
   git clone https://github.com/rex2002xp/workspaces
   cd workspaces/node-workspaces
   ```

2. **Abre el proyecto en Visual Studio Code:**
   
   Abre la carpeta raíz del proyecto `node-workspaces` en Visual Studio Code.

3. **Reabre el proyecto en el contenedor:**
   
   Cuando VS Code detecte la configuración de Dev Container, aparecerá una notificación en la esquina inferior derecha. Haz clic en "Reabrir en contenedor". Si no aparece la notificación, abre el comando "Command Palette" (Ctrl+Shift+P o Cmd+Shift+P en macOS) y selecciona:
   ```
   Remote-Containers: Reopen in Container
   ```

4. **Espera a que se configure el entorno:**
   
   VS Code descargará la imagen de Docker y configurará el contenedor. Este proceso puede tardar unos minutos la primera vez.

5. **¡Listo para desarrollar!**
   
   Una vez que el contenedor esté listo, podrás comenzar a desarrollar tu aplicación en Node.js. El directorio de trabajo dentro del contenedor es `/node-workspace`.

## Características del entorno

- **Puertos expuestos:**
  - `3000`: Común para aplicaciones Express y Node.js.
  - `8080`: Común para frameworks como Next.js.
  - `9229`: Depurador de Node.js.

- **Extensiones preinstaladas:**
  - ESLint, Prettier, TypeScript, entre otras.

- **Usuario configurado:**
  - Usuario no privilegiado `devuser` para mayor seguridad.

- **Autenticación con Git**
  - Se debe copiar las llaves de autenticación en la carpeta `.ssh`, de esta forma poder firmar los commit y sincronizar el proyecto creado con el repositorio GIT de su preferencia.
  - Las llaves serán accesibles en modo de lectura dentro del ambiente dev container. 

## Comandos útiles

Dentro del contenedor, puedes usar los siguientes comandos:

- **Iniciar la aplicación:**
  ```bash
  npm start
  ```

- **Modo desarrollo con recarga automática:**
  ```bash
  npm run dev
  ```

- **Ejecutar pruebas:**
  ```bash
  npm test
  ```

## Notas adicionales

- Si necesitas instalar dependencias adicionales, puedes hacerlo directamente dentro del contenedor usando `npm install`.
- Los cambios realizados en el código se reflejarán automáticamente gracias al volumen montado entre tu máquina local y el contenedor.