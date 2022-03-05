PATERN_VERSION := 10.6.0-focal
LATEST_VERSION := 10.6.4-focal
STATIC_TAG := 10.6.latest-focal

ifeq ($(shell uname -p),arm)
  PLATFORM=linux/arm64
else
  PLATFORM=linux/amd64
endif

all: update_base_images build publish

build: prod_build dev_build
publish: prod_publish dev_publish

prod_build:
	sed "s/${PATERN_VERSION}/${LATEST_VERSION}/" prod/focal/Dockerfile > prod/focal/Dockerfile.tagged
	docker build \
		--platform=${PLATFORM} \
		--file prod/focal/Dockerfile.tagged \
		--tag sandboxspace/mariadb-prod:${LATEST_VERSION} \
		--tag sandboxspace/mariadb-prod:${STATIC_TAG} \
		../

prod_publish:
	docker push sandboxspace/mariadb-prod:${LATEST_VERSION}
	docker push sandboxspace/mariadb-prod:${STATIC_TAG}

dev_build:
	sed "s/${PATERN_VERSION}/${LATEST_VERSION}/" dev/focal/Dockerfile > dev/focal/Dockerfile.tagged
	docker build \
		--platform=${PLATFORM} \
		--file dev/focal/Dockerfile.tagged \
		--tag sandboxspace/mariadb-dev:${LATEST_VERSION} \
		--tag sandboxspace/mariadb-dev:${STATIC_TAG} \
		../

dev_publish:
	docker push sandboxspace/mariadb-dev:${LATEST_VERSION}
	docker push sandboxspace/mariadb-dev:${STATIC_TAG}

update_base_images:
	docker pull --platform=${PLATFORM} mariadb:${LATEST_VERSION}

pull_base_images: update_base_images