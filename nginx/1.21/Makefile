PATERN_VERSION := 1.21.0-alpine
LATEST_VERSION := 1.21.3-alpine
STATIC_TAG := 1.21.latest-alpine

all: update_base_images build publish

build: prod_build dev_build
publish: prod_publish dev_publish

prod_build:
	sed "s/${PATERN_VERSION}/${LATEST_VERSION}/" prod/alpine/Dockerfile > prod/alpine/Dockerfile.tagged
	docker build \
		--file prod/alpine/Dockerfile.tagged \
		--tag sandboxspace/nginx-prod:${LATEST_VERSION} \
		--tag sandboxspace/nginx-prod:${STATIC_TAG} \
		../

prod_publish:
	docker push sandboxspace/nginx-prod:${LATEST_VERSION}
	docker push sandboxspace/nginx-prod:${STATIC_TAG}

dev_build:
	sed "s/${PATERN_VERSION}/${LATEST_VERSION}/" dev/alpine/Dockerfile > dev/alpine/Dockerfile.tagged
	docker build \
		--file dev/alpine/Dockerfile.tagged \
		--tag sandboxspace/nginx-dev:${LATEST_VERSION} \
		--tag sandboxspace/nginx-dev:${STATIC_TAG} \
		../

dev_publish:
	docker push sandboxspace/nginx-dev:${LATEST_VERSION}
	docker push sandboxspace/nginx-dev:${STATIC_TAG}

update_base_images:
	docker pull nginx:${LATEST_VERSION}

pull_base_images: update_base_images