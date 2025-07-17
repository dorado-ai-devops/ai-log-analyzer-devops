IMAGE_NAME     := log-analyzer
VERSION        := v1.0.1
REGISTRY       := localhost:5000
HELM_VALUES    := ../devops-ai-lab/manifests/helm-log-analyzer/values.yaml
ARGO_APP_NAME  := log-analyzer

.PHONY: all build tag push update-values sync release

all: release

build:
	docker build --no-cache -t $(IMAGE_NAME):$(VERSION) .

tag: build
	docker tag $(IMAGE_NAME):$(VERSION) $(REGISTRY)/$(IMAGE_NAME):$(VERSION)

push: tag
	docker push $(REGISTRY)/$(IMAGE_NAME):$(VERSION)

update-values:
	@echo "Actualizando Helm values para $(IMAGE_NAME)…"
	# Actualiza el repositorio
	sed -i "s|^\(\s*repository:\s*\).*|\1$(REGISTRY)/$(IMAGE_NAME)|" $(HELM_VALUES)
	# Actualiza la versión (tag)
	sed -i "s|^\(\s*tag:\s*\).*|\1\"$(VERSION)\"|"           $(HELM_VALUES)

sync:
	@echo "Sincronizando ArgoCD (app: $(ARGO_APP_NAME))…"
	argocd app sync $(ARGO_APP_NAME)

release: push update-values sync
	@echo "Release completo: $(REGISTRY)/$(IMAGE_NAME):$(VERSION) desplegado y sincronizado con ArgoCD."
