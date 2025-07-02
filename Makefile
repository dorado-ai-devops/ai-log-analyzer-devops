IMAGE_NAME=log-analyzer
VERSION=v0.1.6
CLUSTER_NAME=devops-ai
REGISTRY=localhost:5000
HELM_VALUES=../devops-ai-lab/manifests/helm-log-analyzer/values.yaml

.PHONY: all build tag push load update-values sync release

all: build load

build:
	docker build -t $(IMAGE_NAME):$(VERSION) .

tag:
	docker tag $(IMAGE_NAME):$(VERSION) $(REGISTRY)/$(IMAGE_NAME):$(VERSION)

push: tag
	docker push $(REGISTRY)/$(IMAGE_NAME):$(VERSION)

load:
	kind load docker-image $(IMAGE_NAME):$(VERSION) --name $(CLUSTER_NAME)

update-values:
	sed -i "s/^ *tag: .*/  tag: $(VERSION)/" $(HELM_VALUES)

sync:
	argocd app sync log-analyzer

release: build load update-values sync
	@echo "✅ Release completo: $(IMAGE_NAME):$(VERSION) desplegado y sincronizado con ArgoCD."

