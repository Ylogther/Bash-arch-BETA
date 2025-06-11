#!/bin/bash

# script: install_devtools.sh
# Instalación modular de herramientas para desarrollo web, backend y devops.

set -euo pipefail

echo "🔧 Iniciando instalación de herramientas de desarrollo..."

command_exists() {
    command -v "$1" &> /dev/null
}

install_with_pacman() {
    echo "📦 Usando pacman (Arch Linux)"
    sudo pacman -Syu --noconfirm

    echo "🧱 Instalando herramientas base..."
    sudo pacman -S --noconfirm git base-devel neovim unzip zip wget curl make

    echo "🌐 Frontend & Web..."
    sudo pacman -S --noconfirm nodejs npm code

    echo "☕ Backend y lenguajes..."
    sudo pacman -S --noconfirm python python-pip jdk-openjdk jre-openjdk gcc g++ cmake clang rust go

    echo "🛢️ Bases de datos..."
    sudo pacman -S --noconfirm sqlite postgresql mariadb

    echo "🐳 DevOps..."
    sudo pacman -S --noconfirm docker docker-compose
}

install_with_apt() {
    echo "📦 Usando apt (Debian/Ubuntu)"
    sudo apt update && sudo apt upgrade -y

    echo "🧱 Instalando herramientas base..."
    sudo apt install -y build-essential git neovim unzip zip wget curl make

    echo "🌐 Frontend & Web..."
    sudo apt install -y nodejs npm code

    echo "☕ Backend y lenguajes..."
    sudo apt install -y python3 python3-pip openjdk-17-jdk gcc g++ cmake clang rustc golang

    echo "🛢️ Bases de datos..."
    sudo apt install -y sqlite3 postgresql mariadb-server

    echo "🐳 DevOps..."
    sudo apt install -y docker.io docker-compose
}

install_with_dnf() {
    echo "📦 Usando dnf (Fedora)"
    sudo dnf upgrade -y

    echo "🧱 Instalando herramientas base..."
    sudo dnf install -y git @development-tools neovim unzip zip wget curl make

    echo "🌐 Frontend & Web..."
    sudo dnf install -y nodejs npm code

    echo "☕ Backend y lenguajes..."
    sudo dnf install -y python3 python3-pip java-17-openjdk java-17-openjdk-devel gcc gcc-c++ cmake clang rust golang

    echo "🛢️ Bases de datos..."
    sudo dnf install -y sqlite postgresql mariadb

    echo "🐳 DevOps..."
    sudo dnf install -y docker docker-compose
}

configure_docker() {
    if command_exists docker; then
        echo "⚙️ Configurando Docker..."
        sudo systemctl enable --now docker
        sudo usermod -aG docker "$USER"
    fi
}

# === Selección según distro ===
if command_exists pacman; then
    install_with_pacman
elif command_exists apt; then
    install_with_apt
elif command_exists dnf; then
    install_with_dnf
else
    echo "❌ Gestor de paquetes no compatible o no detectado."
    exit 1
fi

configure_docker

# === Verificaciones finales ===
echo -e "\n🔎 Verificaciones rápidas:"
for bin in git node npm python code docker; do
    if command_exists "$bin"; then
        echo "✔ $bin instalado en: $(command -v $bin)"
    else
        echo "❌ $bin no se encuentra en PATH"
    fi
done

echo -e "\n✅ Instalación finalizada correctamente."
echo "ℹ️ Si configuraste Docker, reinicia sesión para aplicar el grupo docker."
