FROM prestashop/prestashop:8-apache

RUN apt-get update && \
    apt-get install -y \
    unzip \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY php.ini /usr/local/etc/php/conf.d/prestashop.ini

RUN mkdir -p /tmp/theme && \
    wget -O /tmp/theme/theme.zip https://github.com/PrestaShop/classic-rocket/archive/master.zip && \
    unzip /tmp/theme/theme.zip -d /tmp/theme/ && \
    mkdir -p /var/www/html/themes/classic-rocket && \
    cp -r /tmp/theme/classic-rocket-master/* /var/www/html/themes/classic-rocket/ && \
    rm -rf /tmp/theme

ENV PS_LANGUAGE=fr \
    PS_COUNTRY=FR \
    PS_ERASE_DB=1 \
    PS_INSTALL_AUTO=1 \
    PS_DOMAIN=localhost \
    PS_FOLDER_ADMIN=admin \
    PS_FOLDER_INSTALL=install

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

USER www-data