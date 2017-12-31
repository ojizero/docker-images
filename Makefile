ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

IMAGES ?= $(wildcard */)

build:
	for image in $(IMAGES); do \
		image_name="$$(echo $${image} | egrep -o '^[^:]+' | egrep -o '^[^:]+')" ;\
		$(MAKE) -f "$${image_name}/Makefile" build ;\
	done

push:
	for image in $(IMAGES); do \
		image_name="$$(echo $${image} | egrep -o '^[^:]+' | egrep -o '^[^:]+')" ;\
		$(MAKE) -f "$${image}/Makefile" push ;\
	done

publish:
	for image in $(IMAGES); do \
		image_name="$$(echo $${image} | egrep -o '^[^:]+' | egrep -o '^[^:]+')" ;\
		$(MAKE) -f "$${image_name}/Makefile" publish ;\
	done

publish-latest:
	for image in $(IMAGES); do \
		image_name="$$(echo $${image} | egrep -o '^[^:]+' | egrep -o '^[^:]+')" ;\
		$(MAKE) -f "$${image_name}/Makefile" publish-latest ;\
	done
