# Script: file-cut.sh
# Uso: ./file-cut.sh <user> <file>
# Descripción: Corta los ficheros proporcionalmente según el usuario.
# Si el divisor es 1, corta la décima parte del archivo.
#
# Primero validamos los argumentos del scrip
#
echo ''
echo 'Validando variables' 
echo ''
if [[ $# -ne 2 ]]; then
  echo "Uso: $0 <user> <file>"
  exit 1
else
  echo "Argumentos validos: Usuario: $1, Archivo: $2"
fi
echo ''
echo '------------------------------------------------------------------------------'
echo ''
#
# Nombramos las variables
echo ''
echo 'Nombrando variables' 
echo ''
USER=$1
FILE=$2
echo "Usuario: $USER y Archivo/os: $FILE"
echo ''
echo '------------------------------------------------------------------------------'
echo ''
#
# Validamos los archivos
echo ''
echo 'Validando archivos' 
echo ''
if [[ ! -f $FILE ]]; then 
  echo "Error: El archivos $FILE no existe"
  exit 1
else
  echo "Existen los archivos $FILE"
fi
echo ''
echo '------------------------------------------------------------------------------'
echo ''
#
# Generamos el divsisor 
echo ''
echo 'Calculando divisor proporcional' 
echo ''
DIVISOR=$(echo "$USER" | grep -oE '[0-9]+$')
#
# Comprobamos que el divisor no este vacio o sea 0
if [[ -z "$DIVISOR" || "$DIVISOR" -le 0 ]]; then 
  echo "Error: Usuario no válido o divisor no calculable"
  exit 1
# Modificamos el divisor si el usuario fuera alumno01 y mostramos por pantalla
elif [[ "$DIVISOR" -eq 1 ]]; then 
  DIVISOR=10
  echo "El divisor es: $DIVISOR"
# Mostramos por pantalla el divisor
else
  echo "El divisor es $DIVISOR"
fi
echo ''
echo '------------------------------------------------------------------------------'
echo ''
#
# Calculamos el numero de lineas
echo ''
TOTAL_LINES=$(wc -l < "$FILE")
echo "El número de lineas es: $TOTAL_LINES"
echo ''
echo '------------------------------------------------------------------------------'
echo ''
#
# Calculamos las lineas que se van a cortar del archivo
echo ''
CUT_LINES=$(($TOTAL_LINES / $DIVISOR))
#
# Ajustamos el numero para que nunca sea inferior a 1
if [[ $CUT_LINES -lt 1 ]]; then
  CUT_LINES=1
fi
echo "El número de lineas a cortar es: $CUT_LINES"
echo '------------------------------------------------------------------------------'
echo ''
#
# Cortamos el archivo y creamos un archivo temporal
echo ''
OUTPUT_FILE="${FILE}.tmp"
head -n "$CUT_LINES" "$FILE" > "$OUTPUT_FILE"
#
# Verificamos que se ha creado correctamente
if [[ -f "$OUTPUT_FILE" && -s "$OUTPUT_FILE" ]]; then
  echo "El archivo ha sido cortado correctamente: $OUTPUT_FILE"
else
  echo "Error: el archivo no se ha podido cortar correctamente"
  exit 1
fi
#
# Renombramos los archivos 
mv "$OUTPUT_FILE" "$FILE"
echo '------------------------------------------------------------------------------'
echo ''
#
# Terminamos el programa
echo ''
echo "Fin del programa"
echo '------------------------------------------------------------------------------'
echo ''