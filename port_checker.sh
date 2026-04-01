#!/bin/bash

# Vérification que l'utilisateur a bien fourni une adresse et un port
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "⚠️ Utilisation : bash port_checker.sh <hôte> <port>"
    echo "Exemple : bash port_checker.sh google.com 443"
    exit 1
fi

host=$1
port=$2

echo "🔎 Test du port $port sur $host..."

# DÉTECTION DE L'OS 
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    # Syntaxe pour Windows (Git Bash)
    # On utilise PowerShell en arrière-plan car l'outil réseau 'nc' n'y est pas par défaut
    result=$(powershell.exe -NoProfile -Command "Test-NetConnection -ComputerName '$host' -Port $port -InformationLevel Quiet")
    
    if [[ "$result" == *"True"* ]]; then
        echo "✅ Port $port OUVERT"
    else
        echo "❌ Port $port FERMÉ ou filtré"
    fi
else
    # Syntaxe pour Linux (Debian/Ubuntu/WSL) et macOS
    # On utilise l'outil standard 'netcat' (nc)
    nc -z -w 5 "$host" "$port" > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        echo "✅ Port $port OUVERT"
    else
        echo "❌ Port $port FERMÉ ou filtré"
    fi
fi