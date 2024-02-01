#/bin/bash

sin_color='\033[0m'
rojo='\033[0;31m'
cyan='\033[1;36m'

#comprobamos si el ususario es root
if [ $(id -u) -ne 0 ];  then
	echo "${rojo}Debes ser root para ejecutar el script${sin_color}"
exit

fi

test -f /usr/bin/nmap

if [ "$(echo $?)" = "0" ]; then

  read -p "Introduce la IP que quieres escanear: " ip

	while true; do
	echo "1) Escaneo rapido pero ruidoso"
	echo "2) Escaneo normal"
	echo "3) Escaneo silencioso (mas lento)"
	echo "4) Escaneo de servicios y versiones"
	echo "5) Salir"
	read -p "Seleccione una opcion: " opcion
	case $opcion in
   1)
     clear && echo "Escaneando..." && nmap -p- --open --min-rate 5000 -T5 -sS -Pn -n -v $ip > escaneo_rapido.txt && echo "${cyan}Reporte guardado en el fichero escaneo_rapido.txt"
     exit
     ;;
   2)
     clear && echo "Escaneando..." && nmap -p- --open $ip > escaneo_normal.txt && echo "${cyan}Reporte guardado en el fichero escaneo_normal.txt"
     exit
     ;;
   3)
     clear && echo "Escaneando..." && nmap -p- -T2 -sS -Pn -f $ip > escaneo_silencioso.txt && echo "${cyan}Reporte guardado en el fichero escaneo_silencioso.txt"
     exit
     ;;
   4)
     clear && echo "Escaneando..." && nmap -sV -sC $ip > escaneo_servicios.txt && echo "${cyan}Reporte guardado en el fichero escaneo_servicios.txt"
     exit
     ;;
   5)
     break
     ;;
   *)
     echo "${rojo}No se ha encontrado el parametro, introduzca un valor correcto${sin_color}"
    ;;
     esac
  done
else
     echo -e "\n[!] Hay que instalar dependencias" && apt update >/dev/null && apt install nmap -y > /dev/nul && echo -e "\nDependencias instaladas"
fi
