#!/bin/bash
HOSTS_FILE="hosts.txt"
echo "🚀 Début de la vérification réseau"

while IFS= read -r host || [ -n "$host" ]; do
    [[ -z "$host" || "$host" =~ ^# ]] && continue
    # Nettoyage des retours chariots (très important quand on passe de Windows à Linux)
    host=$(echo "$host" | tr -d '\r')

    # --- DÉBUT DE LA MODIFICATION ---
    # On détecte si on est sur Windows (via Git Bash/MSYS) ou sur Linux (WSL/Debian)
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        # Syntaxe pour Windows
        ping -n 5 -w 2000 "$host" > /dev/null 2>&1
    else
        # Syntaxe pour Linux (Debian) et macOS
        ping -c 5 -W 2 "$host" > /dev/null 2>&1
    fi
    # --- FIN DE LA MODIFICATION ---

    if [ $? -eq 0 ]; then
        echo "✅ $host : ACCESSIBLE"
    else
        echo "❌ $host : INJOIGNABLE"
    fi
done < "$HOSTS_FILE"

echo "🏁 Terminé."