#!/bin/bash
# script: instalar_blackarch.sh
# Instalación segura del repositorio BlackArch desde carpeta temporal

set -euo pipefail

# --- Configuración ---
STRAP_URL="https://blackarch.org/strap.sh"
STRAP_FILE="strap.sh"

# Crear carpeta temporal y asegurar limpieza
TEMP_DIR=$(mktemp -d)
cleanup() {
    echo "[*] Limpiando carpeta temporal: $TEMP_DIR"
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

echo "[*] Carpeta temporal creada en: $TEMP_DIR"
cd "$TEMP_DIR"

# --- Descargar strap.sh ---
echo "[*] Descargando strap.sh desde ${STRAP_URL}..."
curl -fsSLO "$STRAP_URL"

# --- Verificar hash (opcional pero recomendado) ---
echo "[*] Verificando integridad de strap.sh..."
EXPECTED_HASH=$(curl -fsSL https://blackarch.org/strap.sh.sha1 | awk '{print $1}')
DOWNLOADED_HASH=$(sha1sum "$STRAP_FILE" | awk '{print $1}')

if [[ "$EXPECTED_HASH" != "$DOWNLOADED_HASH" ]]; then
    echo "[-] Error: La verificación de integridad falló. Hash inválido."
    exit 1
fi
echo "[✓] Integridad verificada."

# --- Ejecutar script ---
chmod +x "$STRAP_FILE"
echo "[*] Ejecutando strap.sh como root..."
sudo "./$STRAP_FILE"

# --- Actualizar base de datos de paquetes ---
echo "[*] Sincronizando base de datos de pacman..."
sudo pacman -Sy

# --- Mensaje final ---
echo "[✓] BlackArch se instaló correctamente."

echo -e "\n📦 Puedes listar herramientas disponibles con:"
echo "    pacman -Sgg | grep blackarch"

echo -e "\n🧹 Carpeta temporal eliminada automáticamente al salir."

