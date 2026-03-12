# How to Enable Kyverno Policy Integration for Karpenter

This guide explains how to ensure Kyverno Policy integration with Big Bang for Karpenter.

**NOTE:** This guide assumes you will be using the Big Bang [Kyverno Policies Chart](https://repo1.dso.mil/big-bang/product/packages/kyverno-policies)

## 1. Enable Exceptions for Kyverno Policy

- If Kyverno Policies are enabled, the following Kyverno Policies will require exceptions to deploy Karpenter on Big Bang:
  - disallow-auto-mount-service-account-token: Karpenter requires Kubernetes API access to provision and manage nodes
  - require-labels: The upstream chart does not include the `app.kubernetes.io/version` label on pods

```yaml
kyvernoPolicies:
  enabled: true
  values:
    policies:
      disallow-auto-mount-service-account-token:
        exclude:
          any:
          - resources:
              namespaces:
              - karpenter
              names:
              - karpenter*
      require-labels:
        exclude:
          any:
          - resources:
              namespaces:
              - karpenter
              names:
              - karpenter*
```

## 2. Verification

After applying this configuration:

1. Check that the Karpenter pods are running and in healthy state
