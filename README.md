```yaml
upstream:
  image:
    repository: registry1.dso.mil/ironbank/opensource/bigbang/podinfo
    tag: 6.10.1
  serviceMonitor:
    enabled: true
  redis:
    enabled: true
    repository: registry1.dso.mil/ironbank/opensource/redis/redis8-slim
    tag: 8.6.1

bb-common:
  # schema validation to keep you on track
  # foo: bar
  networkPolicies:
    enabled: true
    # injects HBONE port into network policies to ensure ztunnel traffic is permitted
    hbonePortInjection:
      enabled: true
    ingress:
      to:
        redis:6379:
          podSelector:
            matchLabels:
              app: podinfo-upstream-redis
          from:
            k8s:
              default@podinfo/podinfo-upstream: true

  istio:
    enabled: true
    sidecar:
      enabled: true
    authorizationPolicies:
      enabled: true
      # L4 policy for dummies
      generateFromNetpol: true

  routes:
    inbound:
      podinfo:
        enabled: true
        hosts:
          - podinfo.dev.bigbang.mil
        gateways:
          - istio-gateway/public-ingressgateway
        service: podinfo-upstream
        port: 9898
        selector:
          app.kubernetes.io/name: podinfo-upstream
```
