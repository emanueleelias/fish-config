#!/bin/bash

# Colores
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

# Solicitar al usuario el nombre del vendor
read -p "$BOLD$GREEN¿Ingrese el nombre del vendor?$NORMAL " nombreVendor

# Solicitar al usuario el nombre del workspace
read -p "$BOLD$GREEN¿Ingrese el nombre del workspace?$NORMAL " nombreWorkspace

echo "$YELLOW Cambiando a la tienda $BOLD$RED$nombreVendor$NORMAL..."
vtex switch "$nombreVendor" || echo "$RED Error al cambiar a la tienda $nombreVendor$NORMAL"

echo "$YELLOW Configurando Git..."
git config user.name "eliasdaniel" && git config user.email "elias.em@knownonline.com" || echo "$RED Error al configurar Git$NORMAL"

echo "$YELLOW Cambiando al workspace $BOLD$RED$nombreWorkspace$NORMAL..."
vtex use "$nombreWorkspace" || echo "$RED Error al cambiar al workspace $nombreWorkspace$NORMAL"

echo "$YELLOW Linkeando el proyecto..."
vtex link -v -c || echo "$RED Error al linkear el proyecto$NORMAL"

echo "$GREEN Proceso completado exitosamente.$NORMAL"
