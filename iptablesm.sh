#!/bin/bash
clear

# Gestión de reglas de IPTables
echo "Gestor de reglas IPTables"

# Definición de colores
fincolor='\e[0m'	    	        #Eliminar color
negritaamarillo='\033[1;33m'        #Amarillo negrita
negritacian='\033[1;36m'            #Cián negrita
amarillo='\033[0;93m'               #Amarillo intenso
rojo='\033[0;91m'                   #Rojo intenso
verde='\033[0;92m'                  #Verde intenso
azul='\033[0;94m'                   #Azul intenso
cian='\033[0;96m'                   #Cián intenso
negritacianintenso='\033[1;96m'     #Cián intenso y negrita
fondorojo='\033[0;101m'             #Fondo rojo e intenso

# Función de salida con control de errores
function salida() {
    codigo=$1
    if [ $codigo -eq 0 ]; then
        echo -e "${verde}Programa finalizado ($codigo)${fincolor}";
        exit $codigo;
    else
        echo -e "${rojo}Programa finalizado ($codigo)${fincolor}";
        exit $codigo
    fi
}

# Comprobar que quien ejecuta el script es el usuario root
if [ $EUID != 0 ]; then
    echo "El usuario que ejecute este script debe ser el usuario root";
    salida 1;
fi

function crear() {
    tabla=$1
    echo -e "${verde}Crear una regla${fincolor}";
}
function listar() {
    tabla=$1
    echo -e "${azul}Ver listado de reglas${fincolor}";
}
function eliminar {
    echo -e "${fondorojo}Eliminar una regla${fincolor}";
}
echo "-----";
echo "Opciones:";
echo -e "${verde}1. Crear una regla${fincolor}";
echo -e "${azul}2. Ver listado de reglas${fincolor}";
echo -e "${fondorojo}3. Eliminar una regla${fincolor}";
echo -e "${amarillo}4. Salir${fincolor}";
read -p "Selecciona una opcion: " opcion;
case $opcion in
    1)
        echo "1. Tabla NAT";
        echo "2. Tabla filter (cortafuegos)";
        read -p "Selecciona una tabla: " tabla;
        crear $tabla;;
    2)
        listar $tabla;;
    3)
        eliminar;;
    4)
        salida 0;;
esac