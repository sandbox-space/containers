### Stage Composer

FROM composer:2 AS stage_composer

### Stage Build

FROM registry.gitlab.com/tomaskubat-sandbox/containers/php:8.0-prod-fmp-alpine AS stage_build

USER 0:0

RUN apk add --no-cache $PHPIZE_DEPS \
  && pecl install xdebug \
  && mkdir -p /root/php_extensions \
  && export PHP_EXTENSIONS_PATH="$(php -i | grep '^extension_dir' | cut -d' ' -f3)" \
  && mv $PHP_EXTENSIONS_PATH/* /root/php_extensions/

### Stage Final

FROM registry.gitlab.com/tomaskubat-sandbox/containers/php:8.0-prod-fmp-alpine AS stage_final

USER 0:0

COPY --from=stage_composer /usr/bin/composer /usr/bin/composer
COPY --from=stage_build /root/php_extensions/ /root/php_extensions/

RUN apk add --no-cache vim mc \
  # copy builded extension from stage_build
  && export PHP_EXTENSIONS_PATH="$(php -i | grep '^extension_dir' | cut -d' ' -f3)" \
  && mv /root/php_extensions/* $PHP_EXTENSIONS_PATH/

COPY conf/ "$PHP_INI_DIR"
COPY conf.d/ "$PHP_INI_DIR/conf.d"

USER 1000:1000