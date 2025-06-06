#!/bin/bash

# Chargement des variables d'environnement
source .env

# Génération du fichier alertmanager.yml avec substitution des variables
envsubst < monitoring/alertmanager.yml.template > monitoring/alertmanager.yml

echo "✅ Fichier alertmanager.yml généré avec les variables d'environnement"