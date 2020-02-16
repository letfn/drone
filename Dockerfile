FROM letfn/container AS download

ARG _DRONE_VERSION=v1.2.1

USER root

RUN curl -sSL -O https://github.com/drone/drone-cli/releases/download/${_DRONE_VERSION}/drone_linux_amd64.tar.gz \
  && tar xvfz drone_linux_amd64.tar.gz \
  && rm -f drone_linux_amd64.tar.gz \
  && chmod 755 drone \
  && mv drone /usr/local/bin/

FROM letfn/container

WORKDIR /drone/src

COPY --from=download /usr/local/bin/drone /usr/local/bin/drone

COPY plugin /plugin

ENTRYPOINT [ "/tini", "--", "/plugin" ]
