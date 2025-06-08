FROM alpine:latest

# Installer les outils nécessaires
RUN apk add --no-cache \
    mysql-client \
    gzip \
    bash \
    dcron \
    tzdata \
    docker-cli

# Créer les répertoires
RUN mkdir -p /backup /var/log

# Copier les scripts
COPY backup.sh /usr/local/bin/backup.sh
COPY restore.sh /usr/local/bin/restore.sh
COPY start-backup.sh /usr/local/bin/start-backup.sh

# Rendre les scripts exécutables
RUN chmod +x /usr/local/bin/*.sh

# Configurer le timezone
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Créer le fichier crontab
RUN echo "0 */6 * * * /usr/local/bin/backup.sh >> /var/log/backup.log 2>&1" > /etc/crontabs/root

# Créer le fichier de log
RUN touch /var/log/backup.log

VOLUME ["/backup"]

CMD ["/usr/local/bin/start-backup.sh"]