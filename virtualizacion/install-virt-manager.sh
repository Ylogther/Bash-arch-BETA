#!/bin/bash

#script: install-virt-manager.sh

# Salir si hay errores
set -e

echo "[+] Instalando virt-manager y dependencias..."
sudo pacman -Syu --noconfirm virt-manager qemu vde2 dnsmasq bridge-utils openbsd-netcat

echo "[+] Habilitando y arrancando libvirtd..."
sudo systemctl enable --now libvirtd

echo "[+] Añadiendo usuario actual al grupo libvirt..."
sudo usermod -aG libvirt "$USER"

echo "[+] Iniciando red NAT default..."
sudo virsh net-start default || echo "[!] Red ya iniciada"
sudo virsh net-autostart default

echo "[+] Instalación completa."
echo "🔁 Por favor, cierra sesión o reinicia para aplicar el grupo libvirt."
