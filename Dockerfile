FROM debian:stable-slim AS builder

RUN apt update \
 && apt upgrade -y \
 && apt install dumb-init -y

COPY teleport/teleport /usr/local/bin/teleport
COPY teleport/tctl /usr/local/bin/tctl

ENTRYPOINT  ["/usr/bin/dumb-init", "teleport", "start", "-c", "/etc/teleport/teleport.yaml"]

ARG BUILD_DATE
ARG IMAGE_DESCRIPTION
ARG IMAGE_NAME
ARG IMAGE_TAG_VERSION
ARG NAME

LABEL   org.label-schema.schema-version="1.0.0-rc.1" \
        org.label-schema.build-date=${BUILD_DATE} \
        org.label-schema.description="${IMAGE_DESCRIPTION}" \
        org.label-schema.name="${NAME}" \
        org.label-schema.version=${IMAGE_TAG_VERSION} \
        org.opencontainers.image.created=${BUILD_DATE} \
        org.opencontainers.image.description="${IMAGE_DESCRIPTION}" \
        org.opencontainers.image.title="${IMAGE_NAME}" \
        org.opencontainers.image.version=${IMAGE_TAG_VERSION}
