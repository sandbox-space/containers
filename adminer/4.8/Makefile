PATERN_VERSION := 4.8.0-standalone
LATEST_VERSION := 4.8.1-standalone
STATIC_TAG := 4.8.latest-standalone

ifeq ($(shell uname -p),arm)
  PLATFORM=linux/arm64
else
  PLATFORM=linux/amd64
endif

all: update_base_images build publish

build:
	sed "s/${PATERN_VERSION}/${LATEST_VERSION}/" prod/standalone/Dockerfile > prod/standalone/Dockerfile.tagged
	docker build \
		--platform=${PLATFORM} \
		--file prod/standalone/Dockerfile.tagged \
		--tag sandboxspace/adminer:${LATEST_VERSION} \
		--tag sandboxspace/adminer:${STATIC_TAG} \
		../

publish:
	docker push sandboxspace/adminer:${LATEST_VERSION}
	docker push sandboxspace/adminer:${STATIC_TAG}

update_base_images:
	docker pull --platform=${PLATFORM} adminer:${LATEST_VERSION}

pull_base_images: update_base_images