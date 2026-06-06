### Stage Composer

FROM composer:2 AS stage_composer

### Stage Build

FROM sandboxspace/php-prod:8.5.0-fpm-alpine AS stage_build

USER 0:0

RUN apk add --no-cache --update $PHPIZE_DEPS linux-headers \
  && pecl install xdebug \
  && mkdir -p /root/php_extensions \
  && export PHP_EXTENSIONS_PATH="$(php -i | grep '^extension_dir' | cut -d' ' -f3)" \
  && mv $PHP_EXTENSIONS_PATH/* /root/php_extensions/

### Stage Final

FROM sandboxspace/php-prod:8.5.0-fpm-alpine AS stage_final

USER 0:0

COPY --from=stage_composer /usr/bin/composer /usr/bin/composer
COPY --from=stage_build /root/php_extensions/ /root/php_extensions/

RUN apk add --no-cache s3cmd vim git mc python3 openssh make bash bash-completion \
  # enable bash tab-completion (e.g. `make <TAB>`) for interactive bash shells
  && echo '. /etc/bash/bash_completion.sh' >> /etc/bash/bashrc \
  # set bash as the default shell for root + app (dev only; prod stays on ash, where bash is not installed)
  && sed -i -E 's#^(root|app):(.*):/bin/(ash|sh)$#\1:\2:/bin/bash#' /etc/passwd \
  && sed -i 's#SHELL="/bin/ash"#SHELL="/bin/bash"#' /etc/profile.d/0shell.sh \
  # copy builded extension from stage_build
  && PHP_EXTENSIONS_PATH="$(php -i | grep '^extension_dir' | cut -d' ' -f3)" \
  && PYTHON_VERSION="$(python3 --version | egrep -o '[0-9]+.[0-9]+')" \
  && mv /root/php_extensions/* $PHP_EXTENSIONS_PATH/

COPY 8.5/dev/fpm-alpine/etc/ "$LOCAL_ETC_DIR"
