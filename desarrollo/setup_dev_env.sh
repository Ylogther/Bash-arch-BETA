#!/bin/bash

# script: setup_dev_env.sh
# Prepara entorno de desarrollo C, C++ y Java

set -euo pipefail

echo "💻 Instalando compiladores y herramientas base para C, C++ y Java..."

# === Función auxiliar ===
command_exists() {
    command -v "$1" &> /dev/null
}

# === Instalación por distribución ===
if command_exists pacman; then
    echo "📦 Usando pacman (Arch Linux)"
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm base-devel gcc clang cmake java-environment-openjdk
elif command_exists apt; then
    echo "📦 Usando apt (Debian/Ubuntu)"
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y build-essential gcc clang cmake openjdk-17-jdk
else
    echo "❌ Gestor de paquetes no soportado."
    exit 1
fi

echo "✅ Compiladores y herramientas instalados."

# === VSCode (opcional) ===
echo "🧠 Instalando VSCode (opcional)..."

if ! command_exists code; then
    if command_exists pacman; then
        echo "📥 Instalando VSCode desde repositorio community..."
        sudo pacman -S --noconfirm code
    elif command_exists snap; then
        echo "📥 Instalando VSCode vía snap..."
        sudo snap install code --classic
    elif command_exists apt; then
        echo "📥 Descargando e instalando VSCode .deb..."
        TMP_DEB=$(mktemp) 
        wget -qO "$TMP_DEB" https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
        sudo apt install -y "$TMP_DEB"
        rm -f "$TMP_DEB"
    else
        echo "⚠️ No se pudo instalar VSCode automáticamente. Instálalo manualmente si lo deseas."
    fi
else
    echo "✔ VSCode ya está instalado."
fi

# === Final ===
echo "🎯 Entorno de desarrollo listo."
echo "Puedes compilar C/C++ con gcc/clang y Java con javac."
