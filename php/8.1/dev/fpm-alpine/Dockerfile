### Stage Composer

FROM composer:2 AS stage_composer

### Stage s3cmd

FROM sandboxspace/php-prod:8.1.0-fpm-alpine AS stage_s3cmd

USER 0:0

RUN apk add python3 py-pip py-setuptools git ca-certificates

RUN pip install python-magic \
  && git clone https://github.com/s3tools/s3cmd.git /tmp/s3cmd \
  && cd /tmp/s3cmd \
  && python3 /tmp/s3cmd/setup.py install 

### Stage Build

FROM sandboxspace/php-prod:8.1.0-fpm-alpine AS stage_build

USER 0:0

RUN apk add --no-cache $PHPIZE_DEPS \
  && pecl install xdebug \
  && mkdir -p /root/php_extensions \
  && export PHP_EXTENSIONS_PATH="$(php -i | grep '^extension_dir' | cut -d' ' -f3)" \
  && mv $PHP_EXTENSIONS_PATH/* /root/php_extensions/

### Stage Final

FROM sandboxspace/php-prod:8.1.0-fpm-alpine AS stage_final

USER 0:0

COPY --from=stage_composer /usr/bin/composer /usr/bin/composer
COPY --from=stage_build /root/php_extensions/ /root/php_extensions/
COPY --from=stage_s3cmd /usr/lib/python*/site-packages/ /root/site-packages/
COPY --from=stage_s3cmd /usr/bin/s3cmd /usr/bin/s3cmd

RUN apk add --no-cache vim git mc python3 openssh \
  # copy builded extension from stage_build
  && PHP_EXTENSIONS_PATH="$(php -i | grep '^extension_dir' | cut -d' ' -f3)" \
  && PYTHON_VERSION="$(python3 --version | egrep -o '[0-9]+.[0-9]+')" \
  && mv /root/php_extensions/* $PHP_EXTENSIONS_PATH/ \
  && rm -rf "/usr/lib/python${PYTHON_VERSION}"/site-packages \
  && mv /root/site-packages "/usr/lib/python${PYTHON_VERSION}/" 

COPY _common/dev/fpm-alpine/etc/ "$LOCAL_ETC_DIR"
