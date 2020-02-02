![Docker Automated build](https://img.shields.io/docker/automated/h3po/prometheus-pve-exporter) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/h3po/prometheus-pve-exporter)

# prometheus-pve-exporter
This dockerizes [prometheus-pve-exporter by znerol](https://github.com/znerol/prometheus-pve-exporter)

## configuration
The image entrypoint expects the config file at `/config/pve.yml`. Mount it as a volume or individual file. See the [pve-exporter readme](https://github.com/znerol/prometheus-pve-exporter/blob/master/README.rst) for how to configure the exporter.

## startup
```
#single file
docker run -v $(pwd)/pve.yml:/config/pve.yml -p 9221:9221 h3po/docker-prometheus-pve-exporter
#config volume, config will be at /var/lib/docker/volumes/prometheus-pve-exporter/_data/pve.yml
docker run -v prometheus-pve-exporter:/config -p 9221:9221 h3po/docker-prometheus-pve-exporter
```
## certificate validation
