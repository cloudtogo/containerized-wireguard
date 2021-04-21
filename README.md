# Containerized Wireguard

This project provides a wireguard image that contains the userspace wireguard implementation, `wireguard-go`, wireguard utilites `wg` and `wg-quick`.
In particular, its image size is less than `10MB` and can work on embedded Linux distros no matter whether the wireguard kernel driver is installed.

Feel free to report issues or request images for new arches.

# Images

The multi-arch image for amd64, arm64/v8 and arm32/v7 is published on DockerHub [cloudtogo4edge/wireguard-us](https://hub.docker.com/r/cloudtogo4edge/wireguard-us).

## Tags

* **alpine-3.12**: [`v0.0.20210323-alpine3.12`](https://github.com/cloudtogo/containerized-wireguard/blob/master/alpine-3.12.dockerfile)
* **alpine-3.13**: [`v0.0.20210323` `v0.0.20210323-alpine3.13`](https://github.com/cloudtogo/containerized-wireguard/blob/master/alpine-3.13.dockerfile)

# Usage

The usage is quite easy that needs only 4 steps,

1. Mount hostpath `/dev/net/tun`,
2. Mount wireguard config file to `/etc/wireguard`, say `/etc/wireguard/wg0.conf`,
3. Set the net link name via environment variable `WG_DEV`,
4. Start the container with linux capability `NET_ADMIN`.

If you already have a Kubernetes cluster, feel free to test with the manifest `hack/manifests.yaml`.