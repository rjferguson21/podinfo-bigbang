# Maintained Package Proposal

* Update matained packages to leverage bb-common as a sub-chart
* Focus on strict schema between maintained packages, and umbrella which will look like:

```yaml
# Global Configuration (hopefully limited use, but useful for detecting what packages are enabled)
global:
  domain: dev.bigbang.mil
  monitoring:
    enabled: true

# bb-common values (will accept bigbang istio configuration, network policies definitions, as well as package specific configuration)
bb-common:
  istio:
    enabled: <bigbang istiod enabled>
    authorizationPolicies:
      enabled: <bigbang authz enabled>
      generateFromNetpol: <bigbang generateFromNetpol enabled>

  networkPolicies:
   hbonePortInjection:
    enabled: <bigbang ambient enabled enabled>

    ingress:
      definitions: <bigbang ingress definitions>
    egress:
      definitions: <bigbang egress definitions>

# upstream, alias for upstream package (e.g. podinfo)
upstream:
  foo: bar
```

Example platform-values-configmap (deployed with bigbang, see [maintained branch](https://repo1.dso.mil/big-bang/bigbang/-/tree/maintained)):

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-platform-values
  namespace: {{ .Release.Namespace }}
data:
  common.yaml: |
    global:
      domain: {{ .Values.domain }}
      monitoring:
        enabled: {{ .Values.monitoring.enabled }}
    bb-common:
      istio:
        enabled: {{ $istioEnabled }}
        hardened:
          enabled: {{ $istioHardened }}
        sidecar:
          enabled: {{ $istioHardened }}
        authorizationPolicies:
          enabled: {{ $istioHardened }}
          generateFromNetpol: {{ $istioHardened }}
      networkPolicies:
        {{- .Values.networkPolicies | toYaml | nindent 8 }}
```

packages HelmRelease updated to include valuesFrom that includes a global `bigbang-platform-values`:

```yaml
valuesFrom:
  - name: {{ $.Release.Name }}-platform-values
    kind: ConfigMap
    valuesKey: common.yaml
  - name: {{ $pkg }}-values
    kind: Secret
```
