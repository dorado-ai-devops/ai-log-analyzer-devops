IMAGE_NAME=log-analyzer
VERSION=v0.1.5
CLUSTER_NAME=devops-ai

.PHONY: all build push load sync

all: build load

build:
	docker build -t $(IMAGE_NAME):$(VERSION) .

tag:
	docker tag $(IMAGE_NAME):$(VERSION) localhost:5000/$(IMAGE_NAME):$(VERSION)

push:
	docker push localhost:5000/$(IMAGE_NAME):$(VERSION)

load:
	kind load docker-image $(IMAGE_NAME):$(VERSION) --name $(CLUSTER_NAME)

sync:
	argocd app sync log-analyzer
