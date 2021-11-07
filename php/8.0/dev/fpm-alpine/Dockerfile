### Stage Composer

FROM composer:2 AS stage_composer

### Stage s3cmd

FROM tomaskubat/php-prod:8.0.0-fpm-alpine AS stage_s3cmd

USER 0:0

RUN apk add python3 py-pip py-setuptools git ca-certificates

RUN pip install python-magic \
  && git clone https://github.com/s3tools/s3cmd.git /tmp/s3cmd \
  && cd /tmp/s3cmd \
  && python3 /tmp/s3cmd/setup.py install 

### Stage Build

FROM tomaskubat/php-prod:8.0.0-fpm-alpine AS stage_build

USER 0:0

RUN apk add --no-cache $PHPIZE_DEPS \
  && pecl install xdebug \
  && mkdir -p /root/php_extensions \
  && export PHP_EXTENSIONS_PATH="$(php -i | grep '^extension_dir' | cut -d' ' -f3)" \
  && mv $PHP_EXTENSIONS_PATH/* /root/php_extensions/

### Stage Final

FROM tomaskubat/php-prod:8.0.0-fpm-alpine AS stage_final

USER 0:0

COPY --from=stage_composer /usr/bin/composer /usr/bin/composer
COPY --from=stage_s3cmd /usr/bin/s3cmd /usr/bin/s3cmd
COPY --from=stage_s3cmd /usr/lib/python3.9/site-packages/ /usr/lib/python3.9/site-packages/
COPY --from=stage_build /root/php_extensions/ /root/php_extensions/

RUN apk add --no-cache vim git mc python3 openssh \
  # copy builded extension from stage_build
  && export PHP_EXTENSIONS_PATH="$(php -i | grep '^extension_dir' | cut -d' ' -f3)" \
  && mv /root/php_extensions/* $PHP_EXTENSIONS_PATH/

COPY _common/dev/fpm-alpine/etc/ "$LOCAL_ETC_DIR"
