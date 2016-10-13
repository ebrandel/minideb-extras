.PHONY: all build

all: build

build: ubuntu-12.04 ubuntu-14.04 ubuntu-15.10 ubuntu-16.04 debian-wheezy debian-jessie

%::
	@distro=$$(echo "$@" | cut -d'-' -f1) ; \
	release=$$(echo "$@" | cut -d'-' -f2) ; \
	revision=$$(cat $$distro/$$release/REVISION) ; \
	if [ ${DEV_BUILD} ]; then revision=DEV; fi ; \
	docker build -t gcr.io/stacksmith-images/$$distro:$$release-r$$revision -f $$distro/$$release/Dockerfile . && \
	echo "FROM gcr.io/stacksmith-images/$$distro:$$release-r$$revision\n$$(cat $$distro/$$release/buildpack/Dockerfile)" | \
	docker build -t gcr.io/stacksmith-images/$$distro-buildpack:$$release-r$$revision -
