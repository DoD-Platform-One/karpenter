# Karpenter

## Overview

[Karpenter](https://karpenter.sh/) is a Kubernetes-native node provisioning project built for AWS EKS. It automatically provisions new nodes in response to unschedulable pods, improving cluster efficiency by selecting the right instance types and removing nodes when they are no longer needed.

This package deploys Karpenter as a Big Bang maintained package with full integration into the Big Bang ecosystem.

> **Note:** Karpenter is EKS-specific. It requires an AWS EKS cluster and cannot be used with other Kubernetes distributions.

## Big Bang Integration

This package integrates with the following Big Bang components:

### Istio

When Istio is enabled, the package supports:
- Automatic sidecar injection
- mTLS enforcement via PeerAuthentication
- AuthorizationPolicies generated from NetworkPolicies via bb-common
- PeerAuthentication exception for Prometheus metrics scraping

### Network Policies

When network policies are enabled:
- Default deny-all ingress/egress policies are applied
- Prometheus is allowed to scrape metrics
- Egress to the Kubernetes API server is allowed
- Egress to AWS API endpoints (EC2, EKS, IAM, etc.) is allowed via curated CIDR ranges

### Monitoring

When monitoring is enabled:
- ServiceMonitor for Prometheus metrics scraping with mTLS support
- Two Grafana dashboards:
  - **Karpenter Capacity Dashboard** — Node and pod capacity metrics
  - **Karpenter Performance Dashboard** — Controller performance and latency metrics

## Prerequisites

- AWS EKS cluster
- AWS IAM roles configured for Karpenter (see [upstream docs](https://karpenter.sh/docs/getting-started/))
- Iron Bank registry access (`registry1.dso.mil`)
- Kubernetes >= 1.25

## CRDs

Karpenter installs the following Custom Resource Definitions:
- **EC2NodeClass** — Defines AWS EC2 configuration for provisioned nodes
- **NodePool** — Defines constraints and requirements for node provisioning
- **NodeClaim** — Represents a request for a node (managed by Karpenter)

## Additional Documentation

- [Development and Maintenance Guide](DEVELOPMENT_MAINTENANCE.md)
- [Istio Hardening](IstioHardened.md)
- [Monitoring Setup](Monitoring.md)
