FROM php:7.3-apache-stretch
RUN apt-get update && apt-get install -y zlib1g-dev libpng-dev libpq-dev libzip-dev libicu-dev
RUN docker-php-source extract && docker-php-ext-install pdo pdo_mysql pdo_pgsql intl zip bcmath gd && docker-php-source delete
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN sed -ri -e 's!/var/www/!/var/www/html/craft/web!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf && \
    sed -ri -e 's!/var/www/html!/var/www/html/craft/web!g' /etc/apache2/sites-available/*.conf && a2enmod rewrite
RUN if [ "$APP_ENV" == "production" ]; then mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini; else mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini; fi
RUN sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 10M/g' $PHP_INI_DIR/php.ini
RUN sed -i 's/memory_limit = 128M/memory_limit = 256M/g' $PHP_INI_DIR/php.ini
RUN sed -i 's/max_execution_time = 30/max_execution_time = 120/g' $PHP_INI_DIR/php.ini
COPY .docker/000-default.conf /etc/apache2/sites-enabled