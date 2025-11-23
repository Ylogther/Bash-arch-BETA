#!/bin/bash

# script-beta: Minecraft-install.sh

set -euo pipefail

GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
RESET='\e[0m'

info()  { echo -e "${YELLOW}[INFO] $1${RESET}"; }
ok()    { echo -e "${GREEN}[OK] $1${RESET}"; }
error() { echo -e "${RED}[ERROR] $1${RESET}"; }

info "Instalando Minecraft Launcher oficial desde el AUR..."

# Verifica sistema Arch
if ! command -v pacman &>/dev/null; then
    error "Este script solo funciona en Arch Linux o derivados."
    exit 1
fi

# Verifica git
if ! command -v git &>/dev/null; then
    info "Git no encontrado. Instalando..."
    sudo pacman -S --noconfirm git
fi

# Verifica base-devel
if ! pacman -Qq base-devel &>/dev/null; then
    info "Instalando grupo base-devel..."
    sudo pacman -S --noconfirm base-devel
fi

# Clonar AUR en temp
TMPDIR=$(mktemp -d)
info "Clonando AUR en: $TMPDIR"
cd "$TMPDIR"

git clone https://aur.archlinux.org/minecraft-launcher.git || {
    error "Fallo al clonar el repositorio AUR."
    exit 1
}

cd minecraft-launcher

info "Compilando e instalando el launcher..."
makepkg -si --noconfirm || {
    error "Error al compilar el paquete."
    exit 1
}

# Limpieza
cd ~
rm -rf "$TMPDIR"

ok "Minecraft Launcher oficial instalado correctamente."
info "Ejecuta con:${GREEN} minecraft-launcher"
