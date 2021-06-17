### Stage Build

FROM php:8.0.0-fpm-alpine AS stage_build

RUN apk add --no-cache icu-dev \
  && docker-php-ext-install \
    intl \
    opcache \
    pdo_mysql \
  && mkdir -p /root/php_extensions \
  && export PHP_EXTENSIONS_PATH="$(php -i | grep '^extension_dir' | cut -d' ' -f3)" \
  && mv $PHP_EXTENSIONS_PATH/* /root/php_extensions/

### Stage Final

FROM php:8.0.0-fpm-alpine AS stage_final

# set system timezone
ARG TZ='Europe/Prague'
ENV DEFAULT_TZ ${TZ}

# php paths
ENV PHP_SESSION_PATH='/var/lib/php/session'

COPY --from=stage_build /root/php_extensions/ /root/php_extensions/
COPY bin/ /usr/local/bin/
COPY profile.d/ /etc/profile.d/
# COPY docker-php-entrypoint /usr/local/bin/

RUN apk add --no-cache icu \
  # copy builded extension from stage_build
  && export PHP_EXTENSIONS_PATH="$(php -i | grep '^extension_dir' | cut -d' ' -f3)" \
  && rm $PHP_EXTENSIONS_PATH/* \
  && mv /root/php_extensions/* $PHP_EXTENSIONS_PATH/ \
  && rm -rf /root/php_extensions/ \
  # clean php configs
  && rm $PHP_INI_DIR/php.ini* \
  && rm $PHP_INI_DIR/conf.d/* \
  # clean others
  && rm /usr/local/bin/phpdbg \
  # create working user
  && set -eux \
  && addgroup -g 1000 -S app \
  && adduser -u 1000 -h /srv -s /bin/ash -D -G app app \
  # php file session storage
  && mkdir -pv "$PHP_SESSION_PATH" \
  && chown 1000:1000 "$PHP_SESSION_PATH" \
  # make scripts executable
  && chmod ago+x /etc/profile.d/* \ 
  && chmod ago+x /usr/local/bin/* 

COPY conf/ "$PHP_INI_DIR"
COPY conf.d/ "$PHP_INI_DIR/conf.d"

WORKDIR /src
USER 1000:1000