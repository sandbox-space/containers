all: update_base_images build publish

build: prod_build dev_build
publish: prod_publish dev_publish

prod_build:
	docker build \
		--tag registry.gitlab.com/tomaskubat-sandbox/containers/php:8.0-prod-fmp-alpine \
		./8.0/prod/fmp-alpine

prod_publish:
	docker push registry.gitlab.com/tomaskubat-sandbox/containers/php:8.0-prod-fmp-alpine 

dev_build:
	docker build \
		--tag registry.gitlab.com/tomaskubat-sandbox/containers/php:8.0-dev-fmp-alpine \
		./8.0/dev/fmp-alpine

dev_publish:
	docker push registry.gitlab.com/tomaskubat-sandbox/containers/php:8.0-dev-fmp-alpine

update_base_images:
	docker pull php:8.0-fpm-alpine
	docker pull composer:2