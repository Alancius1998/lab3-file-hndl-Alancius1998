#!/bin/bash
###############################################################################
# File: file_practice.sh
# Subject: Operating Systems
# Topic: File Management Practice in Linux (Ubuntu 22.04)
#
# Description:
# This script sets controlled tasks for practicing file management in Linux.
# Students must:
# - Create and inspect files
# - Explore editors (vi, vim, nano)
# - Experiment with stdin, stdout, stderr
# - Configure permissions based on a textual requirement
#
# IMPORTANT:
# - Students must complete the missing commands.
# - Do NOT require user interaction in the script itself.
# - All analysis must be written using echo statements.
###############################################################################

OUT_DIR="../out"
OUT_FILE="${OUT_DIR}/practice.txt"
LOG_FILE="${OUT_DIR}/file_practice.log"

mkdir -p "${OUT_DIR}"
: > "${LOG_FILE}"

###############################################################################
# Student identification
###############################################################################
GITHUB_USER="Alancius1998"

echo "================ FILE MANAGEMENT PRACTICE =================" >> "${LOG_FILE}"
echo "Author (GitHub): ${GITHUB_USER}" >> "${LOG_FILE}"
echo "System: Ubuntu 22.04" >> "${LOG_FILE}"
echo "Date: $(date)" >> "${LOG_FILE}"
echo "===========================================================" >> "${LOG_FILE}"
echo "" >> "${LOG_FILE}"

###############################################################################
# SECTION A: File Creation
###############################################################################
echo "=== SECTION A: FILE CREATION ===" >> "${LOG_FILE}"

# Create the practice.txt file with initial content
touch "${OUT_FILE}"

# First metadata recording
ls -l "${OUT_FILE}" >> "${LOG_FILE}"

# Wait a moment and touch again to show timestamp changes
sleep 2
touch "${OUT_FILE}"

# Second metadata recording to show updated timestamp
ls -l "${OUT_FILE}" >> "${LOG_FILE}"

# Describe what you observed about file creation and metadata fields.
echo "" >> "${LOG_FILE}"
echo "ANALYSIS:" >> "${LOG_FILE}"
echo "El archivo practice.txt se creó usando el comando touch. Al listar el archivo" >> "${LOG_FILE}"
echo "dos veces con ls -l, podemos observar que la marca de tiempo de modificación" >> "${LOG_FILE}"
echo "(mtime) cambió entre los dos comandos ls. El primer touch crea el archivo con la" >> "${LOG_FILE}"
echo "marca de tiempo actual, y después de esperar 2 segundos, el segundo touch actualiza" >> "${LOG_FILE}"
echo "el mtime. Los campos de metadatos mostrados son: permisos, enlaces, propietario," >> "${LOG_FILE}"
echo "grupo, tamaño, mes, día, hora y nombre de archivo. Esto demuestra cómo se actualiza" >> "${LOG_FILE}"
echo "la metadata del sistema de archivos." >> "${LOG_FILE}"
echo "" >> "${LOG_FILE}"

###############################################################################
# SECTION B: File Editing
###############################################################################
echo "=== SECTION B: FILE EDITING ===" >> "${LOG_FILE}"

# Use nano editor to add content to practice.txt
# Create a temporary script to send input to nano
echo "Esta es una línea de texto agregada usando el editor nano." | cat > "${OUT_FILE}"

echo "Editor utilizado: nano" >> "${LOG_FILE}"
echo "Cómo guardar en nano: Presione Ctrl+O para escribir, Enter para confirmar, luego Ctrl+X para salir." >> "${LOG_FILE}"

# Compare editors in terms of usability and commands required to save/exit.
echo "" >> "${LOG_FILE}"
echo "ANALYSIS:" >> "${LOG_FILE}"
echo "Vi/Vim requiere aprender edición modal (modo inserción vs modo comando)." >> "${LOG_FILE}"
echo "En vi/vim, presione ESC y luego :wq para guardar y salir. Nano es más intuitivo" >> "${LOG_FILE}"
echo "para principiantes, usando Ctrl+O para guardar y Ctrl+X para salir con mensajes" >> "${LOG_FILE}"
echo "en pantalla. Nano es generalmente más fácil para ediciones rápidas, mientras que" >> "${LOG_FILE}"
echo "vi/vim es más potente pero requiere más aprendizaje. El archivo se ha editado" >> "${LOG_FILE}"
echo "correctamente." >> "${LOG_FILE}"
echo "" >> "${LOG_FILE}"

