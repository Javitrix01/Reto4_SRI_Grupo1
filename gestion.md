# Gestión del Proyecto y Reparto de Tareas — Grupo 1

Este documento organiza la distribución de roles, configuración de servidores y tareas de validación entre los integrantes del **Grupo 1**.

## 1. Integrantes del Grupo

| ID | Nombre y Apellidos | Rol Principal / Especialidad | Contacto / Usuario Git |
| :--- | :--- | :--- | :--- |
| **M1** | *[Nombre Integrante 1]* | Perímetro y Seguridad (`pfSense`) | `@usuario1` |
| **M2** | *[Nombre Integrante 2]* | Servicios de Red Primarios (`server1-g1`) | `@usuario2` |
| **M3** | *[Nombre Integrante 3]* | Alta Disponibilidad y Redundancia (`server2-g1`) | `@usuario3` |
| **M4** | *[Nombre Integrante 4]* | Servicios Web, Monitorización y Pruebas (`server3-g1`, `server4-g1`) | `@usuario4` |

---

## 2. Reparto de Tareas por Equipo / Servicio

### A. Infraestructura Base y Perímetro (`Proxmox` y `pfSense`)
* **Responsable:** *[Asignar integrante, ej. M1]*
* [ ] Verificación de encendido de máquinas virtuales en **Proxmox** (`172.26.46.240`).
* [ ] Configuración de interfaces WAN (`172.26.46.51`) y LAN (`192.168.1.1`) en **pfSense**.
* [ ] Configuración de NAT saliente (Outbound NAT) para acceso a Internet desde la LAN.
* [ ] Creación de reglas de Firewall básicas y redirección de puertos (Port Forwarding) hacia `server3-g1` si aplica.

### B. Servicios Primarios: DNS Maestro + DHCP Primario (`server1-g1`)
* **Responsable:** *[Asignar integrante, ej. M2]*
* [ ] Configuración de red estática (`192.168.1.101/24`, Gateway `192.168.1.1`).
* [ ] Instalación y configuración de servidor **DHCP Primario** (rango dinámico + reserva por MAC para `server4-g1` en `192.168.1.104`).
* [ ] Instalación y configuración de servidor **DNS Maestro** (zonas directa e inversa para el dominio local).
* [ ] Habilitación de transferencia de zona (AXFR) hacia `server2-g1`.

### C. Servicios Secundarios: DNS Esclavo + DHCP Secundario (`server2-g1`)
* **Responsable:** *[Asignar integrante, ej. M3]*
* [ ] Configuración de red estática (`192.168.1.102/24`, Gateway `192.168.1.1`).
* [ ] Configuración de **DHCP Secundario / Failover** sincronizado con `server1-g1`.
* [ ] Configuración de **DNS Esclavo** replicando las zonas desde `192.168.1.101`.
* [ ] Pruebas de tolerancia a fallos (apagado temporal de `server1-g1`).

### D. Servicios Web y Monitorización (`server3-g1`)
* **Responsable:** *[Asignar integrante, ej. M4]*
* [ ] Configuración de red estática (`192.168.1.103/24`, Gateway `192.168.1.1`).
* [ ] Instalación y despliegue de servidor web **Apache2** (VirtualHosts / página corporativa del grupo).
* [ ] Instalación y configuración de **Monitorix** para la supervisión de recursos y servicios.
* [ ] Aseguramiento de acceso HTTP/HTTPS desde la LAN (y WAN si se requiere).

### E. Administración y Pruebas (`server4-g1`)
* **Responsable:** *[Todos / Equipo de QA]*
* [ ] Verificación de obtención automática de IP `192.168.1.104` mediante reserva DHCP.
* [ ] Pruebas de resolución DNS (`dig` / `nslookup`) contra maestro y esclavo.
* [ ] Validación de acceso a Apache2 y panel de Monitorix en `server3-g1`.
* [ ] Documentación final y actualización de `README.md` y `gestion.md`.

---
