PATERN_VERSION := 8.0.0-fpm-alpine
LATEST_VERSION := 8.0.12-fpm-alpine
STATIC_TAG := 8.0.latest-fpm-alpine

all: update_base_images build publish

build: prod_build dev_build
publish: prod_publish dev_publish

prod_build:
	sed "s/${PATERN_VERSION}/${LATEST_VERSION}/" prod/fpm-alpine/Dockerfile > prod/fpm-alpine/Dockerfile.tagged
	docker build \
		--file prod/fpm-alpine/Dockerfile.tagged \
		--tag tomaskubat/php-prod:${LATEST_VERSION} \
		--tag tomaskubat/php-prod:${STATIC_TAG} \
		../

prod_publish:
	docker push tomaskubat/php-prod:${LATEST_VERSION}
	docker push tomaskubat/php-prod:${STATIC_TAG}

dev_build:
	sed "s/${PATERN_VERSION}/${LATEST_VERSION}/" dev/fpm-alpine/Dockerfile > dev/fpm-alpine/Dockerfile.tagged
	docker build \
		--file dev/fpm-alpine/Dockerfile.tagged \
		--tag tomaskubat/php-dev:${LATEST_VERSION} \
		--tag tomaskubat/php-dev:${STATIC_TAG} \
		../

dev_publish:
	docker push tomaskubat/php-dev:${LATEST_VERSION}
	docker push tomaskubat/php-dev:${STATIC_TAG}

update_base_images:
	docker pull php:${LATEST_VERSION}
	docker pull composer:2

pull_base_images: update_base_images