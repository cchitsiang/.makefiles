create-ecr-repo:
	aws ecr create-repository --repository-name $(PROJECT)/$(SERVICE_NAME) --region $(AWS_DEFAULT_REGION)

docker-build: 
	@echo "+\n++ Performing build of Docker image $(IMAGE)...\n+"
	@if [ "$(OS)" = "Darwin" ]; then docker build --platform linux/amd64 -t $(IMAGE) --force-rm --rm .; else docker build -t $(IMAGE) --force-rm --rm .; fi

docker-push:
	@echo "+\n++ Logging in to Amazon ECR $(AWS_ACCOUNT_ID) ...\n+"
	@aws ecr get-login-password --region $(AWS_DEFAULT_REGION) | docker login --username AWS --password-stdin $(AWS_ECR_REPO)
	@echo "+\n++ Pushing image $(IMAGE) to AWS ECR...\n+"
	@docker tag $(IMAGE) $(AWS_ECR_REPO)
	@docker push $(AWS_ECR_REPO) 

docker-ecr: docker-build docker-push