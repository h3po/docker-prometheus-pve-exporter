![Docker Automated build](https://img.shields.io/docker/automated/h3po/prometheus-pve-exporter) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/h3po/prometheus-pve-exporter)

# prometheus-pve-exporter
This dockerizes [prometheus-pve-exporter by znerol](https://github.com/znerol/prometheus-pve-exporter)

## Configuration
The image entrypoint expects the config file at `/config/pve.yml`. Mount it as a volume or individual file. See the [pve-exporter readme](https://github.com/znerol/prometheus-pve-exporter/blob/master/README.rst) for how to configure the exporter.

## Startup
```
#single file
docker run -v $(pwd)/pve.yml:/config/pve.yml -p 9221:9221 h3po/docker-prometheus-pve-exporter
#config volume, config will be at /var/lib/docker/volumes/prometheus-pve-exporter/_data/pve.yml
docker run -v prometheus-pve-exporter:/config -p 9221:9221 h3po/docker-prometheus-pve-exporter
```
## Certificate validation
Proxmox by default creates its own self-signed CA, which is used to sign the certificate for the webinterface. Unless we make the ca certificate available to the exporter, we have to either set `verify_ssl=False` or give proxmox certificates from a public CA that is included in alpine's ca-certificates bundle. Proxmox supports let's encrypt ACME for this purpose.

### Inserting the proxmox CA using the config
[znerol/prometheus-pve-exporter](https://github.com/znerol/prometheus-pve-exporter) uses [proxmoxer](https://pypi.org/project/proxmoxer/), which in turn uses the requests library to connect to the proxmox API. The config dictionary is mostly passed through directly to requests; the `verify_ssl` parameter is passed to requests' `verify`. Apart from true/false, we may pass the path to our own CA certificate.
1. Get your proxmox CA certificate from the gui or from `/etc/pve/pve-root-ca.pem`
2. Put it inside the container volume at `/config/ca.pem`
3. Set verify_ssl to `verify_ssl=/config/ca.pem`

### Inserting the proxmox CA into the container trustanchors
You may mount your CA certificate into the container at `/usr/local/share/ca-certificates/` and run `update-ca-certificates` in the container to include it in the `/etc/ssl/certs/ca-certificates.crt` bundle. You'll need to make the /etc/ssl/certs folder persistent to save these changes. Python requests won't use that bundle until you set the environemnt variable `REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt`
