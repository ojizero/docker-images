ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

IMAGES ?= $(wildcard */)


build:
	for image in $(IMAGES); do \
		$(MAKE) -f "$${image}/Makefile" build; \
	done

push:
	for image in $(IMAGES); do \
		$(MAKE) -f "$${image}/Makefile" push; \
	done
