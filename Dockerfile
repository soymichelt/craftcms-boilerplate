# use a multi-stage build for dependencies
FROM craftcms/php-fpm:7.4

USER root
RUN chmod -R 777 /app