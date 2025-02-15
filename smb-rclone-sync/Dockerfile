FROM alpine:latest

COPY entrypoint.sh /entrypoint.sh

RUN apk update && apk add --no-cache \
    cifs-utils \
    nfs-utils \
    bash \
    rsync \
    openrc \
    rclone && \
    mkdir -p /run/openrc && touch /run/openrc/softlevel && \
    chmod +x /entrypoint.sh

# Ensure openrc is properly set up (needed for some network mounts)
RUN mkdir -p /run/openrc && touch /run/openrc/softlevel

USER root

CMD [ "/entrypoint.sh" ]