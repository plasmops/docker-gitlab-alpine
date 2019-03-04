FROM docker:latest

LABEL com.plasmops.vendor=PlasmOps \
      com.plasmops.ci=gitlab

ENV LANG=C.UTF-8

RUN apk add --no-cache --update \
        curl bash git tar jq \
        git binutils coreutils findutils file build-base openssh-client

## Install python3 and create links (python, pip), mind that it's python3 anyways!
#
RUN apk add --no-cache --update python3 python3-dev && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
        ln -sf /usr/bin/python3 /usr/bin/python && \
        ln -sf /usr/bin/python3-config /usr/bin/python-config && \
        ln -sf /usr/bin/pydoc3 /usr/bin/pydoc && \
        ln -sf /usr/bin/pip3 /usr/bin/pip && \
    ( rm -rf /root/.cache /root/.* 2>/dev/null || /bin/true )

## AWS tools
RUN \
    pip install awscli && apk add --no-cache groff less mailcap && \
    ( rm -rf /root/.cache /root/.* 2>/dev/null || /bin/true )

COPY /entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
