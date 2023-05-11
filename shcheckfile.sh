#!/bin/bash

# Comprobación de argumento de archivo
if [ "$#" -ne 1 ]; 
    then echo "Use: $0 file"
    exit
fi

FILE=$1
SCRIPT="run_shcheckfile.sh"

echo '#!/bin/bash' > $SCRIPT

while IFS= read -r sitio
do
    echo "=============================================="
    echo -e "*** Preparando sitios para escanear"

    URL=$sitio
    NOMBRE=$(echo $sitio | sed 's/\/$//' | sed -E 's/^\s*.*:\/\///g')

    echo "URL: $URL"
    echo "OUTPUT: $NOMBRE"
    echo -e "Comando generado:"
    echo "shcheck.py $URL | tee sh_$NOMBRE.txt" | tee -a $SCRIPT

    echo -e "\n"
done < "$FILE"

echo "=============================================="
echo -e "*** Ejecutando análisis para: $(tail +2 $SCRIPT | wc -l) sitios\n"
chmod +x $SCRIPT
tail +2 $SCRIPT

echo -e "\nIniciando... \n$(date)"
./$SCRIPT