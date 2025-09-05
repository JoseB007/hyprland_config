#!/usr/bin/env bash

# ==========================
# 🎨 Configuración general
# ==========================

# Carpeta de wallpapers
WALLPAPER_DIR="$HOME/Descargas"

# Parámetros de transición
TRANSITION_TYPE="random" # fade | grow | wipe | outer | random
TRANSITION_DURATION=3    # en segundos
TRANSITION_STEP=30       # ms entre frames
TRANSITION_FPS=60        # frames por segundo
TRANSITION_POS="0.5,0.5" # 0-1 (x,y) => 0.5,0.5 es el centro

# Modo de ajuste de imagen
FILL_MODE="fill"      # fill | fit | stretch | center
RESIZE_MODE="lanczos" # nearest | bilinear | lanczos

# ==========================
# 🔀 Selección aleatoria
# ==========================

# Escoger imagen aleatoria del directorio
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# ==========================
# 🚀 Ejecutar cambio de fondo
# ==========================

# Inicializar swww si no está corriendo
# if ! pgrep -x "swww-daemon" >/dev/null; then
#   swww-daemon
# fi

# Aplicar wallpaper con parámetros definidos
swww img "$WALLPAPER" \
  --transition-type "$TRANSITION_TYPE" \
  --transition-duration "$TRANSITION_DURATION" \
  --transition-step "$TRANSITION_STEP" \
  --transition-fps "$TRANSITION_FPS"
#  --transition-pos "$TRANSITION_POS"
#  --resize "$RESIZE_MODE"
#  --fill "$FILL_MODE"
