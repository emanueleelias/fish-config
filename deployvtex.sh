#!/bin/bash

# Colores
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

# Función para mostrar cuenta regresiva
progressbar() {
    local duration="${1}"
    local bar_length=60
    local chars_per_second=$(( $bar_length / $duration ))
    local spinners=('⣾' '⣽' '⣻' '⢿' '⡿' '⢾' '⣼' '⣳')

    for ((i=0; i<=$duration; i++)); do
        progress=$(( $i * $chars_per_second ))
        spinner_index=$(( i % ${#spinners[@]} ))
        printf "\r[%${progress}s%*s] %s" "$(printf "#>%${progress}s" "" | sed 's/ /#/g')" "$((bar_length - progress))" "" "${spinners[$spinner_index]}"
        sleep 1
    done
    printf "\n"
}

echo -e "$BOLD$YELLOW VTEX RELEASE PATCH $NORMAL"

# Solicitar mensaje de commit
read -p "$BOLD$GREEN¿Ingrese el mensaje del commit?$NORMAL " commit_message

# Solicitar nombre de rama
read -p "$BOLD$GREEN¿Ingrese el nombre de la rama donde se va a pushear?$NORMAL " branch_name

# Agregar y commitear cambios en Git
echo "$YELLOW Preparando cambios para commitear...$NORMAL"
git add . || { echo "$RED Error al agregar cambios en Git$NORMAL"; exit 1; }
git commit -m "$commit_message" || { echo "$RED Error al realizar commit en Git$NORMAL"; exit 1; }
git push origin "$branch_name" || { echo "$RED Error al pushear cambios a rama $branch_name$NORMAL"; exit 1; }

# Solicitar nombre del vendor
read -p "$BOLD$GREEN¿Ingrese el nombre del vendor?$NORMAL " vendor_name
echo "$YELLOW Cambiando a la cuenta del vendor $BOLD$RED$vendor_name$NORMAL...$NORMAL"
vtex switch "$vendor_name" || { echo "$RED Error al cambiar a la cuenta del vendor$NORMAL"; exit 1; }

# Cambiar a producción
echo "$YELLOW Pasando a workspace de producción...$NORMAL"
vtex use production --production || { echo "$RED Error al cambiar a producción$NORMAL"; exit 1; }

# Liberar una versión patch
echo "$YELLOW Liberando versión patch estable...$NORMAL"
vtex release patch stable || { echo "$RED Error al liberar la versión patch$NORMAL"; exit 1; }

# Cuenta regresiva de 5 segundos
echo "$YELLOW Esperando 5 segundos antes de desplegar...$NORMAL"
progressbar 5

# Desplegar los cambios
echo "$YELLOW Forzando deploy...$NORMAL"
vtex deploy --force || { echo "$RED Error al desplegar los cambios$NORMAL"; exit 1; }

# Cuenta regresiva de 5 segundos
echo "$YELLOW Esperando 5 segundos antes de actualizar versión...$NORMAL"
progressbar 5

# Actualizar la versión en producción
echo "$YELLOW Update workspace de producción...$NORMAL"
vtex update || { echo "$RED Error al actualizar la versión en producción$NORMAL"; exit 1; }

# Cambiar a master
echo "$YELLOW Pasando a workspace master...$NORMAL"
vtex use master || { echo "$RED Error al cambiar a master$NORMAL"; exit 1; }

# Cuenta regresiva de 5 segundos
echo "$YELLOW Esperando 5 segundos antes de actualizar versión...$NORMAL"
progressbar 5

# Actualizar la versión en master
echo "$YELLOW Update master...$NORMAL"
vtex update || { echo "$RED Error al actualizar la versión en master$NORMAL"; exit 1; }
