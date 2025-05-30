FROM nginx:alpine

# Générer un certificat SSL auto-signé simple
RUN apk add --no-cache openssl && \
    mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/CN=localhost"

# Supprimer la config par défaut
RUN rm /etc/nginx/conf.d/default.conf