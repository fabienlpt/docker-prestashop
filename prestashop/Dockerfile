FROM prestashop/prestashop:latest

RUN groupadd -r prestashop && useradd -r -g prestashop prestashop

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

COPY php.ini /usr/local/etc/php/php.ini

RUN mkdir -p /var/www/html && \
    chown -R prestashop:prestashop /var/www/html

USER prestashop

EXPOSE 80

CMD ["apache2-foreground"]