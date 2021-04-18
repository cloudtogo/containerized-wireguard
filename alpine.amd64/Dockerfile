FROM docker.io/cloudtogo/curl-downloader:alpine-3 as wireguard-tools
ARG WIREGUARD_TOOLS_VERSION
WORKDIR /root
RUN curl -skL https://github.com/WireGuard/wireguard-tools/archive/refs/tags/v${WIREGUARD_TOOLS_VERSION}.tar.gz | tar -zxpf -

RUN apk update && apk add bash build-base linux-headers && rm -rf /var/cache/apk/*
ENV DESTDIR=/root/output
ENV WITH_WGQUICK=yes
RUN mkdir -p output && make -C wireguard-tools-${WIREGUARD_TOOLS_VERSION}/src && make install -C wireguard-tools-${WIREGUARD_TOOLS_VERSION}/src

FROM bash:5
RUN ln -s /usr/local/bin/bash /bin/bash
COPY --from=wireguard-tools /root/output /