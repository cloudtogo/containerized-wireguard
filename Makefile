.PHONY: all
all:
	docker buildx build --platform=linux/amd64,linux/arm64,linux/arm/v7 --build-arg WIREGUARD_TOOLS_VERSION=1.0.20210315 --build-arg WIREGUARD_GO_VERSION=0.0.20210323 -f alpine-3.12.dockerfile -t docker.io/cloudtogo4edge/wireguard-us:v0.0.20210323-alpine3.12 --push .
	docker buildx build --platform=linux/amd64,linux/arm64,linux/arm/v7 --build-arg WIREGUARD_TOOLS_VERSION=1.0.20210315 --build-arg WIREGUARD_GO_VERSION=0.0.20210323 -f alpine-3.13.dockerfile -t docker.io/cloudtogo4edge/wireguard-us:v0.0.20210323-alpine3.13 --push .
	docker buildx build --platform=linux/amd64,linux/arm64,linux/arm/v7 --build-arg WIREGUARD_TOOLS_VERSION=1.0.20210315 --build-arg WIREGUARD_GO_VERSION=0.0.20210323 -f alpine-3.13.dockerfile -t docker.io/cloudtogo4edge/wireguard-us:v0.0.20210323 --push .

.PHONY: downloader
downloader:
	docker buildx build --platform=linux/amd64,linux/arm64,linux/arm/v7 -t docker.io/cloudtogo4edge/curl-downloader:alpine-3 -f downloader.dockerfile no-arch

.PHONY: test
test:
	kubectl delete --ignore-not-found -f hack/manifests.yaml
	kubectl apply --wait -f hack/manifests.yaml
	kubectl wait --for=condition=Ready po/wireguard-client
	kubectl wait --for=condition=Ready po/wireguard-server
	kubectl exec -ti wireguard-client -- ping -c 1 -W 1 192.168.2.1
	kubectl delete -f hack/manifests.yaml
