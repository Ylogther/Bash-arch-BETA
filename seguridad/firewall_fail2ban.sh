#!/bin/bash

# script: firewall_fail2ban.sh

set -euo pipefail

echo "🚧 Instalando y configurando firewall + Fail2Ban..."

# === Detectar distribución y gestor de paquetes ===
if command -v pacman &>/dev/null; then
    PM_INSTALL="sudo pacman -S --noconfirm"
elif command -v apt &>/dev/null; then
    sudo apt update
    PM_INSTALL="sudo apt install -y"
else
    echo "⚠️ No se detectó gestor de paquetes compatible (pacman o apt)."
    exit 1
fi

# === Instalar UFW y Fail2Ban ===
echo "📦 Instalando ufw y fail2ban..."
$PM_INSTALL ufw fail2ban

# === Configurar UFW ===
echo "🧱 Configurando reglas de firewall..."
sudo systemctl enable --now ufw

sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh

if ! sudo ufw enable; then
    echo "❌ Error al habilitar UFW"
    exit 1
fi

echo "✔ Firewall UFW habilitado con configuración básica segura."

# === Activar Fail2Ban ===
echo "🔒 Activando fail2ban..."
sudo systemctl enable --now fail2ban

# === Verificación final ===
echo "📋 Estado de los servicios:"
echo " 🔹 UFW: $(sudo ufw status | grep Status)"
echo " 🔹 Fail2Ban: $(systemctl is-active fail2ban)"

echo "✅ Seguridad básica activa (UFW + Fail2Ban)."
