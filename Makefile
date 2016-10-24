DOCKER_IMAGE = fourstacks/serverspec
DOCKER_TAG = latest

.PHONY: test build

build:
	docker build -t $(DOCKER_IMAGE) $(CURDIR)

push:
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)

lint:
	@echo "start linting the Dockerfile"
	@docker run --rm -i fourstacks/hadolint hadolint --ignore DL3008 --ignore DL3013 - < Dockerfile
	@echo "finished linting the Dockerfile"

test:
	@echo "running serverspec tests on the Dockerfile"
	@docker run -it -v "/var/run/docker.sock:/var/run/docker.sock" -v "$(PWD):/projectfiles" $(DOCKER_IMAGE)

shell:
	@docker run -it -v "/var/run/docker.sock:/var/run/docker.sock" -v "$(PWD):/projectfiles" $(DOCKER_IMAGE) bash
