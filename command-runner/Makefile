ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

RUNNER ?= node
TAG    ?= latest

IMAGE_REPO ?= $(RUNNER)-runner
IMAGE_TAG  ?= $(TAG)
NAMESPACE  ?= yamsafer


build:
	docker build \
		--force-rm \
		--tag "$(IMAGE_REPO):$(IMAGE_TAG)" \
		--build-arg "RUNNER=$(RUNNER)" \
		--build-arg "TAG=$(TAG)" \
		"$(ROOT_DIR)";

push:
	docker tag "$(IMAGE_REPO):$(IMAGE_TAG)" "$(NAMESPACE)/$(IMAGE_REPO):$(IMAGE_TAG)"
	docker push "$(NAMESPACE)/$(IMAGE_REPO):$(IMAGE_TAG)"
