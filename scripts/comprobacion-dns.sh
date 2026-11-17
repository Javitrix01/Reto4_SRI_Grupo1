#!/bin/bash
# Comprobación DNS maestro y esclavo

echo "=== DNS SERVER1 ==="
dig @192.168.1.101 www.grupo1reto4.eus

echo "=== DNS SERVER2 ==="
dig @192.168.1.102 www.grupo1reto4.eus

echo "=== RESOLUCION SERVER3 ==="
dig @192.168.1.101 server3.grupo1reto4.eus