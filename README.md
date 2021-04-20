# Containerized Wireguard

This project provides a wireguard image that contains the userspace wireguard implementation, `wireguard-go`, wireguard utilites `wg` and `wg-quick`.
In particular, its image size is less than `10MB` and can work on embedded Linux distros no matter whether the wireguard kernel driver is installed.

Feel free to report issues or request images for new arches.

# Images

Images for different arches(amd64, arm64/v8 and arm32/v7) are published on DockerHub [cloudtogo4edge/wireguard-us](https://hub.docker.com/r/cloudtogo4edge/wireguard-us).

```
# amd64
docker pull cloudtogo4edge/wireguard-us:v0.0.20201119-amd64

# arm64v8
docker pull cloudtogo4edge/wireguard-us:v0.0.20201119-arm64v8

# arm32v7
docker pull cloudtogo4edge/wireguard-us:v0.0.20201119-arm32v7
```

## Tags

* **alpine-3.12**: [`v0.0.20201119-amd64`](https://github.com/cloudtogo/containerized-wireguard/blob/master/alpine.amd64/Dockerfile) [`v0.0.20201119-arm64v8`](https://github.com/cloudtogo/containerized-wireguard/blob/master/alpine.arm64v8/Dockerfile) [`v0.0.20201119-arm32v7`](https://github.com/cloudtogo/containerized-wireguard/blob/master/alpine.arm32v7/Dockerfile)

# Usage

The usage is quite easy that needs only 4 steps,

1. Mount hostpath `/dev/net/tun`,
2. Mount wireguard config file to `/etc/wireguard`, say `/etc/wireguard/wg0.conf`,
3. Set the net link name via environment variable `WG_DEV`,
4. Start the container with linux capability `NET_ADMIN`.

If you already have a Kubernetes cluster, feel free to test with the manifest `hack/manifests.yaml`.