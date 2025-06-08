#!/bin/bash

echo "Démarrage du service de backup..."

# Créer le fichier de log
touch /var/log/backup.log
echo "Fichier de log créé : /var/log/backup.log"

# Faire un backup initial
echo "Backup initial..."
/usr/local/bin/backup.sh

# Configurer le cron
echo "Configuration du cron..."
echo "0 */6 * * * /usr/local/bin/backup.sh >> /var/log/backup.log 2>&1" > /etc/crontabs/root

# Vérifier la configuration
echo "Crontab configuré dans /etc/crontabs/root :"
cat /etc/crontabs/root

# Redémarrer crond pour prendre en compte la nouvelle config
echo "Redémarrage du cron..."
killall crond 2>/dev/null || true
sleep 1

# Démarrer le cron avec verbosité
echo "Démarrage du cron..."
crond -f -l 8