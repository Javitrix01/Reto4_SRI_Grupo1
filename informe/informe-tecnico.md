# Informe del proyecto de redes – Grupo 1, Reto 4

> Documento pasado a Markdown a partir del informe original. Se han conservado sus apartados y se han extraído las imágenes a `capturas/`.

Configuración Proxmox IPs:

Cloud-Init: Configurar red estática (IP, gateway 192.168.X.1, DNS, dominio y hostname) en la pestaña Cloud-Init de Proxmox.

Server1:

![captura_02.png](capturas/captura_02.png)

Server2:

![captura_03.png](capturas/captura_03.png)

Server3:

![captura_04.png](capturas/captura_04.png)

Server4:

![captura_05.png](capturas/captura_05.png)

Configuración Pfsense:

Router,

![captura_06.png](capturas/captura_06.png)

Redireccionando los servidores a puertos,

![captura_07.png](capturas/captura_07.png)

Creación de claves y acceso por ssh:

Primero creamos las claves de todo el grupo y después adjuntamos todas las claves a los diferentes servidores.

Creación clave:

ssh-keygen -t ed25519 -C "Joel"

Después adjuntamos las claves a los servidores,

![captura_08.png](capturas/captura_08.png)

Creamos archivo config para poner el host y te lleve a la ip con la clave correcta.

![captura_09.png](capturas/captura_09.png)

Entramos a los servers,

![captura_10.png](capturas/captura_10.png)

![captura_11.png](capturas/captura_11.png)

Identificacion:

![captura_12.png](capturas/captura_12.png)

Sincronización (NTP)

Fase 1: Firewall pfSense

DHCP Local: Deshabilitar el servidor DHCP del pfSense en la LAN.

![captura_13.png](capturas/captura_13.png)

Política Restrictiva: Denegar por defecto. Prohibido usar DMZ o reglas "any".

Apertura de Puertos (Port Forwarding limitados al aula):

![captura_14.png](capturas/captura_14.png)

Fase 2: DHCP Redundante - Failover

Instalar el servicio DHCP (Esto lo hacemos en server1 y server2)

Vamos a utilizar ISC DHCP Server, que permite configurar el protocolo de failover.

![captura_15.png](capturas/captura_15.png)

Configurar Server1 como DHCP primario

![captura_16.png](capturas/captura_16.png)

![captura_17.png](capturas/captura_17.png)

Indicar la interfaz de red

En ambos servidores, comprueba que el servicio DHCP escucha en eth0. (Server1 y 2)

![captura_18.png](capturas/captura_18.png)

Comprobar y arrancar los servicios

![captura_19.png](capturas/captura_19.png)

![captura_20.png](capturas/captura_20.png)

Configurar Server4 como cliente DHCP

Ahora vamos a quitar la IP estática de Server4 y hacer que la obtenga mediante DHCP.

En Server4:

![captura_21.png](capturas/captura_21.png)

La configuración de la interfaz debe quedar aproximadamente así:

![captura_22.png](capturas/captura_22.png)

Server4 debe obtener la dirección reservada:

![captura_23.png](capturas/captura_23.png)

Prueba de failover

Cuando los dos servidores estén funcionando y sincronizados:

Comprueba que Server4 tiene 192.168.1.104.

Detén el DHCP de Server1:

![captura_24.png](capturas/captura_24.png)

En Server4, fuerza una renovación:

![captura_25.png](capturas/captura_25.png)

Comprueba la dirección:

![captura_26.png](capturas/captura_26.png)

Fase 3: DNS Redundante - Maestro-Esclavo

Instalar BIND9 en Server1

![captura_27.png](capturas/captura_27.png)

![captura_28.png](capturas/captura_28.png)

Configurar Server1 como maestro

![captura_29.png](capturas/captura_29.png)

![captura_30.png](capturas/captura_30.png)

Crear la zona directa

En Server1 ejecuta:

![captura_31.png](capturas/captura_31.png)

![captura_32.png](capturas/captura_32.png)

Crear la zona inversa de la red interna

![captura_33.png](capturas/captura_33.png)

![captura_34.png](capturas/captura_34.png)

