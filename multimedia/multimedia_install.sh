#!/bin/bash

# script: multimedia_install.sh

set -euo pipefail

# === Colores ===
GREEN='\e[32m'
YELLOW='\e[33m'
RED='\e[31m'
RESET='\e[0m'

titulo() {
    echo -e "\n${YELLOW}==> $1${RESET}"
}

exito() {
    echo -e "${GREEN}✔ $1${RESET}"
}

error() {
    echo -e "${RED}✖ $1${RESET}"
    exit 1
}

# === Verificación de root ===
if [[ $EUID -ne 0 ]]; then
    error "Este script debe ejecutarse como root. Usa sudo."
fi

# === 1. Actualizar base de datos ===
titulo "🔄 Sincronizando base de datos de paquetes..."
pacman -Sy --noconfirm || error "Error al sincronizar la base de datos"

# === 2. Flatpak y Flathub ===
titulo "📦 Verificando Flatpak y Flathub..."
if ! command -v flatpak &>/dev/null; then
    pacman -S --noconfirm flatpak || error "No se pudo instalar Flatpak"
fi

if ! flatpak remote-list | grep -q flathub; then
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo || \
        error "No se pudo agregar Flathub"
fi
exito "Flatpak y Flathub listos"

# === 3. Instalación de herramientas multimedia ===
titulo "🎨 Instalando herramientas multimedia nativas..."

PAQUETES=(
    inkscape krita gimp
    blender obs-studio kdenlive
    audacity lmms ardour
)

pacman -S --noconfirm --needed "${PAQUETES[@]}" || error "Fallo instalando paquetes multimedia"
exito "Paquetes multimedia instalados correctamente"

# === 4. (Opcional) Instalación por Flatpak ===
# titulo "📦 Instalando versiones Flatpak (opcional)..."
# FLATPAKS=(
#     org.blender.Blender
#     org.inkscape.Inkscape
#     org.gimp.GIMP
#     org.kde.kdenlive
#     com.obsproject.Studio
#     org.audacityteam.Audacity
# )
# flatpak install -y flathub "${FLATPAKS[@]}" || error "Fallo en instalación Flatpak"

# === Fin ===
titulo "✅ Instalación multimedia completada correctamente."
