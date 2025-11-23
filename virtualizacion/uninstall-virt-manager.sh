#!/bin/bash
# Script: uninstall-virt-manager.sh
# Descripción: Desinstala virt-manager, libvirt y dependencias relacionadas en Arch Linux

set -euo pipefail

echo "[!] Este script eliminará virt-manager, libvirt y configuraciones asociadas."
read -rp "¿Deseas continuar? (s/N): " confirm
if [[ ! "${confirm,,}" =~ ^s(í|i)?$ ]]; then
    echo "Cancelado."
    exit 0
fi

# Comprobación de instalación
if ! pacman -Qi virt-manager &>/dev/null; then
    echo "[=] virt-manager no está instalado. Continuando con limpieza..."
fi

echo "[+] Deteniendo y deshabilitando libvirtd.service (si está activo)..."
sudo systemctl disable --now libvirtd.service 2>/dev/null || echo "[=] libvirtd ya estaba detenido."

# Administrar redes solo si existe virsh
if command -v virsh &>/dev/null; then
    echo "[+] Deteniendo redes virtuales activas..."
    active_nets=$(sudo virsh net-list --name || true)
    for net in $active_nets; do
        [[ -n "$net" ]] && {
            echo "[+] Deteniendo red: $net"
            sudo virsh net-destroy "$net" || true
        }
    done

    echo "[+] Eliminando redes virtuales definidas..."
    defined_nets=$(sudo virsh net-list --name --all || true)
    for net in $defined_nets; do
        [[ -n "$net" ]] && {
            echo "[+] Eliminando red: $net"
            sudo virsh net-undefine "$net" || true
        }
    done
else
    echo "[=] virsh no está disponible; saltando gestión de redes."
fi

echo "[+] Desinstalando paquetes..."
sudo pacman -Rns --noconfirm virt-manager qemu vde2 dnsmasq bridge-utils openbsd-netcat || \
echo "[=] Algunos paquetes no estaban instalados."

echo "[?] ¿Eliminar imágenes de VM y configuraciones de libvirt? (Esto es irreversible) (s/N): "
read -r wipe
if [[ "${wipe,,}" =~ ^s(í|i)?$ ]]; then
    echo "[+] Eliminando directorios del sistema..."
    sudo rm -rf /var/lib/libvirt 2>/dev/null || true
    sudo rm -rf /etc/libvirt 2>/dev/null || true

    echo "[+] Eliminando configuraciones del usuario..."
    rm -rf "$HOME/.config/libvirt" "$HOME/.local/share/libvirt" "$HOME/.cache/libvirt" 2>/dev/null || true
else
    echo "[=] Configuraciones preservadas."
fi

echo "[+] Eliminando usuario del grupo libvirt..."
if getent group libvirt &>/dev/null; then
    sudo gpasswd -d "$USER" libvirt || echo "[=] El usuario no estaba en el grupo."
else
    echo "[=] El grupo libvirt no existe."
fi

# Opción para borrar el grupo si queda obsoleto
if getent group libvirt &>/dev/null; then
    if [[ -z "$(getent group libvirt | cut -d: -f4)" ]]; then
        read -rp "[?] El grupo 'libvirt' quedó vacío. ¿Eliminarlo? (s/N): " delgrp
        if [[ "${delgrp,,}" =~ ^s(í|i)?$ ]]; then
            sudo groupdel libvirt
            echo "[+] Grupo libvirt eliminado."
        fi
    fi
fi

echo "[✔] Desinstalación completa."
echo "🔁 Reinicia o cierra sesión para aplicar los cambios de grupo."
