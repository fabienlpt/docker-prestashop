#!/bin/bash

BACKUP_CONTAINER="backup"

show_help() {
    echo "Usage: $0 [OPTION]"
    echo "Gestion des backups de la base de données PrestaShop"
    echo ""
    echo "Options:"
    echo "  backup          Créer un backup immédiat"
    echo "  list            Lister les backups disponibles"
    echo "  restore FILE    Restaurer depuis un fichier backup"
    echo "  logs            Afficher les logs de backup"
    echo "  help            Afficher cette aide"
}

case "$1" in
    backup)
        echo "Création d'un backup immédiat..."
        docker exec ${BACKUP_CONTAINER} /usr/local/bin/backup.sh
        ;;
    list)
        echo "Backups disponibles:"
        docker exec ${BACKUP_CONTAINER} ls -lah /backup/
        ;;
    restore)
        if [ -z "$2" ]; then
            echo "ERREUR: Nom du fichier backup requis"
            echo "Usage: $0 restore <nom_fichier>"
            docker exec ${BACKUP_CONTAINER} ls /backup/
            exit 1
        fi
        docker exec ${BACKUP_CONTAINER} /usr/local/bin/restore.sh "$2"
        ;;
    logs)
        echo "Logs de backup:"
        docker exec ${BACKUP_CONTAINER} tail -f /var/log/backup.log
        ;;
    help|*)
        show_help
        ;;
esac