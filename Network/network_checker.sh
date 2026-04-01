#!/bin/bash
HOSTS_FILE="hosts.txt"
echo "🚀 Début de la vérification réseau"
while IFS= read -r host || [ -n "$host" ]; do
host=$(echo "$host" | tr -d '\r' | xargs)
[[ -z "$host" || "$host" == \#* ]] && continue
ping -c 1 -W 2 "$host" > /dev/null 2>&1
if [ $? -eq 0 ]; then
echo "✅ $host : ACCESSIBLE"
else
echo "❌ $host : INJOIGNABLE"
fi
done < "$HOSTS_FILE"
echo "🏁 Terminé."