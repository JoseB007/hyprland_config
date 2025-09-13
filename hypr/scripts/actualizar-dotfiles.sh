#! /bin/bash

DEST=~/Documentos/hyprland-dots

# Crear la carpeta si no existe
mkdir -p "$DEST"

# Copiar configuraciones

cp -r ~/.config/rofi "$DEST"
cp -r ~/.config/nvim "$DEST"
cp -r ~/.config/mako "$DEST"
cp -r ~/.config/wofi "$DEST"
cp -r ~/.config/hypr "$DEST"
cp -r ~/.config/kitty "$DEST"
cp -r ~/.config/waybar "$DEST"
cp -r ~/.config/colors "$DEST"
cp -r ~/.config/wlogout "$DEST"
cp -r ~/.config/scripts_user "$DEST"
cp -r ~/.config/eww "$DEST"
cp ~/.config/starship.toml "$DEST"

notify-send -t 10000 "Actualización de Dotfiles completada."
