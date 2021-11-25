### Stage Build

FROM php:8.0.0-fpm-alpine AS stage_build

RUN apk add --no-cache icu-dev \
  && docker-php-ext-install \
    intl \
    pcntl \
    opcache \
    pdo_mysql \
    sockets \
  && mkdir -p /root/php_extensions \
  && export PHP_EXTENSIONS_PATH="$(php -i | grep '^extension_dir' | cut -d' ' -f3)" \
  && mv $PHP_EXTENSIONS_PATH/* /root/php_extensions/

### Stage Final

FROM php:8.0.0-fpm-alpine AS stage_final

# set system timezone
ARG TZ='Europe/Prague'
ENV DEFAULT_TZ ${TZ}
ENV PATH=/root/bin:$PATH

# php paths
ENV PHP_SESSION_PATH='/var/lib/php/session'
ENV LOCAL_ETC_DIR="/usr/local/etc"

COPY --from=stage_build /root/php_extensions/ /root/php_extensions/
COPY _common/prod/fpm-alpine/bin/ /usr/local/bin/
COPY _common/prod/fpm-alpine/profile.d/ /etc/profile.d/
COPY _common/prod/fpm-alpine/docker-php-entrypoint /usr/local/bin/

RUN apk add --no-cache icu \
  # copy builded extension from stage_build
  && export PHP_EXTENSIONS_PATH="$(php -i | grep '^extension_dir' | cut -d' ' -f3)" \
  && rm $PHP_EXTENSIONS_PATH/* \
  && mv /root/php_extensions/* $PHP_EXTENSIONS_PATH/ \
  && rm -rf /root/php_extensions/ \
  # clean local configs (php & php-fpm)
  && rm -rfv $LOCAL_ETC_DIR/* \
  # clean others
  && rm /usr/local/bin/phpdbg \
  # create working user
  && set -eux \
  && addgroup -g 1000 -S app \
  && adduser -u 1000 -h /src -s /bin/ash -D -G app app \
  # php file session storage
  && mkdir -pv "$PHP_SESSION_PATH" \
  && chown 1000:1000 "$PHP_SESSION_PATH" \
  # make scripts executable
  && chmod ago+x /etc/profile.d/* \ 
  && chmod ago+x /usr/local/bin/* 

COPY _common/prod/fpm-alpine/etc/ "$LOCAL_ETC_DIR"

WORKDIR /src
USER 1000:1000