# Node.js Workspace

Entorno de desarrollo para Node.js utilizando Visual Studio Code y Dev Containers.

## Requisitos

- Docker
- Visual Studio Code
- Extensión Remote - Containers para VS Code

## Inicio rápido

1. Abre esta carpeta en Visual Studio Code
2. Cuando VS Code lo sugiera, haz clic en "Reabrir en Contenedor"
3. ¡Listo para desarrollar!

## Estructura del proyecto

- \`/node-workspace\`: Carpeta donde debes colocar la aplicación
- \`/.devcontainer\`: Configuración del entorno de desarrollo
- \`/.ssh\`: Llaves SSH para acceso a Git (se montan en el contenedor)

## Comandos útiles

- \`npm start\`: Inicia la aplicación
- \`npm run dev\`: Inicia la aplicación con recarga automática (nodemon)
- \`npm test\`: Ejecuta pruebas