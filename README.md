<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# podinfo

![Version: 6.11.1-bb.0](https://img.shields.io/badge/Version-6.11.1--bb.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 6.11.1](https://img.shields.io/badge/AppVersion-6.11.1-informational?style=flat-square) ![Maintenance Track: bb_maintained](https://img.shields.io/badge/Maintenance_Track-bb_maintained-yellow?style=flat-square)

Podinfo Helm chart for Kubernetes

## Upstream Release Notes

- [Find our upstream chart's CHANGELOG here](https://github.com/stefanprodan/podinfo/releases)
- [and our upstream application release notes here](https://github.com/stefanprodan/podinfo/releases)

## Learn More

- [Application Overview](docs/overview.md)
- [Other Documentation](docs/)

## Pre-Requisites

- Kubernetes Cluster deployed
- Kubernetes config installed in `~/.kube/config`
- Helm installed

Install Helm

https://helm.sh/docs/intro/install/

## Deployment

- Clone down the repository
- cd into directory

```bash
helm install podinfo chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.domain | string | `"dev.bigbang.mil"` |  |
| global.monitoring.enabled | bool | `false` |  |
| global.ambient | bool | `false` |  |
| bb-common.networkPolicies.enabled | bool | `true` |  |
| bb-common.networkPolicies.ingress.to.podinfo-upstream:9898.from.k8s.monitoring-monitoring-kube-prometheus@monitoring/prometheus.enabled | bool | `true` |  |
| bb-common.networkPolicies.ingress.to.redis:6379.podSelector.matchLabels.app | string | `"podinfo-upstream-redis"` |  |
| bb-common.networkPolicies.ingress.to.redis:6379.from.k8s.default@podinfo/podinfo-upstream | bool | `true` |  |
| bb-common.istio.enabled | bool | `true` |  |
| bb-common.istio.authorizationPolicies.enabled | bool | `true` |  |
| bb-common.istio.authorizationPolicies.generateFromNetpol | bool | `true` |  |
| bb-common.routes.inbound.podinfo.enabled | bool | `true` |  |
| bb-common.routes.inbound.podinfo.hosts[0] | string | `"podinfo.{{ .Values.global.domain }}"` |  |
| bb-common.routes.inbound.podinfo.gateways[0] | string | `"istio-gateway/public-ingressgateway"` |  |
| bb-common.routes.inbound.podinfo.service | string | `"podinfo-upstream"` |  |
| bb-common.routes.inbound.podinfo.port | int | `9898` |  |
| bb-common.routes.inbound.podinfo.selector."app.kubernetes.io/name" | string | `"podinfo-upstream"` |  |
| upstream.image.repository | string | `"registry1.dso.mil/ironbank/opensource/bigbang/podinfo"` |  |
| upstream.image.tag | string | `"6.10.1"` |  |
| upstream.serviceMonitor.enabled | bool | `true` |  |
| upstream.redis.enabled | bool | `true` |  |
| upstream.redis.repository | string | `"registry1.dso.mil/ironbank/opensource/redis/redis8-slim"` |  |
| upstream.redis.tag | string | `"8.6.1"` |  |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

