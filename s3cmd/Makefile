VERSION := v2.2.0
LATEST_VERSION_TAG := 2.2.0-alpine
STATIC_TAG := latest-alpine

all: update_base_images build publish

build:
	docker build \
		--file Dockerfile \
		--build-arg VERSION="${VERSION}" \
		--tag tomaskubat/s3cmd:${LATEST_VERSION_TAG} \
		--tag tomaskubat/s3cmd:${STATIC_TAG} \
		.

publish:
	docker push tomaskubat/s3cmd:${LATEST_VERSION_TAG}
	docker push tomaskubat/s3cmd:${STATIC_TAG}

update_base_images:
	docker pull alpine:latest

pull_base_images: update_base_images