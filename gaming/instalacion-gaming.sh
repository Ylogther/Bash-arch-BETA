#!/bin/bash

# script: instalacion-gaming.sh

set -euo pipefail

# === Colores ===
GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
RESET='\e[0m'

titulo() { echo -e "\n${YELLOW}=== $1 ===${RESET}"; }
error()  { echo -e "${RED}✖ $1${RESET}"; exit 1; }

# === Verificación de permisos ===
[[ $EUID -ne 0 ]] && error "Este script debe ejecutarse como root. Usa 'sudo ./nombre.sh'"

# === Activar [multilib] ===
PACMAN_CONF="/etc/pacman.conf"
titulo "Verificando repositorio multilib en $PACMAN_CONF"

if grep -q "^\s*#\s*\[multilib\]" "$PACMAN_CONF"; then
    echo "Repositorio [multilib] está comentado. Activando..."
    sed -i '/^\s*#\s*\[multilib\]/s/^#//' "$PACMAN_CONF"
    sed -i '/^\s*#\s*Include = \/etc\/pacman.d\/mirrorlist/s/^#//' "$PACMAN_CONF"
    echo -e "${GREEN}[multilib] activado.${RESET}"
    pacman -Sy --noconfirm
elif grep -q "^\s*\[multilib\]" "$PACMAN_CONF"; then
    echo -e "${GREEN}[multilib] ya está activado.${RESET}"
else
    error "Repositorio [multilib] no encontrado."
fi

# === Actualizar sistema ===
titulo "Actualizando el sistema"
pacman -Syu --noconfirm || error "Fallo al actualizar"

# === Detección de GPU ===
titulo "Detectando GPU..."
lspci | grep -Ei 'vga|3d|display' || echo -e "${YELLOW}No se detectó GPU.${RESET}"

HAS_NVIDIA=$(lspci | grep -qi 'NVIDIA' && echo 1 || echo 0)
HAS_INTEL=$(lspci | grep -Eqi 'Intel.*(UHD|HD Graphics)' && echo 1 || echo 0)
HAS_AMD=$(lspci | grep -Eqi 'AMD|ATI|Radeon' && echo 1 || echo 0)

echo -e "NVIDIA: $HAS_NVIDIA\nIntel: $HAS_INTEL\nAMD: $HAS_AMD"

# === Drivers ===
[[ $HAS_INTEL -eq 1 ]] && titulo "Instalando drivers Intel" && \
pacman -S --noconfirm mesa libva-intel-driver libva-utils vulkan-intel vulkan-tools

[[ $HAS_AMD -eq 1 ]] && titulo "Instalando drivers AMD" && \
pacman -S --noconfirm mesa xf86-video-amdgpu vulkan-radeon vulkan-tools

if [[ $HAS_NVIDIA -eq 1 ]]; then
    titulo "Instalando drivers NVIDIA propietarios"
    pacman -S --noconfirm nvidia nvidia-utils nvidia-settings nvidia-prime
    systemctl enable --now nvidia-persistenced.service || true
fi

# === Wine + Steam + Lutris ===
titulo "Instalando Wine, Steam y Lutris"
pacman -S --noconfirm wine winetricks steam steam-native-runtime lutris

# === Flatpak y apps ===
titulo "Instalando Flatpak + Heroic Games Launcher"
pacman -S --noconfirm flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y --noninteractive flathub com.heroicgameslauncher.hgl
flatpak install -y --noninteractive flathub net.davidotek.pupgui2  # ProtonUp-QT

# === MangoHUD, GOverlay, GameMode ===
titulo "Instalando herramientas de monitoreo y optimización"
pacman -S --noconfirm mangohud goverlay gamemode

# === PipeWire ===
titulo "Instalando servidor de audio PipeWire"
pacman -S --noconfirm pipewire pipewire-audio pipewire-alsa pipewire-pulse wireplumber

# === Gamepad support ===
titulo "Instalando soporte para mandos de juego"
pacman -S --noconfirm game-devices-udev

titulo "🎮 Entorno gaming completo instalado"
echo -e "${GREEN}🔁 Reinicia tu sistema para aplicar todos los cambios.${RESET}"
