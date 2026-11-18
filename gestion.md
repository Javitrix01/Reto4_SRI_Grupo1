# Gestión del Proyecto y Reparto de Tareas — Grupo 1

Este documento organiza la distribución de roles, configuración de servidores y tareas de validación entre los integrantes del **Grupo 1**.

## 1. Reparto de Tareas por Equipo / Servicio

### A. Infraestructura Base y Perímetro (`Proxmox` y `pfSense`)
* **Responsable:** *[ Joel y Javier ]*
* [ ] Verificación de encendido de máquinas virtuales en **Proxmox** (`172.26.46.240`).
* [ ] Configuración de interfaces WAN (`172.26.46.51`) y LAN (`192.168.1.1`) en **pfSense**.
* [ ] Configuración de NAT saliente (Outbound NAT) para acceso a Internet desde la LAN.
* [ ] Creación de reglas de Firewall básicas y redirección de puertos (Port Forwarding) hacia `server3-g1` si aplica.

### B. Servicios Primarios: DNS Maestro + DHCP Primario (`server1-g1`)
* **Responsable:** *[ Joel ]*
* [ ] Configuración de red estática (`192.168.1.101/24`, Gateway `192.168.1.1`).
* [ ] Instalación y configuración de servidor **DHCP Primario** (rango dinámico + reserva por MAC para `server4-g1` en `192.168.1.104`).
* [ ] Instalación y configuración de servidor **DNS Maestro** (zonas directa e inversa para el dominio local).
* [ ] Habilitación de transferencia de zona (AXFR) hacia `server2-g1`.

### C. Servicios Secundarios: DNS Esclavo + DHCP Secundario (`server2-g1`)
* **Responsable:** *[ Javier ]*
* [ ] Configuración de red estática (`192.168.1.102/24`, Gateway `192.168.1.1`).
* [ ] Configuración de **DHCP Secundario / Failover** sincronizado con `server1-g1`.
* [ ] Configuración de **DNS Esclavo** replicando las zonas desde `192.168.1.101`.
* [ ] Pruebas de tolerancia a fallos (apagado temporal de `server1-g1`).

### D. Servicios Web y Monitorización (`server3-g1`)
* **Responsable:** *[ Joel ]*
* [ ] Configuración de red estática (`192.168.1.103/24`, Gateway `192.168.1.1`).
* [ ] Instalación y despliegue de servidor web **Apache2** (VirtualHosts / página corporativa del grupo).
* [ ] Instalación y configuración de **Monitorix** para la supervisión de recursos y servicios.
* [ ] Aseguramiento de acceso HTTP/HTTPS desde la LAN (y WAN si se requiere).

### E. Administración y Pruebas (`server4-g1`)
* **Responsable:** *[ Todos ]*
* [ ] Verificación de obtención automática de IP `192.168.1.104` mediante reserva DHCP.
* [ ] Pruebas de resolución DNS (`dig` / `nslookup`) contra maestro y esclavo.
* [ ] Validación de acceso a Apache2 y panel de Monitorix en `server3-g1`.
* [ ] Documentación final y actualización de `README.md` y `gestion.md`.

---
## 2. Reflexión sobre el Proyecto y el Trabajo en Equipo

El despliegue de esta infraestructura de red ha supuesto un reto técnico enriquecedor que nos ha permitido llevar a la práctica conceptos clave de administración de sistemas y servicios en red. Trabajar sobre un entorno virtualizado en **Proxmox** y segmentado mediante **pfSense** nos ha ayudado a comprender la importancia de una correcta planificación previa del direccionamiento IP y de las reglas de perímetro antes de levantar los servicios internos.

Uno de los aprendizajes más valiosos ha sido la implementación de alta disponibilidad y redundancia mediante la sincronización entre el servidor primario (`server1-g1`) y el secundario (`server2-g1`). Configurar el intercambio de zonas DNS (AXFR) y el respaldo DHCP nos demostró cómo garantizar la continuidad del servicio ante posibles caídas, validando todo el proceso mediante pruebas reales de tolerancia a fallos. Asimismo, la integración de **Apache2** y **Monitorix** en `server3-g1` aportó una visión completa del ciclo de vida de un servicio: desde su despliegue hasta su supervisión continua.

A nivel organizativo, la división clara de responsabilidades entre los miembros del **Grupo 1** facilitó avanzar en paralelo sin generar conflictos en la red, mientras que la fase conjunta de validación desde el cliente (`server4-g1`) reforzó la comunicación y la resolución colaborativa de incidencias. En definitiva, esta práctica no solo ha consolidado nuestros conocimientos técnicos, sino también nuestra capacidad para documentar, coordinar y auditar una infraestructura funcional de principio a fin.
