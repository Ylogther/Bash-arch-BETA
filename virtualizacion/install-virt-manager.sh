#!/bin/bash

# script: install-virt-manager.sh

set -euo pipefail

YELLOW='\e[33m'
GREEN='\e[32m'
RED='\e[31m'
RESET='\e[0m'

info()  { echo -e "${YELLOW}[INFO] $1${RESET}"; }
ok()    { echo -e "${GREEN}[OK] $1${RESET}"; }
warn()  { echo -e "${RED}[WARN] $1${RESET}"; }

info "Instalando virt-manager y dependencias..."
sudo pacman -Syu --noconfirm virt-manager qemu vde2 dnsmasq bridge-utils openbsd-netcat

info "Habilitando y arrancando libvirtd..."
sudo systemctl enable --now libvirtd

info "Añadiendo usuario '$USER' al grupo libvirt..."
if groups "$USER" | grep -qw libvirt; then
    warn "El usuario ya está en el grupo libvirt."
else
    sudo usermod -aG libvirt "$USER"
    ok "Usuario añadido al grupo libvirt."
fi

info "Verificando red NAT 'default'..."
if sudo virsh net-info default &>/dev/null; then
    sudo virsh net-start default || warn "La red ya estaba iniciada."
    sudo virsh net-autostart default
else
    warn "La red 'default' no existe. Puedes crearla manualmente si es necesario."
fi

ok "Instalación y configuración de virt-manager completadas."
echo -e "${YELLOW}🔁 Cierra sesión o reinicia para aplicar el cambio de grupo.${RESET}"
