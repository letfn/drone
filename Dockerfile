FROM letfn/container AS download

RUN root

RUN curl -sSL -O https://github.com/drone/drone-cli/releases/download/v1.2.1/drone_linux_amd64.tar.gz \
  && tar xvfz drone_linux_amd64.tar.gz \
  && rm -f drone_linux_amd64.tar.gz \
  && chmod 755 drone \
  && mv drone /usr/local/bin/

FROM letfn/container

WORKDIR /drone/src

COPY --from=download /usr/local/bin/drone /usr/local/bin/drone

USER root
RUN apt-get update && apt-get upgrade -y

COPY plugin /plugin

USER app

ENTRYPOINT [ "/tini", "--", "/plugin" ]
