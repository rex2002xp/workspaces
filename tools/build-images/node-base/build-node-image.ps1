<#
.SYNOPSIS
    Script para construir una imagen de un contenedor de Node.js con Ubuntu.
.DESCRIPTION
    Este script construye una imagen de un contenedor basada en Ubuntu con una versión específica de Node.js.
    Si no se especifica una versión, se utiliza la 22.0.0 por defecto.
.PARAMETER Version
    La versión de Node.js para instalar (p.ej., 22.0.0, 22.1.0, etc.)
.PARAMETER Tag
    Tag personalizado para la imagen. Si no se especifica, se usará la versión de Node.js.
.EXAMPLE
    .\build-node-image.ps1 -Version 22.0.0
.EXAMPLE
    .\build-node-image.ps1 -Version 22.14.0 -Tag custom-tag
#>

param (
    [Parameter(Mandatory=$false)]
    [string]$Version = "22.0.0",
    
    [Parameter(Mandatory=$false)]
    [string]$Tag = ""
)

# Obtener la fecha actual en formato ISO (YYYY-MM-DD)
$currentDate = Get-Date -Format "yyyy-MM-dd"

# Configurar el tag de la imagen
$imageTag = if ($Tag -eq "") { "devcontainer/node:$Version-ubuntu-dev" } else { "devcontainer/node:$Tag" }

# Mostrar información de construcción
Write-Host "Construyendo imagen de Node.js $Version con Ubuntu..." -ForegroundColor Cyan
Write-Host "Tag de imagen: $imageTag" -ForegroundColor Cyan

# Construir la imagen con docker
try {
    Write-Host "Ejecutando: docker build --build-arg NODE_VERSION=$Version --build-arg BUILD_DATE=$currentDate -t $imageTag ." -ForegroundColor Yellow
    docker build --build-arg NODE_VERSION=$Version --build-arg BUILD_DATE=$currentDate -t $imageTag .
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Imagen construida exitosamente: $imageTag" -ForegroundColor Green
        
        # Obtener información de la imagen
        $imageInfo = docker image inspect $imageTag | ConvertFrom-Json
        
        # Mostrar información de etiquetas
        Write-Host "`nEtiquetas de la imagen:" -ForegroundColor Cyan
        
        # Mostrar etiquetas desde ambas ubicaciones posibles
        $allLabels = @{}
        
        # Etiquetas en el objeto raíz
        if ($imageInfo.Labels -and $imageInfo.Labels.PSObject.Properties.Count -gt 0) {
            $imageInfo.Labels.PSObject.Properties | ForEach-Object {
                $allLabels[$_.Name] = $_.Value
            }
        }
        
        # Etiquetas en el objeto Config
        if ($imageInfo.Config -and $imageInfo.Config.Labels -and $imageInfo.Config.Labels.PSObject.Properties.Count -gt 0) {
            $imageInfo.Config.Labels.PSObject.Properties | ForEach-Object {
                if (-not $allLabels.ContainsKey($_.Name)) {
                    $allLabels[$_.Name] = $_.Value
                }
            }
        }
        
        # Mostrar todas las etiquetas encontradas
        if ($allLabels.Count -gt 0) {
            $allLabels.GetEnumerator() | Sort-Object Name | Format-Table Name, Value -AutoSize
        } else {
            Write-Host "No se encontraron etiquetas específicas en la imagen" -ForegroundColor Yellow
        }
        
        # Mostrar puertos expuestos
        Write-Host "`nPuertos expuestos:" -ForegroundColor Cyan
        if ($imageInfo.Config -and $imageInfo.Config.ExposedPorts) {
            $imageInfo.Config.ExposedPorts.PSObject.Properties.Name | ForEach-Object {
                Write-Host "• $_" -ForegroundColor Yellow
            }
        } else {
            Write-Host "• 3000/tcp" -ForegroundColor Yellow
            Write-Host "• 8080/tcp" -ForegroundColor Yellow
            Write-Host "(Los puertos se especifican en el Dockerfile pero pueden no aparecer en la inspección)" -ForegroundColor Gray
        }
    } else {
        Write-Host "Error al construir la imagen." -ForegroundColor Red
    }
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}

# Mostrar comando para ejecutar un contenedor con esta imagen
Write-Host "`nPara ejecutar un contenedor con esta imagen:" -ForegroundColor Cyan
Write-Host "docker run -it --rm -p 3000:3000 -v $(pwd):/home/devuser/app $imageTag bash" -ForegroundColor Yellow