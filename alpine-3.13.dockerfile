# Multi-arch
FROM docker.io/cloudtogo4edge/curl-downloader:alpine-3 as wireguard-tools-src
ARG WIREGUARD_TOOLS_VERSION
WORKDIR /root
RUN curl -skL https://github.com/WireGuard/wireguard-tools/archive/refs/tags/v${WIREGUARD_TOOLS_VERSION}.tar.gz | tar -zxpf -

# Multi-arch
FROM alpine:3.13 as wireguard-tools
RUN apk update && apk add bash build-base linux-headers && rm -rf /var/cache/apk/*
COPY --from=wireguard-tools-src /root /root/
WORKDIR /root
ENV DESTDIR=/root/output
ENV WITH_WGQUICK=yes
ARG WIREGUARD_TOOLS_VERSION
RUN mkdir -p output && make -C wireguard-tools-${WIREGUARD_TOOLS_VERSION}/src && make install -C wireguard-tools-${WIREGUARD_TOOLS_VERSION}/src

# Multi-arch
FROM docker.io/cloudtogo4edge/curl-downloader:alpine-3 as wg-go-src
ARG WIREGUARD_GO_VERSION
WORKDIR /
RUN curl -o /tmp/wg.zip -skL https://codeload.github.com/WireGuard/wireguard-go/zip/refs/tags/${WIREGUARD_GO_VERSION} && \
	mkdir -p /go/src/github.com/WireGuard/ && unzip -d /go/src/github.com/WireGuard/ /tmp/wg.zip
RUN mv /go/src/github.com/WireGuard/wireguard-go-${WIREGUARD_GO_VERSION} /go/src/github.com/WireGuard/wireguard-go

# Multi-arch
FROM golang:1.16-alpine3.13 as wg-go
RUN apk update && apk add make && rm -rf /var/cache/apk/*
WORKDIR /go/src/github.com/WireGuard/wireguard-go
COPY --from=wg-go-src /go/src/github.com/WireGuard/wireguard-go ./
ENV DESTDIR=output
RUN make && make install

# Multi-arch
FROM alpine:3.13
RUN apk update && apk add bash iproute2 && rm -rf /var/cache/apk/*
WORKDIR /
COPY --from=wireguard-tools /root/output /
COPY --from=wg-go /go/src/github.com/WireGuard/wireguard-go/output /
ENV WG_DEV=wg0
ENTRYPOINT wg-quick up ${WG_DEV} && ip monitor dev ${WG_DEV}