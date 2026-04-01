#!/bin/bash

THRESHOLD=80
echo "🗂️ Vérification de l'espace disque..."

# --- DÉTECTION DE L'OS ---
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]] || grep -qi microsoft /proc/version 2>/dev/null; then
    # Version WINDOWS / WSL
    usage=$(powershell.exe -NoProfile -Command "\$d = Get-PSDrive C; [Math]::Round((\$d.Used / (\$d.Used + \$d.Free)) * 100)" | tr -d '\r\n ')
else
    # Version LINUX pure
    usage=$(df -h / | grep '/$' | awk '{print $5}' | sed 's/%//')
fi

# --- AFFICHAGE DU RÉSULTAT ---
if [ "$usage" -gt "$THRESHOLD" ]; then
    echo "⚠️ ALERTE : Espace critique sur le disque principal ! Utilisation à ${usage}%."
else
    echo "✅ Espace disque OK : Utilisation à ${usage}% (Seuil : ${THRESHOLD}%)."
fi