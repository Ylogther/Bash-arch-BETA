# 🎛️ Bash-Arch (BETA) – Scripts para Arch Linux con Hyprland, Gaming, Multimedia y Seguridad

**Versión**: 6.0.0-beta | **Licencia**: MIT

<p align="left">
  <img src="https://img.shields.io/badge/estado-beta--inestable-yellow" alt="Estado: Beta" />
  <img src="https://img.shields.io/github/license/Ylogther/bash-arch-BETA?color=blue" alt="Licencia: MIT" />
</p>

🔧 Herramienta avanzada para automatizar instalaciones, configuraciones y mantenimiento en Arch Linux.
Optimizada para entornos con Hyprland, gaming, multimedia, ciberseguridad y desarrollo.

**⚠️ Proyecto en estado BETA: puede contener errores o configuraciones inestables.**

🧭 Elige tu versión

🔹 Versión Estable
Te recomendamos esta versión si buscas estabilidad, confiabilidad y una experiencia sin errores. Ideal para uso diario o en entornos de trabajo.           
:https://github.com/Ylogther/bash-arch

🔸 Versión Beta/Inestable
Perfecta si quieres probar las últimas funciones, mejoras experimentales y cambios recientes. ⚠️ Puede contener errores, pero es ideal para testers y usuarios curiosos.
:https://github.com/Ylogther/bash-arch-BETA

🎯 Te recomendamos entrar a la versión estable si quieres algo que no te provoque errores. Pero si quieres probar las últimas actualizaciones, entonces juega con esta versión.

> 🚀 Enfocado en usuarios avanzados, testers, desarrolladores y entornos de pruebas.

---

## 📚 Tabla de contenidos

