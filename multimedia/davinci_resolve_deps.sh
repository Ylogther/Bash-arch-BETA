#!/bin/bash

# script: davinci_resolve_deps.sh

set -euo pipefail

# ==== Colores ====
GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
BLUE='\e[34m'
RESET='\e[0m'

titulo() { echo -e "\n${YELLOW}===> $1${RESET}"; }
info()   { echo -e "${BLUE}ℹ $1${RESET}"; }
error()  { echo -e "${RED}✖ $1${RESET}"; exit 1; }

# ==== Comprobación de root ====
[[ $EUID -ne 0 ]] && error "Este script debe ejecutarse como root (usa sudo)"

titulo "🎬 Instalación de dependencias para DaVinci Resolve en Arch Linux"

# ==== Detección automática de GPU ====
HAS_NVIDIA=$(lspci | grep -qi "NVIDIA" && echo 1 || echo 0)
HAS_INTEL=$(lspci | grep -qi "Intel.*Graphics" && echo 1 || echo 0)

# ==== 1. Dependencias base ====
titulo "📦 Instalando dependencias esenciales..."
pacman -S --noconfirm libxcrypt-compat ocl-icd || error "Error instalando dependencias base"

# ==== 2. NVIDIA ====
if [[ $HAS_NVIDIA -eq 1 ]]; then
    titulo "🟢 Instalando soporte para NVIDIA propietario"
    pacman -S --noconfirm nvidia nvidia-utils opencl-nvidia || error "Error con soporte NVIDIA"
    if lsmod | grep -q nouveau; then
        error "El módulo 'nouveau' está cargado. Debes desactivarlo para usar los drivers propietarios."
    fi
else
    info "No se detectó GPU NVIDIA. Saltando soporte propietario."
fi

# ==== 3. Intel (opcional) ====
if [[ $HAS_INTEL -eq 1 ]]; then
    titulo "🔵 Instalando soporte para Intel iGPU"
    pacman -S --noconfirm intel-media-driver intel-compute-runtime opencl-intel || \
        info "Fallo en drivers Intel, pero no son obligatorios si no usas iGPU"
else
    info "No se detectó GPU Intel. Saltando."
fi

# ==== 4. Activar systemd-resolved ====
titulo "🔧 Configurando systemd-resolved"
systemctl enable --now systemd-resolved || error "No se pudo habilitar systemd-resolved"
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf || error "No se pudo configurar /etc/resolv.conf"

# ==== 5. clinfo ====
titulo "🧪 Verificando disponibilidad de OpenCL y GPU"
if ! command -v clinfo &>/dev/null; then
    info "Instalando clinfo..."
    pacman -S --noconfirm clinfo || error "Error instalando clinfo"
fi

info "📋 Resumen de clinfo:"
if ! clinfo | grep -q "Device"; then
    error "clinfo no detecta dispositivos OpenCL. Verifica tus drivers."
else
    clinfo | grep -E "Device|Platform Name|Vendor"
fi

titulo "✅ Configuración completa. Ejecuta ahora el instalador .run de DaVinci Resolve"
