#!/bin/bash

# Variables para el home del usuario actual y el directorio "Sun"
HOME_DIR="/home/$USER"
SUN_DIR="$HOME_DIR/Sun"

# Borrar la estructura de directorios "Sun" si existe
if [ -d "$SUN_DIR" ]; then
    rm -rf "$SUN_DIR"
    echo "Directorio 'Sun' y su contenido han sido eliminados."
fi

# Crear la estructura básica de los planetas
PLANETS=("Mercury" "Venus" "Earth" "Mars" "Jupiter" "Saturn" "Uranus" "Neptune")

# Crear el directorio "Sun" y los planetas dentro de él
mkdir -p "$SUN_DIR"
for planet in "${PLANETS[@]}"; do
  mkdir -p "$SUN_DIR/$planet"
done

# Crear los continentes dentro de "Earth"
CONTINENTS=("Africa" "America" "Asia" "Europe" "Oceania")
EARTH_DIR="$SUN_DIR/Earth"
mkdir -p "$EARTH_DIR"
for continent in "${CONTINENTS[@]}"; do
  mkdir -p "$EARTH_DIR/$continent"
done

# Crear los países dentro de "America"
COUNTRIES=("Mexico" "United_States" "Canada")
AMERICA_DIR="$EARTH_DIR/America"
mkdir -p "$AMERICA_DIR"
for country in "${COUNTRIES[@]}"; do
  mkdir -p "$AMERICA_DIR/$country"
done

# Crear los estados dentro de "Mexico"
STATES=("Chihuahua" "Durango" "Coahuila")
MEXICO_DIR="$AMERICA_DIR/Mexico"
mkdir -p "$MEXICO_DIR"
for state in "${STATES[@]}"; do
  mkdir -p "$MEXICO_DIR/$state"
done

# Crear las ciudades dentro de "Chihuahua"
CITIES=("Chihuahua" "Juarez")
CHIHUAHUA_DIR="$MEXICO_DIR/Chihuahua"
mkdir -p "$CHIHUAHUA_DIR"
for city in "${CITIES[@]}"; do
  mkdir -p "$CHIHUAHUA_DIR/$city"
done

# Crear el archivo con información sobre Ciudad Juárez en "Juarez"
JUAREZ_DIR="$CHIHUAHUA_DIR/Juarez"
JUAREZ_INFO_FILE="$JUAREZ_DIR/ciudad_juarez_info.txt"
cat > "$JUAREZ_INFO_FILE" <<EOL
Ciudad Juárez, México:

Historia:
Ciudad Juárez es una ciudad en el estado de Chihuahua, fundada en 1659.

Clima:
El clima de Ciudad Juárez es semiárido.

Actividades económicas:
Las principales actividades económicas incluyen la manufactura y el comercio transfronterizo.

Ubicación y entorno geográfico:
Ciudad Juárez está en la frontera con El Paso, Texas.

Índice de criminalidad:
La ciudad ha enfrentado problemas de criminalidad, aunque ha mejorado en años recientes.

Densidad demográfica:
Tiene una población de aproximadamente 1.5 millones de habitantes.

Universidad Autónoma de Ciudad Juárez (UACJ):
Fundada en 1973, es una de las principales instituciones educativas de la región.
EOL

# Crear el archivo con información sobre Ciudad Chihuahua en "Chihuahua"
CHIHUAHUA_INFO_FILE="$CHIHUAHUA_DIR/Chihuahua/ciudad_chihuahua_info.txt"
cat > "$CHIHUAHUA_INFO_FILE" <<EOL
Ciudad Chihuahua, México:

Historia:
Ciudad Chihuahua fue fundada en 1709 y es la capital del estado de Chihuahua.

Clima:
El clima de la ciudad es semiárido, con veranos calurosos e inviernos fríos.

Actividades económicas:
La ciudad tiene una economía diversificada basada en la industria y los servicios.

Ubicación y entorno geográfico:
Ubicada en el centro-norte de México, es un importante nodo de comunicaciones.

Índice de criminalidad:
La ciudad tiene un índice de criminalidad moderado en comparación con otras ciudades mexicanas.

Densidad demográfica:
Chihuahua tiene una población de alrededor de 900,000 habitantes.

Universidad Autónoma de Chihuahua (UACH):
Fundada en 1954, es una de las universidades más importantes del norte de México.
EOL

# Crear un archivo con 1000 palabras aleatorias en los directorios de los planetas, continentes, países, estados y ciudades
ALL_DIRECTORIES=($(find "$SUN_DIR" -type d))

# Generar aleatoriamente un directorio para insertar el "easter_egg"
RANDOM_INDEX=$((RANDOM % ${#ALL_DIRECTORIES[@]}))
EASTER_EGG_DIR="${ALL_DIRECTORIES[$RANDOM_INDEX]}"

# Llenar los archivos con 1000 palabras aleatorias, y un archivo tendrá "easter_egg"
for dir in "${ALL_DIRECTORIES[@]}"; do
  FILE="$dir/info.txt"
  if [ "$dir" == "$EASTER_EGG_DIR" ]; then
    # Insertar la palabra "easter_egg" en una línea aleatoria del archivo
    shuf -n 999 /usr/share/dict/words > "$FILE"
    echo "easter_egg" >> "$FILE"
    shuf "$FILE" -o "$FILE"  # Mezclar las líneas para que la palabra quede en una posición aleatoria
  else
    shuf -n 1000 /usr/share/dict/words > "$FILE"
  fi
done

# Mensaje de finalización
echo "La estructura de directorios y los archivos de información han sido creados con éxito."

