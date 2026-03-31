#!/bin/bash
HOSTS_FILE="hosts.txt"
echo "🚀 Début de la vérification réseau"

while IFS= read -r host || [ -n "$host" ]; do
    [[ -z "$host" || "$host" =~ ^# ]] && continue
    host=$(echo "$host" | tr -d '\r')

    ping -c 5 -W 2 "$host" > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "✅ $host : ACCESSIBLE"
    else
        echo "❌ $host : INJOIGNABLE"
    fi
done < "$HOSTS_FILE"

echo "🏁 Terminé."