all: update_base_images build publish

build: prod_build dev_build
publish: prod_publish dev_publish

prod_build:
	docker build \
		--tag registry.gitlab.com/tomaskubat-sandbox/containers/mariadb:10.5-prod-focal \
		./10.5/prod/focal

prod_publish:
	docker push registry.gitlab.com/tomaskubat-sandbox/containers/mariadb:10.5-prod-focal

dev_build:
	docker build \
		--tag registry.gitlab.com/tomaskubat-sandbox/containers/mariadb:10.5-dev-focal \
		./10.5/dev/focal

dev_publish:
	docker push registry.gitlab.com/tomaskubat-sandbox/containers/mariadb:10.5-dev-focal

update_base_images:
	docker pull mariadb:10.5-focal