IMAGE_NAME := cent
NS ?= openvino-docker
VERSION ?= latest

all:
	@echo "target command: docker-build clean"

.PHONY: docker-build
docker-build:
	docker build -t $(NS)/$(IMAGE_NAME):$(VERSION) .
	/usr/bin/bash install_packages.sh

.PHONY: clean
clean:
	docker rm $(IMAGE_NAME)
