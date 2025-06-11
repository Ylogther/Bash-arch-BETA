#!/bin/bash

# script: drivers_install.sh
# Instala drivers gráficos para Arch Linux

set -euo pipefail

# === Colores ===
GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
CYAN='\e[36m'
RESET='\e[0m'

# === Funciones ===
titulo()   { echo -e "\n${YELLOW}==> $1${RESET}"; }
error()    { echo -e "${RED}✖ $1${RESET}"; exit 1; }
ok()       { echo -e "${GREEN}✔ $1${RESET}"; }

# === Verificación de permisos ===
[[ $EUID -ne 0 ]] && error "Este script debe ejecutarse como root. Usa: sudo ./drivers_install.sh"

# === Verificación de sistema ===
command -v pacman &>/dev/null || error "Este script está diseñado solo para Arch Linux o derivados."

titulo "Actualizando el sistema"
pacman -Syu --noconfirm || error "Fallo al actualizar el sistema."

# === Detectar GPU ===
titulo "Detectando GPU..."
GPU_INFO=$(lspci | grep -Ei 'vga|3d|display')
echo -e "${CYAN}$GPU_INFO${RESET}"

USE_INTEL=false
USE_NVIDIA=false
USE_AMD=false

if echo "$GPU_INFO" | grep -qi 'Intel'; then
    USE_INTEL=true
fi
if echo "$GPU_INFO" | grep -qi 'NVIDIA'; then
    USE_NVIDIA=true
fi
if echo "$GPU_INFO" | grep -Eqi 'AMD|Radeon'; then
    USE_AMD=true
fi

# === Instalación según tipo de GPU ===

if $USE_INTEL; then
    titulo "Instalando drivers Intel"
    pacman -S --noconfirm \
        mesa libva-intel-driver libva-utils \
        vulkan-intel vulkan-icd-loader vulkan-tools \
        || error "Falló la instalación de drivers Intel"
    ok "Drivers Intel instalados correctamente"
fi

if $USE_NVIDIA; then
    titulo "Instalando drivers NVIDIA propietarios"
    pacman -S --noconfirm \
        nvidia nvidia-utils nvidia-settings nvidia-prime \
        || error "Falló la instalación de drivers NVIDIA"
    systemctl enable --now nvidia-persistenced.service
    ok "Drivers NVIDIA instalados y servicio activado"
fi

if $USE_AMD; then
    titulo "Instalando drivers AMD (Radeon)"
    pacman -S --noconfirm \
        mesa xf86-video-amdgpu vulkan-radeon libva-mesa-driver \
        || error "Falló la instalación de drivers AMD"
    ok "Drivers AMD instalados correctamente"
fi

titulo "🎉 Instalación de drivers completada"
echo -e "${GREEN}🔁 Reinicia tu sistema para aplicar los cambios.${RESET}"
