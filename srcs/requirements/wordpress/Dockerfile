FROM alpine:3.20
ARG PHP_VERSION=83 \
    DB_NAME \
    DB_USER \
    DB_PASS
ENV DOMAIN_NAME \
    DB_HOST \
    DB_NAME \
    DB_USER \
    DB_PASS \
    WP_TITLE \
    WP_ADMIN \
    WP_ADM_PASS \
    WP_ADM_EMAIL \
    WP_USER \
    WP_USER_PASS \
    WP_USER_EMAIL \
    FS_USER

RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
    php${PHP_VERSION}-phar \
    wget \
    unzip \
    mariadb-client tzdata libmcrypt-dev zlib-dev gmp-dev iproute2 mc vim\
    freetype-dev libjpeg-turbo-dev libpng-dev \
    curl
    
RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/* && \ 
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp;
WORKDIR /var/www/html
# RUN wget https://wordpress.org/latest.zip && \
#     unzip latest.zip && \
#     cp -rf wordpress/* . && \
#     rm -rf wordpress latest.zip
COPY ./requirements/wordpress/conf/wp-config-create.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/wp-config-create.sh; 
#ln -s /usr/bin/php${PHP_VERSION} /usr/bin/php

ENTRYPOINT [ "sh", "/usr/local/bin/wp-config-create.sh"]
    
CMD ["php-fpm83", "-F"]
# CMD ["tail", "-f"]