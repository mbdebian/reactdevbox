# This Makefile helps on building the production container image
# Author: Manuel Bernal Llinares <mbdebian@gmail.com>

# Environment
container_name = mbdebian/reactdevbox
docker_compose_development_file = docker-compose-development.yml
tag_version = $(shell cat VERSION)

# Default target
all: deploy

release: deploy set_next_development_version
	@echo "<===|DEVOPS|===> [RELEASE] New Software Release, and next development version prepared"

sync_project_version:
	@echo "<===|DEVOPS|===> [SYNC] Synchronizing project version to version '${tag_version}'"

set_next_development_version:
	@echo "<===|DEVOPS|===> [SYNC] Setting the new development version, current ${tag_version}"

deploy: clean container_production_push
	@echo "<===|DEVOPS|===> [DEPLOY] Deploying tool container version ${tag_version}"

container_production_build: 
	@echo "<===|DEVOPS|===> [BUILD] Production container $(container_name):$(tag_version)"
	@docker build -t $(container_name):$(tag_version) -t $(container_name):latest .

container_production_push: container_production_build
	@echo "<===|DEVOPS|===> [PUBLISH]> Production container $(container_name):$(tag_version)"
	@docker push $(container_name):$(tag_version)
	@docker push $(container_name):latest

dev_container_build: clean container_production_build
	@echo "<===|DEVOPS|===> [DEV] Preparing local container"

# Folders
tmp:
	@echo "<===|DEVOPS|===> [FOLDER] Creating temporary folders"
	@mkdir -p tmp

clean_tmp:
	@echo "<===|DEVOPS|===> [HOUSEKEEPING] Cleaning temporary folders"
	@rm -rf tmp

clean: clean_tmp
	@echo "<===|DEVOPS|===> [CLEAN] Cleaning the space"

.PHONY: all clean container_production_build container_production_push dev_container_build deploy release sync_project_version set_next_development_version clean_tmp
