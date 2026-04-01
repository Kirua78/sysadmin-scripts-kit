#!/bin/bash
HOSTS_FILE="hosts.txt"

echo "🚀 Début de la vérification réseau"

if [ ! -f "$HOSTS_FILE" ]; then
    echo "❌ Erreur : $HOSTS_FILE introuvable."
    exit 1
fi

while IFS= read -r host || [ -n "$host" ]; do
    # Nettoyage immédiat
    host=$(echo "$host" | tr -d '\r' | xargs)
    
    # Ignorer les lignes vides ou commentaires
    [[ -z "$host" || "$host" == #* ]] && continue

    # Ping (compatible Windows/Linux via Bash)
    ping -c 1 -W 2 "$host" > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        echo "✅ $host : ACCESSIBLE"
    else
        echo "❌ $host : INJOIGNABLE"
    fi
done < "$HOSTS_FILE"

echo "🏁 Terminé."