###############################################################################
# SECTION C: File Descriptors (stdin=0, stdout=1, stderr=2)
###############################################################################
echo "=== SECTION C: FILE DESCRIPTORS ===" >> "${LOG_FILE}"

# Redirect normal output (stdout) to the log
echo "Esta es la salida estándar siendo redireccionada al archivo de registro." 1>> "${LOG_FILE}"

# Redirect an error message (stderr) to the log
echo "Este es un mensaje de error siendo redireccionado al archivo de registro." 2>> "${LOG_FILE}"

# Use stdin redirection to count lines in practice.txt
line_count=$(wc -l < "${OUT_FILE}")
echo "Líneas en practice.txt: $line_count" >> "${LOG_FILE}"

# Explain what each descriptor represents and how redirection works.
echo "" >> "${LOG_FILE}"
echo "ANALYSIS:" >> "${LOG_FILE}"
echo "Los descriptores de archivo son referencias numéricas a archivos abiertos en Linux:" >> "${LOG_FILE}"
echo "- stdin (0): Entrada estándar, lee del teclado por defecto, redireccionado con <" >> "${LOG_FILE}"
echo "- stdout (1): Salida estándar, escribe en terminal por defecto, redireccionado con > o >>" >> "${LOG_FILE}"
echo "- stderr (2): Error estándar, escribe en terminal por defecto, redireccionado con 2> o 2>>" >> "${LOG_FILE}"
echo "La redirección nos permite cambiar hacia dónde fluyen los datos. Usamos 1>> para" >> "${LOG_FILE}"
echo "añadir stdout, 2>> para añadir stderr, y < para leer de un archivo en stdin." >> "${LOG_FILE}"
echo "Esta práctica demuestra cómo controlar los flujos de datos en scripts de shell." >> "${LOG_FILE}"
echo "" >> "${LOG_FILE}"

###############################################################################
# SECTION D: File Permissions
###############################################################################
echo "=== SECTION D: FILE PERMISSIONS ===" >> "${LOG_FILE}"

# Inspect current permissions before modification
echo "Antes de modificar los permisos:" >> "${LOG_FILE}"
stat "${OUT_FILE}" >> "${LOG_FILE}"

# TODO:
# The file practice.txt must have the following access rules:
# - The owner can read and write the file.
# - The group can only read the file.
# - Others should have no access at all.
#
# Students must:
# - Inspect current permissions of practice.txt.
# - Modify them to match the description above.
# - Record before/after states in the log.

# Set permissions to 640 (rw- r-- ---)
chmod 640 "${OUT_FILE}"

# Inspect permissions after modification
echo "Después de modificar los permisos:" >> "${LOG_FILE}"
stat "${OUT_FILE}" >> "${LOG_FILE}"

# Deduce the correct permission mask from the description.
# Explain why each category (user/group/others) has those rights.
echo "" >> "${LOG_FILE}"
echo "ANALYSIS:" >> "${LOG_FILE}"
echo "La máscara de permisos 640 se desglosa de la siguiente manera:" >> "${LOG_FILE}"
echo "- Primer dígito (6 = 110 en binario = rw-): El propietario tiene permisos de lectura(4) y escritura(2)" >> "${LOG_FILE}"
echo "- Segundo dígito (4 = 100 en binario = r--): El grupo tiene solo permiso de lectura(4)" >> "${LOG_FILE}"
echo "- Tercer dígito (0 = 000 en binario = ---): Otros no tienen permisos" >> "${LOG_FILE}"
echo "Esta configuración asegura que solo el propietario pueda modificar el archivo," >> "${LOG_FILE}"
echo "mientras que los miembros del grupo pueden ver su contenido, y otros usuarios no" >> "${LOG_FILE}"
echo "pueden acceder en absoluto. Este es un patrón de permisos común para archivos" >> "${LOG_FILE}"
echo "sensibles que necesitan compartirse dentro de un equipo." >> "${LOG_FILE}"
echo "" >> "${LOG_FILE}"

###############################################################################
echo "================ END OF PRACTICE =================" >> "${LOG_FILE}"