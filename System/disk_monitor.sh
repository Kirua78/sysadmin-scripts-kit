#!/bin/bash

THRESHOLD=80
echo "📊 Vérification de l'espace disque..."

# --- DÉTECTION DE L'OS ---
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    # Version WINDOWS (via PowerShell)
    # On récupère le % d'occupation du disque C:
    usage=$(powershell.exe -NoProfile -Command "Get-PSDrive C | Select-Object -ExpandProperty Used | ForEach-Object { [Math]::Round((\$_ / (Get-PSDrive C).Used + (Get-PSDrive C).Free) * 100) }" 2>/dev/null)
    
    # Correction pour extraire uniquement le chiffre de Windows
    usage=$(powershell.exe -NoProfile -Command "\$d = Get-PSDrive C; [Math]::Round((\$d.Used / (\$d.Used + \$d.Free)) * 100)")
else
    # Version LINUX (Standard)
    usage=$(df -h / | grep '/$' | awk '{print $5}' | sed 's/%//')
fi

# --- AFFICHAGE DU RÉSULTAT ---
if [ "$usage" -gt "$THRESHOLD" ]; then
    echo "⚠️ ALERTE : Espace critique sur le disque principal ! Utilisation à $usage%."
else
    echo "✅ Espace disque OK : Utilisation à $usage% (Seuil : $THRESHOLD%)."
fi