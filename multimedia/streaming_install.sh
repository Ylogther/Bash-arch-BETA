#!/bin/bash

# script: streaming_install.sh

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

# === Verificación de privilegios ===
if [[ $EUID -ne 0 ]]; then
    error "Este script debe ejecutarse como root. Usa sudo."
fi

# === Detectar sistema ===
if command -v pacman &>/dev/null; then
    DISTRO="arch"
elif command -v apt &>/dev/null; then
    DISTRO="debian"
else
    error "Gestor de paquetes no compatible (se requiere pacman o apt)"
fi

# === Instalar OBS y plugins ===
titulo "🎥 Instalando OBS Studio y herramientas de cámara virtual..."

if [[ "$DISTRO" == "arch" ]]; then
    pacman -Sy --noconfirm obs-studio || error "No se pudo instalar obs-studio"

    if command -v yay &>/dev/null; then
        titulo "📦 Instalando obs-v4l2sink desde AUR..."
        sudo -u "$SUDO_USER" yay -S --noconfirm obs-v4l2sink || error "Fallo al instalar obs-v4l2sink"
    else
        echo -e "${YELLOW}⚠️ 'yay' no está instalado. Instala yay o paru para instalar obs-v4l2sink desde AUR.${RESET}"
    fi

elif [[ "$DISTRO" == "debian" ]]; then
    apt update && apt install -y obs-studio v4l2loopback-dkms v4l2loopback-utils || \
        error "No se pudieron instalar los paquetes necesarios"

    echo -e "${YELLOW}⚠️ Para obs-v4l2sink, compílalo desde: https://github.com/CatxFish/obs-v4l2sink${RESET}"
fi

# === Cargar módulo v4l2loopback ===
titulo "🔌 Cargando módulo v4l2loopback..."

modprobe v4l2loopback devices=1 video_nr=10 card_label="OBS Virtual Camera" exclusive_caps=1 || \
    error "No se pudo cargar el módulo v4l2loopback"

# === Configuración persistente del módulo (solo Arch y Debian) ===
titulo "📁 Configurando carga persistente de v4l2loopback..."

CONF_PATH="/etc/modprobe.d/v4l2loopback.conf"
cat > "$CONF_PATH" <<EOF
options v4l2loopback devices=1 video_nr=10 card_label="OBS Virtual Camera" exclusive_caps=1
EOF

echo v4l2loopback >> /etc/modules-load.d/obs.conf

exito "Módulo configurado para cargarse automáticamente al iniciar"

titulo "✅ OBS Studio y cámara virtual listos para usar"
