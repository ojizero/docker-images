ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

RUNNER ?= node
TAG    ?= latest


build:
	docker build \
		--force-rm \
		--tag "$(RUNNER)-runner:$(TAG)" \
		--build-arg "RUNNER=$(RUNNER)" \
		--build-arg "TAG=$(TAG)" \
		$(ROOT_DIR);

push:
	echo 'not implemented'
	exit 1
