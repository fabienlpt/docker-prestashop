FROM prestashop/prestashop:latest

RUN groupadd -r prestashop && useradd -r -g prestashop prestashop

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

COPY php.ini /usr/local/etc/php/php.ini

RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html


EXPOSE 80

CMD ["apache2-foreground"]