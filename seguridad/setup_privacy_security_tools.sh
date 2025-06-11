#!/bin/bash

#script: setup_privacy_security_tools.sh

set -euo pipefail

LOGFILE="install_log.txt"
exec > >(tee -i "$LOGFILE")
exec 2>&1

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info()    { echo -e "${YELLOW}[*] $1${NC}"; }
log_success() { echo -e "${GREEN}[✓] $1${NC}"; }

# Verificar dependencias básicas
log_info "Verificando dependencias críticas del sistema..."

for cmd in sudo pacman git curl ping; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "[-] El comando '$cmd' es requerido y no está instalado. Abortando."
        exit 1
    fi
done

# Verificar conexión a internet
log_info "Verificando conexión a Internet..."
ping -c 1 archlinux.org &>/dev/null || {
    echo "[-] No tienes conexión a Internet. Abortando."
    exit 1
}

instalar_protonvpn() {
    log_info "Instalando ProtonVPN (GUI) desde Flatpak..."
    log_info "Tamaño aproximado de descarga: ~150 MB"
    log_info "Tamaño aproximado instalado: ~400 MB"

    if ! command -v flatpak &>/dev/null; then
        log_info "Flatpak no encontrado. Instalando..."
        sudo pacman -S --noconfirm flatpak
    fi

    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub com.protonvpn.www

    log_success "ProtonVPN instalado correctamente. Puedes ejecutarlo con:"
    echo "    flatpak run com.protonvpn.www"
}

instalar_veracrypt() {
    log_info "Instalando VeraCrypt desde AUR..."
    log_info "Tamaño aproximado de descarga: ~25 MB"
    log_info "Tamaño aproximado instalado: ~70 MB"

    if ! command -v yay &>/dev/null; then
        log_info "'yay' no encontrado. Instalando..."
        cd ~
        sudo pacman -S --needed --noconfirm git base-devel
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
    fi

    yay -S --noconfirm veracrypt
    log_success "VeraCrypt instalado correctamente."
}

instalar_blackarch_tools() {
    echo
    echo -e "${YELLOW}Información de tamaños aproximados para las categorías BlackArch:${NC}"
    echo " - blackarch-networking: descarga ~250 MB / instalado ~600 MB"
    echo " - blackarch-scanner:    descarga ~200 MB / instalado ~500 MB"
    echo " - blackarch-webapp:     descarga ~300 MB / instalado ~700 MB"
    echo

    read -p "¿Quieres instalar herramientas útiles de BlackArch (networking, scanner, webapp)? (s/n): " opt
    if [[ "$opt" == "s" || "$opt" == "S" ]]; then
        log_info "Instalando herramientas de BlackArch..."
        sudo pacman -S --noconfirm blackarch-networking blackarch-scanner blackarch-webapp
        log_success "Herramientas de BlackArch instaladas."
    else
        log_info "Omisión de herramientas BlackArch."
    fi
}

limpiar_cache() {
    log_info "Limpiando caché de paquetes AUR..."
    yay -Sc --noconfirm || true
}

log_info "Iniciando instalación completa..."

instalar_protonvpn
instalar_veracrypt
instalar_blackarch_tools
limpiar_cache

log_success "✅ Todos los componentes fueron instalados correctamente."
echo "📄 Revisa el log en: $LOGFILE"
