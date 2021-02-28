prod_build:
	docker build \
		--tag registry.gitlab.com/tomaskubat-sandbox/containers/php:8.0-prod-fmp-alpine \
		./8.0/prod/fmp-alpine

prod_publish:
	docker push registry.gitlab.com/tomaskubat-sandbox/containers/php:8.0-prod-fmp-alpine 

update_base_images:
	docker pull php:8.0-fpm-alpine