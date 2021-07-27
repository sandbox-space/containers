all: update_base_images build publish

build: prod_build dev_build
publish: prod_publish dev_publish

prod_build:
	docker build \
		--tag tomaskubat/php-prod:8.0.latest-fpm-alpine \
		./8.0/prod/fmp-alpine

prod_publish:
	docker push tomaskubat/php-prod:8.0.latest-fpm-alpine

dev_build:
	docker build \
		--tag tomaskubat/php-dev:8.0.latest-fpm-alpine \
		./8.0/dev/fmp-alpine

dev_publish:
	docker push tomaskubat/php-dev:8.0.latest-fpm-alpine

update_base_images:
	docker pull php:8.0-fpm-alpine
	docker pull composer:2

pull_base_images: update_base_images