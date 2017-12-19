ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

RUNNER  ?= node
TAG ?= lts

RELEASE ?= ${RUNNER}-runner:${TAG}
IMAGES ?= $(wildcard */)


build:
	for image in $(IMAGES); do \
		docker build --force-rm --tag ${RELEASE} ${ROOT_DIR}; \
	done

push:
