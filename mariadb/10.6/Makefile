PATERN_VERSION := 10.6.0-focal
LATEST_VERSION := 10.6.4-focal
STATIC_TAG := 10.6.latest-focal

all: update_base_images build publish

build: prod_build dev_build
publish: prod_publish dev_publish

prod_build:
	sed "s/${PATERN_VERSION}/${LATEST_VERSION}/" prod/focal/Dockerfile > prod/focal/Dockerfile.tagged
	docker build \
		--file prod/focal/Dockerfile.tagged \
		--tag tomaskubat/mariadb-prod:${LATEST_VERSION} \
		--tag tomaskubat/mariadb-prod:${STATIC_TAG} \
		../

prod_publish:
	docker push tomaskubat/mariadb-prod:${LATEST_VERSION}
	docker push tomaskubat/mariadb-prod:${STATIC_TAG}

dev_build:
	sed "s/${PATERN_VERSION}/${LATEST_VERSION}/" dev/focal/Dockerfile > dev/focal/Dockerfile.tagged
	docker build \
		--file dev/focal/Dockerfile.tagged \
		--tag tomaskubat/mariadb-dev:${LATEST_VERSION} \
		--tag tomaskubat/mariadb-dev:${STATIC_TAG} \
		../

dev_publish:
	docker push tomaskubat/mariadb-dev:${LATEST_VERSION}
	docker push tomaskubat/mariadb-dev:${STATIC_TAG}

update_base_images:
	docker pull mariadb:${LATEST_VERSION}

pull_base_images: update_base_images