* [🧰 Características principales](#-características-principales)
* [📂 Estructura del repositorio](#-estructura-del-repositorio)
* [🚀 Instalación rápida](#-instalación-rápida)
* [🧪 Script maestro (opcional)](#-script-maestro-opcional)
* [💡 Ejemplos de uso](#-ejemplos-de-uso)
* [🧑‍💻 Requisitos](#-requisitos)
* [⚠️ Aviso de uso](#️-aviso-de-uso)
* [📖 Licencia](#-licencia)
* [🤝 Contribuciones](#-contribuciones)
* [🎥 Proyecto mantenido por](#-proyecto-mantenido-por)

---

## 🧰 Características principales

* ⚙️ Instalación modular y automatizada de herramientas clave.
* 🖥️ Soporte de Hyprland + gaming + multimedia.
* 🔐 Scripts para ciberseguridad, virtualización y privacidad.
* 🔄 Mantenimiento completo (actualización, limpieza, backups).
* 🧪 Scripts experimentales y en pruebas.
* 📦 Compatibilidad con drivers Intel, AMD y NVIDIA.

---

## 📂 Estructura del repositorio

```bash
bash-arch/
├── actualizacion/                    # Scripts para mantener Arch actualizado correctamente
│   └── full_update.sh               # Realiza una actualización completa: sistema + AUR + limpieza
├── desarrollo/                      # Herramientas esenciales para entornos de desarrollo
│   ├── README.md                    # Explicación de los scripts de desarrollo
│   ├── instalar_blackarch.sh        # Añade y sincroniza el repositorio BlackArch para pentesting
│   ├── install_devtools.sh          # Instala base-devel y herramientas de desarrollo estándar
│   ├── ml4w_install.sh              # Instala dotfiles avanzados "MyLinuxForWork" para Hyprland
│   └── setup_dev_env.sh             # Automatiza configuración de entorno dev general (git, zsh, etc.)
├── gaming/                          # Scripts para optimizar el sistema para juegos
│   ├── README.md                    # Detalles sobre configuraciones gaming incluidas
│   ├── drivers_install.sh           # Instala automáticamente drivers NVIDIA, AMD o Intel según hardware
│   ├── instalacion-gaming.sh        # Aplica ajustes y paquetes extra para gaming (gamemode, mangohud, etc.)
│   └── mas/                         # Scripts adicionales específicos para juegos
│       └── Minecraft-install.sh     # Instala el launcher oficial de Minecraft desde el AUR
├── icons/                           # Temas de iconos listos para ser instalados
│   ├── Orbian-Ultradark.zip         # Tema para mouse
│   └── Vivid-Dark-Icons.tar.gz      # Tema para iconos
├── multimedia/                      # Setup para edición de video, OBS y multimedia en general
│   ├── README.md                    # Información general de esta sección
│   ├── davinci_resolve_deps.sh     # Instala las dependencias que requiere DaVinci Resolve en Arch
│   ├── multimedia_install.sh        # Instala paquetes de edición, audio y video (Kdenlive, Audacity, etc.)
│   ├── streaming_install.sh         # Instala OBS Studio y plugins útiles para streamers
│   └── solucion abrir davinci resolve/
│       └── d.sh                     # Fix específico para errores comunes al lanzar DaVinci
├── seguridad/                       # Scripts de privacidad, seguridad y protección de red
│   ├── README.md                    # Detalla herramientas y scripts de esta categoría
│   ├── cambio_mac.sh                # Cambia la dirección MAC aleatoriamente o manualmente
│   ├── firewall_fail2ban.sh         # Configura un firewall simple y activa fail2ban
│   ├── install_log.txt              # Registro de instalaciones hechas (útil para auditoría)
│   └── setup_privacy_security_tools.sh  # Instala herramientas como Tor, ufw, dnscrypt, etc.
├── solucion_problema_wifi/          # Diagnóstico y solución a desconexiones Wi-Fi en Arch
│   ├── README.md                    # Explicación del enfoque de solución
│   └── wifi_watchdog.sh             # Script watchdog: reinicia Wi-Fi si detecta caída de red
├── utilidades/                      # Scripts que no encajan en una categoría específica
│   └── install_yay.sh               # Instala yay desde el AUR de forma segura y limpia
├── virtualizacion/                  # Herramientas para virtualización con virt-manager y QEMU
│   ├── README.md                    # Detalla cómo usar los scripts de esta carpeta
│   └── install-virt-manager.sh      # Instala virt-manager, QEMU y configura libvirtd correctamente
├── LICENSE                          # Licencia GPLv3 para todo el proyecto
├── README.md                        # Introducción, instrucciones y diagrama del repositorio
├── aparte_por_si_no_tengo_x11.txt  # Notas 
├── dato_para_juego.txt             # Dato técnico para ver rendimiento de un juego
└── subirgithub.sh                  # Script para hacer push automático del proyecto a GitHub


```

---

## 🚀 Instalación rápida

```bash
git clone https://github.com/Ylogther/bash-arch.git
cd bash-arch
chmod +x */*.sh
```

---

## 🧪 Script maestro (opcional)

```bash
chmod +x install.sh
sudo ./install.sh
```

Ejecuta los módulos principales en secuencia controlada.
**⚠️ BETA: puede cambiar entre versiones.**

---

## 💡 Ejemplos de uso

```bash
# Instalar yay (AUR helper)
bash utilidades/install_yay.sh

# Instalar herramientas de desarrollo
bash desarrollo/install_devtools.sh

# Configurar entorno Hyprland personalizado
bash desarrollo/ml4w_install.sh

# Instalar OBS Studio y plugins
bash multimedia/streaming_install.sh

# Activar firewall + fail2ban
bash seguridad/firewall_fail2ban.sh

# Corregir DaVinci Resolve
bash multimedia/solucion\ abrir\ davinci\ resolve/d.sh
```

---

## 🧑‍💻 Requisitos

* Arch Linux o derivada
* Internet estable
* Acceso a `sudo`
* Conocimiento básico de bash

---

## ⚠️ Aviso de uso

Este proyecto está en desarrollo activo y contiene scripts experimentales.
No se recomienda para entornos productivos.
Revisa cada script antes de ejecutarlo y usa máquinas virtuales para pruebas cuando sea posible.

---

## 📖 Licencia

Este proyecto se distribuye bajo la **Licencia MIT**.

> Puedes usar, modificar y redistribuir el código con atribución.
> El software se proporciona "tal cual", sin garantías de ningún tipo.
> Consulta el archivo [`LICENSE`](LICENSE) para más información.

---

## 🤝 Contribuciones

Se aceptan mejoras y reportes. Para contribuir:

1. Verifica los scripts con `shellcheck`
2. Usa `chmod +x` donde sea necesario
3. Agrega comentarios claros al código
4. Evita dependencias innecesarias

---

## 🎥 Proyecto mantenido por

**Ylogther**
🧠 Hacker ético | 🛠️ Desarrollador multimedia y web
