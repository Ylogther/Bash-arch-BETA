#!/bin/bash

# script: cambio_mac.sh

set -euo pipefail

# === Configuración de colores ===
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# === Variables ===
INTERFACE="wlan0"
DEFAULT_MAC="12:34:56:78:9a:bc"

# === Función para validar formato MAC ===
valid_mac() {
    [[ $1 =~ ^([0-9A-Fa-f]{2}:){5}([0-9A-Fa-f]{2})$ ]]
}

# === Requiere root ===
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Este script debe ejecutarse como root. Usa: sudo $0${NC}"
    exit 1
fi

# === Verificar interfaz ===
if ! ip link show "$INTERFACE" &> /dev/null; then
    echo -e "${RED}Error: La interfaz '$INTERFACE' no existe.${NC}"
    ip link show | awk -F: '/^[0-9]+: / { print " - " $2 }'
    exit 1
fi

# === Verificar macchanger ===
if ! command -v macchanger &>/dev/null; then
    echo -e "${RED}Error: 'macchanger' no está instalado.${NC}"
    exit 1
fi

# === Pregunta al usuario ===
echo -e "${YELLOW}¿Quieres usar la MAC predeterminada [$DEFAULT_MAC]? (s/n):${NC} "
read -r usar_predeterminada

if [[ "$usar_predeterminada" =~ ^[sS]$ ]]; then
    MAC_TO_USE="$DEFAULT_MAC"
else
    read -rp "🔧 Ingresa la MAC personalizada (formato XX:XX:XX:XX:XX:XX): " input_mac
    if valid_mac "$input_mac"; then
        MAC_TO_USE="$input_mac"
    else
        echo -e "${RED}Error: Formato de MAC inválido.${NC}"
        exit 1
    fi
fi

# === Cambio de MAC ===
echo -e "${YELLOW}🔽 Bajando interfaz $INTERFACE...${NC}"
ip link set "$INTERFACE" down

echo -e "${YELLOW}🎨 Cambiando MAC a $MAC_TO_USE ...${NC}"
macchanger -m "$MAC_TO_USE" "$INTERFACE"

echo -e "${YELLOW}🔼 Subiendo interfaz $INTERFACE...${NC}"
ip link set "$INTERFACE" up

# === Mostrar resultado ===
CURRENT_MAC=$(ip link show "$INTERFACE" | grep -oE 'ether ([0-9a-f:]{17})' | awk '{print $2}')

echo -e "${GREEN}✔ MAC actual: $CURRENT_MAC${NC}"
