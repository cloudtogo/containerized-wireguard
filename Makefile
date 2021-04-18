.PHONY: all
all:
	kubectl dev build -t docker.io/cloudtogo/curl-downloader:alpine-3 -f downloader.dockerfile no-arch
	kubectl dev build --build-arg WIREGUARD_TOOLS_VERSION=1.0.20210315 --build-arg WIREGUARD_GO_VERSION=0.0.20210323 -t docker.io/cloudtogo/wireguard-us:v0.0.20201119 alpine.amd64

.PHONY: test
test:
	kubectl apply -f hack/manifests.yaml
	kubectl exec -ti wireguard-client -- ping -c 1 -W 1 192.168.2.1
