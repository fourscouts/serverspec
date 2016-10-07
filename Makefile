DOCKER_IMAGE = fourstacks/serverspec
DOCKER_TAG = latest

.PHONY: test build

build:
	docker build -t $(DOCKER_IMAGE) $(CURDIR)

push:
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)

test:
	@echo "linting the Dockerfile"
	@docker run --rm -i lukasmartinelli/hadolint hadolint --ignore DL3008 --ignore DL3013 - < Dockerfile
	@echo "running serverspec tests on the Dockerfile"
	@docker run -it -v "/var/run/docker.sock:/var/run/docker.sock" -v "$(PWD):/projectfiles" $(DOCKER_IMAGE)
