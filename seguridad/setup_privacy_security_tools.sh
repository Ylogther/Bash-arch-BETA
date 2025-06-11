#!/bin/bash

# script: setup_privacy_security_tools.sh

set -euo pipefail

LOGFILE="install_log.txt"
exec > >(tee -i "$LOGFILE")
exec 2>&1

# ==== Colores ====
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

log_info()    { echo -e "${YELLOW}[*] $1${NC}"; }
log_success() { echo -e "${GREEN}[✓] $1${NC}"; }
log_error()   { echo -e "${RED}[✗] $1${NC}"; }

# ==== Dependencias básicas ====
log_info "Verificando dependencias críticas del sistema..."

for cmd in sudo pacman git curl ping; do
    if ! command -v "$cmd" &>/dev/null; then
        log_error "El comando '$cmd' es requerido y no está instalado. Abortando."
        exit 1
    fi
done

# ==== Verificar conexión ====
log_info "Verificando conexión a Internet..."
ping -c 1 archlinux.org &>/dev/null || {
    log_error "Sin conexión a Internet. Abortando."
    exit 1
}

# ==== ProtonVPN ====
instalar_protonvpn() {
    log_info "Instalando ProtonVPN desde Flatpak..."
    log_info "Tamaño estimado: descarga ~150 MB / instalado ~400 MB"

    if ! command -v flatpak &>/dev/null; then
        log_info "Flatpak no encontrado. Instalando..."
        sudo pacman -S --noconfirm flatpak
    fi

    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub com.protonvpn.www

    log_success "ProtonVPN instalado. Ejecuta con:"
    echo "    flatpak run com.protonvpn.www"
}

# ==== VeraCrypt ====
instalar_veracrypt() {
    log_info "Instalando VeraCrypt desde AUR..."
    log_info "Tamaño estimado: descarga ~25 MB / instalado ~70 MB"

    if ! command -v yay &>/dev/null; then
        log_info "yay no encontrado. Instalando..."
        sudo pacman -S --needed --noconfirm git base-devel
        git clone https://aur.archlinux.org/yay.git ~/yay
        cd ~/yay && makepkg -si --noconfirm
        cd ~ && rm -rf ~/yay
    fi

    yay -S --noconfirm veracrypt
    log_success "VeraCrypt instalado correctamente."
}

# ==== BlackArch Tools ====
instalar_blackarch_tools() {
    echo
    echo -e "${YELLOW}Categorías BlackArch disponibles:${NC}"
    echo " - blackarch-networking: descarga ~250 MB / instalado ~600 MB"
    echo " - blackarch-scanner:    descarga ~200 MB / instalado ~500 MB"
    echo " - blackarch-webapp:     descarga ~300 MB / instalado ~700 MB"
    echo

    read -rp "¿Deseas instalar estas herramientas? (s/n): " opt
    if [[ "${opt,,}" == "s" ]]; then
        log_info "Instalando herramientas BlackArch seleccionadas..."
        sudo pacman -S --noconfirm blackarch-networking blackarch-scanner blackarch-webapp
        log_success "BlackArch tools instaladas."
    else
        log_info "Omisión confirmada."
    fi
}

# ==== Limpieza ====
limpiar_cache() {
    log_info "Limpiando caché de paquetes AUR (yay)..."
    yay -Sc --noconfirm || true
}

# ==== Ejecución ====
log_info "Iniciando proceso de instalación..."

instalar_protonvpn
instalar_veracrypt
instalar_blackarch_tools
limpiar_cache

log_success "✅ Todos los componentes han sido instalados correctamente."
echo "📄 Consulta el log en: ${LOGFILE}"
