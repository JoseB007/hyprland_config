#!/usr/bin/env bash
set -euo pipefail

# === Utilidades ===
notify() {
  local title="$1" body="$2" urgency="$3" icon="$4"
  # mako respeta app-name, urgency e icon si tu tema los tiene
  notify-send --app-name="Power" --urgency="$urgency" --icon="$icon" --expire-time=4000 "$title" "$body"
}

is_on_battery() {
  # Devuelve 0 si está en batería, 1 si en AC
  gdbus call --system \
    --dest org.freedesktop.UPower \
    --object-path /org/freedesktop/UPower \
    --method org.freedesktop.DBus.Properties.Get \
    org.freedesktop.UPower OnBattery | grep -q "true"
}

battery_pct() {
  # Usa el dispositivo "DisplayDevice" que representa el estado agregado de batería
  gdbus call --system \
    --dest org.freedesktop.UPower \
    --object-path /org/freedesktop/UPower/devices/DisplayDevice \
    --method org.freedesktop.DBus.Properties.Get \
    org.freedesktop.UPower.Device Percentage \
  | grep -Eo '[0-9]+(\.[0-9]+)?' | cut -d. -f1
}

# (Opcional) emitir el estado inicial al arrancar el servicio:
# if is_on_battery; then
#   notify "Energía: Batería" "Cargador desconectado · $(battery_pct)% restante" "critical" "battery-caution-symbolic"
# else
#   notify "Energía: AC" "Cargador conectado · $(battery_pct)% cargada" "normal" "ac-adapter"
# fi

# === Monitor de eventos UPower (D-Bus) ===
gdbus monitor --system --dest org.freedesktop.UPower --object-path /org/freedesktop/UPower | \
while read -r line; do
  # Buscamos cambios de la propiedad OnBattery
  if [[ "$line" == *"PropertiesChanged"* && "$line" == *"OnBattery"* ]]; then
    if grep -q "<true>" <<< "$line"; then
      # Pasó a batería
      notify "Energía: Batería" "Se desconectó el cargador · $(battery_pct)% restante" "critical" "battery-caution-symbolic"
    elif grep -q "<false>" <<< "$line"; then
      # Pasó a AC
      notify "Energía: AC" "Cargador conectado · $(battery_pct)% cargada" "normal" "ac-adapter"
    fi
  fi
done

