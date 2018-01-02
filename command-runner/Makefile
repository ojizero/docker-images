ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

RUNNER   ?= node
BASE_TAG ?= latest

IMAGE_REPO ?= $(RUNNER)-runner
IMAGE_TAG  ?= $(BASE_TAG)
NAMESPACE  ?= yamsafer

VERSIONS        ?= 7-alpine 8-alpine 9-alpine
LATEST_VERSION  ?= 9-alpine
DEFAULT_FLAVOUR ?= alpine

build:
	docker build \
		--force-rm \
		--tag "$(IMAGE_REPO):$(IMAGE_TAG)" \
		--build-arg "RUNNER=$(RUNNER)" \
		--build-arg "TAG=$(BASE_TAG)" \
		"$(ROOT_DIR)";

push:
	docker tag "$(IMAGE_REPO):$(IMAGE_TAG)" "$(NAMESPACE)/$(IMAGE_REPO):$(IMAGE_TAG)"
	docker push "$(NAMESPACE)/$(IMAGE_REPO):$(IMAGE_TAG)"

publish:
	@for version in $(VERSIONS); do \
		$(MAKE) BASE_TAG=$${version} IMAGE_TAG=$${version} build ;\
		$(MAKE) BASE_TAG=$${version} IMAGE_TAG=$${version} push ;\
		\
		if [[ $${version} = *'$(DEFAULT_FLAVOUR)'* ]]; then \
			default_tag="$$(echo $${version} | egrep -o '^[^-]+')" ;\
			\
			$(MAKE) BASE_TAG=$${version} IMAGE_TAG=$${default_tag} build ;\
			$(MAKE) BASE_TAG=$${version} IMAGE_TAG=$${default_tag} push ;\
		fi ;\
	done
	$(MAKE) publish-latest

publish-latest:
	$(MAKE) BASE_TAG=$(LATEST_VERSION) IMAGE_TAG='latest' build ;\
	$(MAKE) BASE_TAG=$(LATEST_VERSION) IMAGE_TAG='latest' push
