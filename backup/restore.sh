#!/bin/bash

# Configuration
DB_CONTAINER="mysql"
DB_USER="root"
DB_PASSWORD="${MYSQL_ROOT_PASSWORD}"
DB_NAME="${MYSQL_DATABASE}"
BACKUP_DIR="/backup"

if [ $# -eq 0 ]; then
    echo "Usage: $0 <nom_du_fichier_backup>"
    echo "Fichiers disponibles:"
    ls -la ${BACKUP_DIR}/prestashop_backup_*.sql.gz 2>/dev/null || echo "Aucun backup trouvé"
    exit 1
fi

BACKUP_FILE="$1"

if [ ! -f "${BACKUP_DIR}/${BACKUP_FILE}" ]; then
    echo "ERREUR: Fichier de backup non trouvé: ${BACKUP_DIR}/${BACKUP_FILE}"
    exit 1
fi

echo "$(date): Début de la restauration depuis ${BACKUP_FILE}"

if [[ ${BACKUP_FILE} == *.gz ]]; then
    zcat ${BACKUP_DIR}/${BACKUP_FILE} | docker exec -i ${DB_CONTAINER} mysql -u${DB_USER} -p${DB_PASSWORD}
else
    cat ${BACKUP_DIR}/${BACKUP_FILE} | docker exec -i ${DB_CONTAINER} mysql -u${DB_USER} -p${DB_PASSWORD}
fi

if [ $? -eq 0 ]; then
    echo "$(date): Restauration terminée avec succès"
else
    echo "$(date): ERREUR - La restauration a échoué"
    exit 1
fi