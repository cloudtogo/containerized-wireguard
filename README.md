# Containerized Wireguard

This project provides a wireguard image that contains the userspace wireguard implementation, `wireguard-go`, wireguard utilites `wg` and `wg-quick`.
In particular, its image size is less than `10MB` and can work on embedded Linux distros no matter whether the wireguard kernel driver is installed.

# Usage

The usage is quite easy that needs only 4 steps,

1. Mount hostpath `/dev/net/tun`,
2. Mount wireguard config file to `/etc/wireguard`, say `/etc/wireguard/wg0.conf`,
3. Set the net link name via environment variable `WG_DEV`,
4. Start the container with linux capability `NET_ADMIN`.

If you already have a Kubernetes cluster, feel free to test with the manifest `hack/manifests.yaml`.