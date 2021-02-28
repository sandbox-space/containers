prod_build:
	docker build \
		--tag registry.gitlab.com/tomaskubat-sandbox/containers/nginx:1.19-prod-alpine \
		--tag registry.gitlab.com/tomaskubat-sandbox/containers/nginx:latest-prod-alpine \
		./1.19/prod/alpine

prod_publish:
	docker push registry.gitlab.com/tomaskubat-sandbox/containers/nginx:1.19-prod-alpine
	docker push registry.gitlab.com/tomaskubat-sandbox/containers/nginx:latest-prod-alpine

update_base_images:
	docker pull nginx:alpine