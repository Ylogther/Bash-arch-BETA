#!/bin/bash

# script: install_yay.sh

set -e

GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
RESET='\e[0m'

echo -e "${YELLOW}==> Instalando yay (AUR helper)...${RESET}"

# Verificar que pacman y git estén disponibles
if ! command -v pacman &> /dev/null; then
    echo -e "${RED}Error: pacman no encontrado. Este script es solo para Arch Linux.${RESET}"
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}Git no encontrado. Instalando git...${RESET}"
    sudo pacman -S --noconfirm git
fi

# Verificar instalación de base-devel (paquete esencial para makepkg)
missing_pkgs=()
for pkg in binutils fakeroot gcc make pkgconf; do
    pacman -Q $pkg &>/dev/null || missing_pkgs+=("$pkg")
done

if [[ ${#missing_pkgs[@]} -gt 0 ]]; then
    echo -e "${YELLOW}Instalando paquetes base-devel faltantes: ${missing_pkgs[*]}...${RESET}"
    sudo pacman -S --noconfirm "${missing_pkgs[@]}"
fi

# Crear directorio temporal
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo -e "${YELLOW}Clonando yay en $TMPDIR...${RESET}"
cd "$TMPDIR"
git clone https://aur.archlinux.org/yay.git
cd yay

echo -e "${YELLOW}Compilando e instalando yay...${RESET}"
makepkg -si --noconfirm

echo -e "${GREEN}✓ yay instalado correctamente.${RESET}"

