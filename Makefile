VERSION = $(shell date +%Y%m%d)

.PHONY: build start push

build:	build-version

build-version:
	docker build -t ${IMAGE}:${VERSION} .

tag-latest:
	docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest

start:
	docker run -it --rm ${IMAGE}:${VERSION}/bin/bash

login:
	echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin

push:	login build-version tag-latest
	docker push ${IMAGE}:${VERSION}; docker push ${IMAGE}:latest