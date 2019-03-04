FROM docker:latest

LABEL com.plasmops.vendor=PlasmOps \
      com.plasmops.ci=gitlab

ENV LANG=C.UTF-8

RUN apk add --no-cache --update \
        curl bash git tar jq \
        git binutils coreutils findutils file build-base openssh-client

COPY /entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
