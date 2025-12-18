# Monitoring

Karpenter exposes metrics on port 8080, however when strict mTLS is enabled, you will need to enable certain features in the helm chart for Prometheus scrapers to work properly

In [`values.yaml`](../chart/values.yaml#L8), enable [`serviceMonitor`](../chart/values.yaml#L8) and [`monitoring`](../chart/values.yaml#L31)

```yaml
upstream:
  serviceMonitor:
    enabled: true
...
monitoring:
  enabled: true
```

These changes will expose the metrics port to prometheus in a permissive state, and creates the following components in the cluster:

- PeerAuthentication [karpenter-prometheus-exception](../chart/templates/bigbang/istio/peer-authentications/karpenter-prometheus-exception.yaml)
- ServiceMonitor `karpenter`
- [Grafana Dahsboards](../chart/dashboards/)

## Additional Documentation

- [Karpenter metrics reference documentation](https://karpenter.sh/docs/reference/metrics/)
