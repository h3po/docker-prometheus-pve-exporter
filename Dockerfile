FROM python:3-alpine

RUN \
  pip install --no-cache-dir prometheus-pve-exporter && \
  mkdir /config

COPY ./pve.yml /config/pve.yml
WORKDIR /config
VOLUME /config

ENTRYPOINT ["/usr/local/bin/pve_exporter"]
CMD ["pve.yml"]
