DOCKER_IMAGE = fourstacks/serverspec
HADOLINT_DOCKER = fourstacks/hadolint:release-0.1

.PHONY: test build

build:
	docker build -t $(DOCKER_IMAGE) $(CURDIR)

lint:
	@echo "start linting the Dockerfile"
	@docker run --rm -i $(HADOLINT_DOCKER) hadolint --ignore DL3008 --ignore DL3013 - < Dockerfile
	@echo "finished linting the Dockerfile"

test: build lint
	@echo "running serverspec tests on the Dockerfile"
	@docker run -it -v "/var/run/docker.sock:/var/run/docker.sock" -v "$(PWD):/projectfiles" --workdir "/projectfiles/tests" $(DOCKER_IMAGE) rake

shell:
	@docker run -it -v "/var/run/docker.sock:/var/run/docker.sock" -v "$(PWD):/projectfiles" $(DOCKER_IMAGE) bash
