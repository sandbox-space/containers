PATERN_VERSION := 8.3.0-fpm-alpine
LATEST_VERSION := 8.3.3-fpm-alpine
STATIC_TAG := 8.3.latest-fpm-alpine

ifeq ($(shell uname -p),arm)
  PLATFORM=linux/arm64
else
  PLATFORM=linux/amd64
endif

all: update_base_images build publish

build: prod_build dev_build
publish: prod_publish dev_publish

prod_build:
	sed "s/${PATERN_VERSION}/${LATEST_VERSION}/" prod/fpm-alpine/Dockerfile > prod/fpm-alpine/Dockerfile.tagged
	docker build \
		--platform=${PLATFORM} \
		--file prod/fpm-alpine/Dockerfile.tagged \
		--tag sandboxspace/php-prod:${LATEST_VERSION} \
		--tag sandboxspace/php-prod:${STATIC_TAG} \
		../

prod_publish:
	docker push sandboxspace/php-prod:${LATEST_VERSION}
	docker push sandboxspace/php-prod:${STATIC_TAG}

dev_build:
	sed "s/${PATERN_VERSION}/${LATEST_VERSION}/" dev/fpm-alpine/Dockerfile > dev/fpm-alpine/Dockerfile.tagged
	docker buildx build \
		--platform=${PLATFORM} \
		--file dev/fpm-alpine/Dockerfile.tagged \
		--tag sandboxspace/php-dev:${LATEST_VERSION} \
		--tag sandboxspace/php-dev:${STATIC_TAG} \
		../ 

dev_publish:
	docker push sandboxspace/php-dev:${LATEST_VERSION}
	docker push sandboxspace/php-dev:${STATIC_TAG}

update_base_images:
	docker pull --platform=${PLATFORM} php:${LATEST_VERSION}
	docker pull --platform=${PLATFORM} composer:2

pull_base_images: update_base_images