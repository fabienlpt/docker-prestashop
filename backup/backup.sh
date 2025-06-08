#!/bin/bash

# Configuration
DB_CONTAINER="mysql"
DB_USER="root"
DB_PASSWORD="${MYSQL_ROOT_PASSWORD}"
DB_NAME="${MYSQL_DATABASE}"
BACKUP_DIR="/backup"
MAX_BACKUPS=12

# Créer le répertoire de backup s'il n'existe pas
mkdir -p ${BACKUP_DIR}

# Nom du fichier de backup avec timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="${BACKUP_DIR}/prestashop_backup_${TIMESTAMP}.sql"

echo "$(date): Début du backup de la base de données ${DB_NAME}"

# Créer le backup
docker exec ${DB_CONTAINER} mysqldump \
    -u${DB_USER} \
    -p${DB_PASSWORD} \
    --single-transaction \
    --routines \
    --triggers \
    --databases ${DB_NAME} > ${BACKUP_FILE}

if [ $? -eq 0 ]; then
    echo "$(date): Backup créé avec succès: ${BACKUP_FILE}"
    gzip ${BACKUP_FILE}
    BACKUP_FILE="${BACKUP_FILE}.gz"
    echo "$(date): Backup compressé: ${BACKUP_FILE}"
    
    # Rotation des backups
    cd ${BACKUP_DIR}
    ls -t prestashop_backup_*.sql.gz | tail -n +$((MAX_BACKUPS + 1)) | xargs -r rm
    
    echo "$(date): Backup terminé avec succès"
else
    echo "$(date): ERREUR - Le backup a échoué"
    exit 1
fi