Crear la zona inversa de los PC Windows

![captura_35.png](capturas/captura_35.png)

![captura_36.png](capturas/captura_36.png)

Crear la zona inversa del firewall WAN

![captura_37.png](capturas/captura_37.png)

![captura_38.png](capturas/captura_38.png)

Crear la zona inversa del servidor web

![captura_39.png](capturas/captura_39.png)

![captura_40.png](capturas/captura_40.png)

Configurar las opciones generales de BIND9

En Server1:

![captura_41.png](capturas/captura_41.png)

Comprobar Server1

![captura_42.png](capturas/captura_42.png)

![captura_43.png](capturas/captura_43.png)

Server1 ya funciona como maestro.

![captura_44.png](capturas/captura_44.png)

PARTE 2 – SERVER2 COMO ESCLAVO

Instalar BIND9 en Server2

![captura_45.png](capturas/captura_45.png)

Configurar Server2 como esclavo

![captura_46.png](capturas/captura_46.png)

![captura_47.png](capturas/captura_47.png)

Configurar las consultas DNS de Server2

![captura_48.png](capturas/captura_48.png)

![captura_49.png](capturas/captura_49.png)

Guardamos y reiniciamos

![captura_50.png](capturas/captura_50.png)

Comprobar que Server2 recibe las zonas

![captura_51.png](capturas/captura_51.png)

![captura_52.png](capturas/captura_52.png)

Comprobamos la zona inversiva

![captura_52.png](capturas/captura_52.png)

PARTE 3 – PRUEBA DE REDUNDANCIA

Comprobar la transferencia automática

En Server1:

![captura_53.png](capturas/captura_53.png)

Cambiamos el serial,

![captura_54.png](capturas/captura_54.png)

Guardamos y ejecutamos,

![captura_55.png](capturas/captura_55.png)

En Server2:

![captura_56.png](capturas/captura_56.png)

Si aparece el serial demuestra que Server2 ha recibido la actualización.

Detener Server1 y comprobar Server2

En Server1:

![captura_57.png](capturas/captura_57.png)

Ahora, desde Server2 o desde otro equipo con conectividad hacia él:

![captura_58.png](capturas/captura_58.png)

Otra conectividad

![captura_59.png](capturas/captura_59.png)

Una vez comprobado volvemos a inicial el servicio.

Fase 4: Web Apache2 y Monitorix

APACHE2:

![captura_60.png](capturas/captura_60.png)

![captura_61.png](capturas/captura_61.png)![captura_62.png](capturas/captura_62.png)

![captura_63.png](capturas/captura_63.png)

![captura_74.png](capturas/captura_74.png)

![captura_64.png](capturas/captura_64.png)

![captura_65.png](capturas/captura_65.png)

![captura_66.png](capturas/captura_66.png)

![captura_67.png](capturas/captura_67.png)

![captura_68.png](capturas/captura_68.png)

Instalar Monitorix

Ahora instalamos Monitorix en Server3.

![captura_69.png](capturas/captura_69.png)

Activamos el servicio,

![captura_70.png](capturas/captura_70.png)

![captura_71.png](capturas/captura_71.png)

Configurar Monitorix en el puerto 8080

Abre el archivo de configuración:

![captura_72.png](capturas/captura_72.png)

Cambiamos valores,

![captura_73.png](capturas/captura_73.png)

Reiniciamos monitorix y comprobamos que está escuchando en el puerto 8080,

![captura_01.png](capturas/captura_01.png)

Probar Monitorix desde Server3 y navegador

Ejecuta:

![captura_75.png](capturas/captura_75.png)

![captura_76.png](capturas/captura_76.png)

CONFIG NOMBRES DNS RESOLVER EN FIREWALL

Ahora estamos configurando los registros CNAME que hemos creado en el server1, poniendolos en el firewall para poder acceder con los alias,

![captura_77.png](capturas/captura_77.png)

![captura_78.png](capturas/captura_78.png)

LINKS NOMBRES/IPS DNS

APACHE:

IP:

URL:

PAGINA WEB F1:

IP:

URL:

MONITORIX:

IP:

URL:
