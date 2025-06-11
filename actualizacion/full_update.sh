#!/bin/bash
# script: full_update.sh

set -euo pipefail

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔄 Iniciando actualización completa del sistema...${NC}"

command_exists() {
    command -v "$1" &> /dev/null
}

error_handler() {
    echo -e "${RED}❌ Error detectado. Abortando script.${NC}"
    exit 1
}

trap error_handler ERR

# --- 1. Actualización del sistema ---
echo -e "\n${YELLOW}1. 🔄 Buscando gestor de paquetes principal...${NC}"

if command_exists pacman; then
    echo -e "${GREEN}✔ Detectado 'pacman' (Arch Linux)${NC}"
    sudo pacman -Syu --noconfirm
elif command_exists apt; then
    echo -e "${GREEN}✔ Detectado 'apt' (Debian/Ubuntu)${NC}"
    sudo apt update && sudo apt upgrade -y
elif command_exists dnf; then
    echo -e "${GREEN}✔ Detectado 'dnf' (Fedora)${NC}"
    sudo dnf upgrade -y
elif command_exists zypper; then
    echo -e "${GREEN}✔ Detectado 'zypper' (openSUSE)${NC}"
    sudo zypper refresh && sudo zypper update -y
else
    echo -e "${RED}⚠ No se detectó un gestor de paquetes compatible.${NC}"
fi

# --- 2. Ayudantes AUR ---
echo -e "\n${YELLOW}2. 🔄 Buscando ayudantes de AUR...${NC}"

if command_exists paru; then
    echo -e "${GREEN}✔ Detectado 'paru'${NC}"
    paru -Syu --noconfirm
elif command_exists yay; then
    echo -e "${GREEN}✔ Detectado 'yay'${NC}"
    yay -Syu --noconfirm
else
    echo -e "${RED}⚠ No se encontró ningún ayudante de AUR.${NC}"
fi

# --- 3. Flatpak ---
if command_exists flatpak; then
    echo -e "\n${YELLOW}3. 🔄 Actualizando paquetes de Flatpak...${NC}"
    flatpak update -y
else
    echo -e "${RED}⚠ Flatpak no está instalado. Omitiendo.${NC}"
fi

# --- 4. Snap ---
if command_exists snap; then
    echo -e "\n${YELLOW}4. 🔄 Actualizando paquetes de Snap...${NC}"
    sudo snap refresh
else
    echo -e "${RED}⚠ Snap no está instalado. Omitiendo.${NC}"
fi

# --- 5. Pip ---
if command_exists pip || command_exists pip3; then
    PIP_CMD=$(command -v pip || command -v pip3)
    echo -e "\n${YELLOW}5. 🔄 Actualizando paquetes globales de pip...${NC}"
    $PIP_CMD list --outdated --format=freeze | cut -d '=' -f 1 | xargs -r -n1 $PIP_CMD install -U --user
else
    echo -e "${RED}⚠ pip no está instalado. Omitiendo.${NC}"
fi

# --- 6. npm ---
if command_exists npm; then
    echo -e "\n${YELLOW}6. 🔄 Actualizando paquetes globales de npm...${NC}"
    npm update -g
else
    echo -e "${RED}⚠ npm no está instalado. Omitiendo.${NC}"
fi

# --- 7. Limpieza ---
echo -e "\n${BLUE}🧹 Realizando limpieza post-actualización...${NC}"

if command_exists pacman; then
    echo -e "\n${YELLOW}a) 🗑️ Eliminando dependencias huérfanas...${NC}"
    ORPHANS=$(pacman -Qdtq 2>/dev/null || true)
    if [[ -n "${ORPHANS}" ]]; then
        sudo pacman -Rns --noconfirm ${ORPHANS}
    else
        echo -e "${GREEN}✔ No hay dependencias huérfanas.${NC}"
    fi
fi

if command_exists paru; then
    echo -e "\n${YELLOW}b) 🗑️ Limpiando caché de paru...${NC}"
    paru -Sc --noconfirm || true
elif command_exists yay; then
    echo -e "\n${YELLOW}b) 🗑️ Limpiando caché de yay...${NC}"
    yay -Sc --noconfirm || true
fi

if command_exists flatpak; then
    echo -e "\n${YELLOW}c) 🗑️ Eliminando flatpaks no utilizados...${NC}"
    flatpak uninstall --unused -y
fi

echo -e "\n${GREEN}✅ ¡Actualización y limpieza completadas con éxito!${NC}"
