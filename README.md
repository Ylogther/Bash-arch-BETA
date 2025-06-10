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
├── actualizacion/                 # Scripts para actualizar el sistema
│   └── full_update.sh             # Actualización completa del sistema
├── desarrollo/                   # Herramientas y setups para desarrollo
│   ├── README.md                 # Información general sobre scripts de desarrollo
│   ├── instalar_blackarch.sh     # Instalación del repositorio BlackArch
│   ├── install_devtools.sh       # Instalación de herramientas de desarrollo (base-devel, etc.)
│   ├── ml4w_install.sh           # Instalación de ML4W (dotfiles de alto nivel)
│   └── setup_dev_env.sh          # Configuración completa del entorno de desarrollo
├── gaming/                      # Scripts para optimizar y preparar el entorno gaming
│   ├── README.md                 # Información sobre configuraciones y optimizaciones gaming
│   ├── drivers_install.sh        # Instalación de drivers (NVIDIA, Intel, AMD, etc.)
│   ├── instalacion-gaming.sh     # Configuraciones adicionales para entorno gaming
│   └── mas/                      # Extras específicos para gaming
│       └── Minecraft-install.sh  # Instalación automática y optimizada de Minecraft
├── icons/                       # Paquetes de iconos personalizados para el sistema
│   ├── Orbian-Ultradark.zip      # Tema de iconos Orbian Ultradark (ZIP)
│   └── Vivid-Dark-Icons.tar.gz   # Tema de iconos Vivid Dark (TAR.GZ)
├── multimedia/                  # Instalación de programas multimedia y streaming
│   ├── README.md                 # Información general sobre multimedia
│   ├── davinci_resolve_deps.sh  # Instalación de dependencias para DaVinci Resolve
│   ├── multimedia_install.sh     # Instalación de herramientas multimedia generales
│   ├── streaming_install.sh      # Instalación y configuración de OBS y sus plugins
│   └── solucion abrir davinci resolve/  # Fixes específicos para problemas al abrir DaVinci Resolve
│       └── d.sh                 # Script de solución directa para errores de arranque
├── seguridad/                   # Scripts orientados a privacidad, seguridad y red
│   ├── README.md                         # Información general sobre herramientas de seguridad
│   ├── cambio_mac.sh                    # Cambio de dirección MAC (aleatoria o manual)
│   ├── firewall_fail2ban.sh             # Configuración básica de firewall y fail2ban
│   ├── install_log.txt                  # Registro de instalación o ejecución de herramientas
│   └── setup_privacy_security_tools.sh  # Instalación de utilidades centradas en privacidad y seguridad
├── solucion_problema_wifi/      # Scripts y documentación para solucionar problemas de Wi-Fi
│   ├── README.md                 # Descripción de los problemas conocidos y soluciones aplicadas
│   └── wifi_watchdog.sh          # Script que reinicia automáticamente el Wi-Fi al detectar desconexión
├── utilidades/                  # Herramientas y scripts auxiliares generales
│   └── install_yay.sh            # Instalador automático y limpio de yay (AUR helper)
├── virtualizacion/              # Scripts para configurar y optimizar entornos de virtualización
│   ├── README.md                 # Información general sobre configuración de virtualización
│   └── install-virt-manager.sh   # Instalación y setup de virt-manager y dependencias
├── LICENSE                       # Licencia del proyecto (GPLv3)
├── README.md                     # Descripción general del repositorio
├── aparte_por_si_no_tengo_x11.txt  # Notas o procedimientos alternativos si no hay entorno gráfico
├── dato_para_juego.txt          # Información o dato técnico relacionado con juegos
└── subirgithub.sh               # Script para subir automáticamente el proyecto a GitHub

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
