#!/usr/bin/env bash

# ==========================
# 🎨 Configuración general
# ==========================

# Carpeta de wallpapers
WALLPAPER_DIR="$HOME/Wallpapers"

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

# Usar WPGTK para generar la paleta de colores desde el wallpaper
wpg -n -s "$WALLPAPER"

# Copiar la paleta de colores generada a la corpeta de colores
cp ~/.cache/wal/colors-waybar.css ~/.config/colors
cp ~/.cache/wal/colors-kitty.conf ~/.config/colors
cp ~/.cache/wal/colors.css ~/.config/colors
cp ~/.cache/wal/colors.json ~/.config/colors
cp ~/.cache/wal/colors.sh ~/.config/colors

# Recargar waybar
killall -9 waybar
waybar &

# Cargar la paleta como variables del sistema
source ~/.config/colors/colors.sh

# Convertir hex a rgb
hex_to_rgb() {
  local hex="$1"
  hex="${hex#"#"}" # quitar el "#"
  local r=$((16#${hex:0:2}))
  local g=$((16#${hex:2:2}))
  local b=$((16#${hex:4:2}))
  echo "rgb($r, $g, $b)"
}

BACKGROUND_RGB=$(hex_to_rgb "$background")
FOREGROUND_RGB=$(hex_to_rgb "$foreground")

# Generar hyprlock.conf dinámico
sed \
  -e "s|%wallpaper%|$wallpaper|g" \
  -e "s|%background%|$BACKGROUND_RGB|g" \
  -e "s|%foreground%|$FOREGROUND_RGB|g" \
  ~/.config/hypr/hyprlock.conf.template >~/.config/hypr/hyprlock.conf

# Remplazar colores en mako-notifications
sed \
  -e "s|%background-color%|$background|g" \
  -e "s|%text-color%|$foreground|g" \
  -e "s|%border-color%|$foreground|g" \
  -e "s|%progress-color%|$foreground|g" \
  ~/.config/mako/config.template >~/.config/mako/config

# Recargar mako-notifications
makoctl reload
