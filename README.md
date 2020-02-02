# prometheus-pve-exporter
This dockerizes [prometheus-pve-exporter by znerol](https://github.com/znerol/prometheus-pve-exporter)

The image entrypoint expects the config file at `/config/pve.yml`. Mount it as a volume or individual file. See the [pve-exporter readme](https://github.com/znerol/prometheus-pve-exporter/blob/master/README.rst) for how to configure the exporter.
```
#single file
docker run --name prometheus-pve-exporter -v $(pwd)/pve.yml:/config/pve.yml -p 9221 h3po/docker-prometheus-pve-exporter
#config volume
docker run --name prometheus-pve-exporter -v prometheus-pve-exporter:/config -p 9221 h3po/docker-prometheus-pve-exporter
```
