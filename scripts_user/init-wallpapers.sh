#!/usr/bin/env bash

directorio="$HOME/.config/wpg"

# Función para eliminar directorio si existe
eliminar_directorio() {
  if [ -d "$directorio" ]; then
    echo "Eliminando $directorio..."
    rm -rf "$directorio"
  fi
}

# 1. Eliminar directorio antes de ejecutar wpg
eliminar_directorio

# 2. Ejecutar wpg
echo "Ejecutando: wpg -a ~/Wallpapers/*"
wpg -a ~/Wallpapers/*

echo "Proceso completado."
