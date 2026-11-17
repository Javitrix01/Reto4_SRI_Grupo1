#!/bin/bash
# Comprobación de servicios del proyecto

echo "=== ESTADO DHCP ==="
systemctl is-active isc-dhcp-server

echo "=== ESTADO DNS ==="
systemctl is-active named

echo "=== ESTADO APACHE ==="
systemctl is-active apache2

echo "=== ESTADO MONITORIX ==="
systemctl is-active monitorix