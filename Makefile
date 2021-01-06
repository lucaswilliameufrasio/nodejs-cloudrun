## Build docker image
docker-build:
	$ sudo docker build -t emoji-api-image .
.PHONY: docker-build

## Delete docker container
docker-delete:
	$ sudo docker rm emoji-api-image
.PHONY: docker-delete

## Run docker container
docker-run:
	$ make docker-delete && sudo docker run --name emoji-api-image -p 8080:8080 emoji-api-image
.PHONY: docker-run

## Run docker container
cloudrun-push:
ifndef PROJECT_ID
	@echo 'PROJECT_ID was not provided'
else
	$ gcloud builds submit --tag gcr.io/$(PROJECT_ID)/emojiapi
endif
.PHONY: cloudrun-push

## Run docker container
cloudrun-deploy:
ifndef PROJECT_ID
	@echo 'PROJECT_ID was not provided'
else
	$ gcloud run deploy emojiapi \
  	--image gcr.io/$(PROJECT_ID)/emojiapi \
  	--platform managed \
  	--region us-east1 \
  	--allow-unauthenticated
endif
.PHONY: cloudrun-deploy

## Add trigger for continuous delivery
cloudrun-add-trigger:
ifndef REPO_NAME
	@echo 'REPO_NAME was not provided'
else ifndef GITHUB_USERNAME
	@echo 'GITHUB_USERNAME was not provided'
else ifndef PROJECT_ID
	@echo 'PROJECT_ID was not provided'
else
	$ gcloud beta builds triggers create github \
	--repo-name=$(REPO_NAME) \
	--repo-owner=$(GITHUB_USERNAME) \
	--branch-pattern="^master$" \
	--substitutions=_PROJECT_ID=$(PROJECT_ID) \
	--build-config=cloudbuild.yaml
endif
.PHONY: cloudrun-add-trigger

test:
ifndef a
	@echo 'doesnt work'
else ifndef b
	@echo 'b was not defined'
else
	@echo 'worked'
endif
.PHONY: test
