all: update_base_images build publish

build: prod_build dev_build
publish: prod_publish dev_publish

prod_build:
	docker build \
		--tag registry.gitlab.com/tomaskubat-sandbox/containers/nginx:1.19-prod-alpine \
		./1.19/prod/alpine

prod_publish:
	docker push registry.gitlab.com/tomaskubat-sandbox/containers/nginx:1.19-prod-alpine

dev_build:
	docker build \
		--tag registry.gitlab.com/tomaskubat-sandbox/containers/nginx:1.19-dev-alpine \
		./1.19/dev/alpine

dev_publish:
	docker push registry.gitlab.com/tomaskubat-sandbox/containers/nginx:1.19-dev-alpine

update_base_images:
	docker pull nginx:alpine