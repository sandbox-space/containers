FROM php:8.0-fpm-alpine AS development

# set system timezone
ARG TZ='Europe/Prague'
ENV DEFAULT_TZ ${TZ}

COPY docker-php-entrypoint /usr/local/bin/

RUN set -eux; \
  addgroup -g 1000 -S project; \
  adduser -u 1000 -h /srv -s /bin/ash -D -G project project

WORKDIR /srv
USER 1000:1000