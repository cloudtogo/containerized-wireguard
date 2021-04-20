.PHONY: all
all:
	docker buildx build --platform=linux/amd64 --build-arg WIREGUARD_TOOLS_VERSION=1.0.20210315 --build-arg WIREGUARD_GO_VERSION=0.0.20210323 -t docker.io/cloudtogo4edge/wireguard-us:v0.0.20201119-amd64 alpine.amd64
	docker buildx build --platform=linux/arm64 --build-arg WIREGUARD_TOOLS_VERSION=1.0.20210315 --build-arg WIREGUARD_GO_VERSION=0.0.20210323 -t docker.io/cloudtogo4edge/wireguard-us:v0.0.20201119-arm64v8 alpine.arm64v8
	docker buildx build --platform=linux/arm/v7 --build-arg WIREGUARD_TOOLS_VERSION=1.0.20210315 --build-arg WIREGUARD_GO_VERSION=0.0.20210323 -t docker.io/cloudtogo4edge/wireguard-us:v0.0.20201119-arm32v7 alpine.arm32v7

.PHONY: downloader
downloader:
	docker buildx build --platform=linux/amd64,linux/arm64,linux/arm/v7 -t docker.io/cloudtogo4edge/curl-downloader:alpine-3 -f downloader.dockerfile no-arch

.PHONY: test
test:
	kubectl delete --ignore-not-found -f hack/manifests.yaml
	kubectl apply -f hack/manifests.yaml
	kubectl exec -ti wireguard-client -- ping -c 1 -W 1 192.168.2.1
