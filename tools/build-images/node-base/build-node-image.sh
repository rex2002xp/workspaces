#!/bin/bash

# Script para construir una imagen de un contenedor de Node.js con Ubuntu.
# Este script es compatible con sistemas operativos Linux y macOS.

# Función para mostrar mensajes de error y salir
function error_exit {
  echo "Error: $1" >&2
  exit 1
}

# Valores predeterminados
VERSION="22.0.0"
TAG=""

# Procesar argumentos
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -v|--version)
      VERSION="$2"
      shift 2
      ;;
    -t|--tag)
      TAG="$2"
      shift 2
      ;;
    *)
      error_exit "Argumento desconocido: $1"
      ;;
  esac
done

# Obtener la fecha actual en formato ISO (YYYY-MM-DD)
CURRENT_DATE=$(date +"%Y-%m-%d")

# Configurar el tag de la imagen
if [ -z "$TAG" ]; then
  IMAGE_TAG="devcontainer/node:${VERSION}-ubuntu-dev"
else
  IMAGE_TAG="devcontainer/node:${TAG}"
fi

# Mostrar información de construcción
echo "Construyendo imagen de Node.js $VERSION con Ubuntu..."
echo "Tag de imagen: $IMAGE_TAG"

# Construir la imagen con docker
DOCKER_BUILD_CMD="docker build --build-arg NODE_VERSION=$VERSION --build-arg BUILD_DATE=$CURRENT_DATE -t $IMAGE_TAG ."
echo "Ejecutando: $DOCKER_BUILD_CMD"

if eval $DOCKER_BUILD_CMD; then
  echo "Imagen construida exitosamente: $IMAGE_TAG"

  # Obtener información de la imagen
  IMAGE_INFO=$(docker image inspect $IMAGE_TAG 2>/dev/null)

  if [ -n "$IMAGE_INFO" ]; then
    # Mostrar etiquetas de la imagen
    echo -e "\nEtiquetas de la imagen:"
    LABELS=$(echo "$IMAGE_INFO" | jq -r '.[0].Config.Labels | to_entries[] | "• \(.key): \(.value)"')
    if [ -n "$LABELS" ]; then
      echo "$LABELS"
    else
      echo "No se encontraron etiquetas específicas en la imagen."
    fi

    # Mostrar puertos expuestos
    echo -e "\nPuertos expuestos:"
    PORTS=$(echo "$IMAGE_INFO" | jq -r '.[0].Config.ExposedPorts | keys[]')
    if [ -n "$PORTS" ]; then
      echo "$PORTS" | sed 's/^/• /'
    else
      echo "• 3000/tcp"
      echo "• 8080/tcp"
      echo "(Los puertos se especifican en el Dockerfile pero pueden no aparecer en la inspección)"
    fi
  else
    echo "No se pudo inspeccionar la imagen."
  fi
else
  error_exit "Error al construir la imagen."
fi

# Mostrar comando para ejecutar un contenedor con esta imagen
echo -e "\nPara ejecutar un contenedor con esta imagen:"
echo "docker run -it --rm -p 3000:3000 -v \$(pwd):/home/devuser/app $IMAGE_TAG bash"