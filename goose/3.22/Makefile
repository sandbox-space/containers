PATERN_VERSION := 3.22.0
LATEST_VERSION := 3.22.1
STATIC_TAG := 3.22.latest

ifeq ($(shell uname -p),arm)
  PLATFORM=linux/arm64
else
  PLATFORM=linux/amd64
endif

all: build publish

build:
	sed "s/${PATERN_VERSION}/${LATEST_VERSION}/" prod/alpine/Dockerfile > prod/alpine/Dockerfile.tagged
	docker build \
		--platform=${PLATFORM} \
		--file prod/alpine/Dockerfile.tagged \
		--tag sandboxspace/goose:${LATEST_VERSION} \
		--tag sandboxspace/goose:${STATIC_TAG} \
		../

publish:
	docker push sandboxspace/goose:${LATEST_VERSION}
	docker push sandboxspace/goose:${STATIC_TAG}

