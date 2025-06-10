# 🎛️ Bash-Arch (BETA) – Scripts para Arch Linux con Hyprland, Gaming, Multimedia y Seguridad

**Versión**: 6.0.0-beta | **Licencia**: MIT

<p align="left">
  <img src="https://img.shields.io/badge/estado-beta--inestable-yellow" alt="Estado: Beta" />
  <img src="https://img.shields.io/github/license/Ylogther/bash-arch-BETA?color=blue" alt="Licencia: MIT" />
</p>

🔧 Herramienta avanzada para automatizar instalaciones, configuraciones y mantenimiento en Arch Linux.
Optimizada para entornos con Hyprland, gaming, multimedia, ciberseguridad y desarrollo.

**⚠️ Proyecto en estado BETA: puede contener errores o configuraciones inestables.**

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
├── actualizacion/
│   └── full_update.sh
├── desarrollo/
│   ├── instalar_blackarch.sh
│   ├── install_devtools.sh
│   ├── ml4w_install.sh
│   └── setup_dev_env.sh
├── gaming/
│   ├── drivers_install.sh
│   ├── instalacion-gaming.sh
│   └── mas/
│       └── Minecraft-install.sh
├── icons/
│   ├── Orbian-Ultradark.zip
│   └── Vivid-Dark-Icons.tar.gz
├── multimedia/
│   ├── davinci_resolve_deps.sh
│   ├── multimedia_install.sh
│   ├── streaming_install.sh
│   └── solucion abrir davinci resolve/
│       └── d.sh
├── seguridad/
│   ├── cambio_mac.sh
│   ├── firewall_fail2ban.sh
│   └── setup_privacy_security_tools.sh
├── solucion_problema_wifi/
│   └── wifi_watchdog.sh
├── utilidades/
│   └── install_yay.sh
├── virtualizacion/
│   └── install-virt-manager.sh
├── subirgithub.sh
├── install.sh                 # Script maestro opcional
├── env_check.sh              # Verificación de entorno (requisitos)
└── LICENSE
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
