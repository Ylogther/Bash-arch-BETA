#!/bin/bash

#script: instalar_blackarch.sh

# Script para instalar el repositorio de BlackArch desde una carpeta temporal

# Paso 1: Crear carpeta temporal
TEMP_DIR=$(mktemp -d)
echo "[*] Carpeta temporal creada en: $TEMP_DIR"
cd "$TEMP_DIR" || { echo "[-] Error al entrar en $TEMP_DIR"; exit 1; }

# Paso 2: Descargar strap.sh
echo "[*] Descargando strap.sh desde blackarch.org..."
curl -O https://blackarch.org/strap.sh || { echo "[-] Error al descargar strap.sh"; exit 1; }

# Paso 3: Dar permisos de ejecución
chmod +x strap.sh

# Paso 4: Ejecutar el script con sudo
echo "[*] Ejecutando strap.sh..."
sudo ./strap.sh || { echo "[-] Error al ejecutar strap.sh"; exit 1; }

# Paso 5: Sincronizar base de datos de paquetes
echo "[*] Actualizando la base de datos de pacman..."
sudo pacman -Sy

echo "[✓] BlackArch instalado correctamente desde carpeta temporal."

# Mensaje final
echo "Puedes listar herramientas con: pacman -Sgg | grep blackarch"
echo "Puedes eliminar la carpeta temporal con: rm -rf $TEMP_DIR"
