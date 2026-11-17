#!/bin/bash
# Comprobación de conectividad de la red del Grupo 1 - Reto 4

echo "=== COMPROBACION DE RED ==="

for ip in 192.168.1.1 192.168.1.101 192.168.1.102 192.168.1.103 192.168.1.104
do
    if ping -c 2 -W 2 "$ip" > /dev/null 2>&1; then
        echo "$ip: CONECTADO"
    else
        echo "$ip: SIN CONEXION"
    fi
done