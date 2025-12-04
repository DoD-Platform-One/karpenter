<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# karpenter

![Version: 1.6.3-bb.3](https://img.shields.io/badge/Version-1.6.3--bb.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.6.3](https://img.shields.io/badge/AppVersion-1.6.3-informational?style=flat-square) ![Maintenance Track: unknown](https://img.shields.io/badge/Maintenance_Track-unknown-red?style=flat-square)

A Helm chart for Karpenter, an open-source node provisioning project built for Kubernetes.

## Upstream References

- <https://karpenter.sh/>
- <https://github.com/aws/karpenter-provider-aws/>

## Upstream Release Notes

This package has no upstream release note links on file. Please add some to [chart/Chart.yaml](chart/Chart.yaml) under `annotations.bigbang.dev/upstreamReleaseNotesMarkdown`.
Example:
```yaml
annotations:
  bigbang.dev/upstreamReleaseNotesMarkdown: |
    - [Find our upstream chart's CHANGELOG here](https://link-goes-here/CHANGELOG.md)
    - [and our upstream application release notes here](https://another-link-here/RELEASE_NOTES.md)
```

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
helm install karpenter chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| upstream.nameOverride | string | `"karpenter"` |  |
| upstream.fullnameOverride | string | `"karpenter"` |  |
| upstream.imagePullSecrets[0].name | string | `"private-registry"` |  |
| upstream.controller.image.repository | string | `"registry1.dso.mil/ironbank/opensource/aws/karpenter/controller"` |  |
| upstream.controller.image.tag | string | `"1.6.3"` |  |
| upstream.controller.image.digest | string | `""` |  |
| upstream.controller.resources.requests.cpu | int | `1` |  |
| upstream.controller.resources.requests.memory | string | `"4Gi"` |  |
| upstream.controller.resources.limits.cpu | int | `2` |  |
| upstream.controller.resources.limits.memory | string | `"8Gi"` |  |
| bbtests.enabled | bool | `false` |  |
| bbtests.scripts.image | string | `"registry1.dso.mil/ironbank/big-bang/devops-tester:1.0"` |  |
| bb-common.istio.enabled | bool | `true` |  |
| bb-common.istio.injection | string | `"enabled"` |  |
| bb-common.istio.sidecar.enabled | bool | `true` |  |
| bb-common.istio.authorizationPolicies.enabled | bool | `true` |  |
| bb-common.istio.authorizationPolicies.generateFromNetpol | bool | `true` |  |
| bb-common.istio.authorizationPolicies.defaults.allowInNamespace.enabled | bool | `true` |  |
| bb-common.istio.authorizationPolicies.defaults.denyAll.enabled | bool | `true` |  |
| bb-common.routes.inbound.aws.enabled | bool | `true` |  |
| bb-common.routes.inbound.aws.gateways[0] | string | `"istio-gateway/public-ingressgateway"` |  |
| bb-common.routes.inbound.aws.hosts[0] | string | `"ec2.us-gov-east-1.amazonaws.com"` |  |
| bb-common.routes.inbound.aws.hosts[1] | string | `"ec2.us-gov-west-1.amazonaws.com"` |  |
| bb-common.routes.inbound.aws.hosts[2] | string | `"eks.us-gov-east-1.amazonaws.com"` |  |
| bb-common.routes.inbound.aws.hosts[3] | string | `"eks.us-gov-west-1.amazonaws.com"` |  |
| bb-common.routes.inbound.aws.service | string | `"karpenter"` |  |
| bb-common.routes.inbound.aws.port | int | `443` |  |
| bb-common.routes.inbound.aws.selector."app.kubernetes.io/name" | string | `"karpenter"` |  |
| bb-common.networkPolicies.enabled | bool | `true` |  |
| bb-common.networkPolicies.ingress.defaults.enabled | bool | `true` |  |
| bb-common.networkPolicies.egress.defaults.enabled | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.definition.kubeAPI | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."35.71.115.0/24:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.119.208.0/23:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."15.205.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.95.100.0/22:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."108.175.56.0/22:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.152.184/32:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."35.111.252.0/24:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."136.18.0.0/23:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."76.223.168.0/24:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."56.137.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."99.77.183.0/24:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."3.30.0.0/15:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."56.136.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.152.189/32:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."160.1.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."16.67.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."3.32.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."182.30.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.152.190/32:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."108.175.52.0/22:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.152.191/32:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.46.224.0/20:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."108.175.60.0/22:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.61.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."40.39.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."16.65.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.248.224/28:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."56.139.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.152.195/32:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."13.166.0.0/15:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.22.0/24:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.152.187/32:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."56.138.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."16.153.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.99.240.0/20:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.252.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."108.175.48.0/22:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."99.77.184.0/24:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.152.185/32:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."96.127.0.0/17:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."3.4.16.0/21:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."99.151.96.0/21:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."182.29.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.9.0/24:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."182.28.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."35.71.116.0/24:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."16.152.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.198.32/28:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."205.251.236.0/22:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.222.0.0/17:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."16.64.0.0/17:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.152.186/32:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."35.111.253.0/24:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."15.200.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.253.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.249.112/28:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."16.66.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.46.96.0/19:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."54.239.0.128/28:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.152.188/32:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.152.192/32:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.152.194/32:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.152.193/32:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."54.239.1.64/28:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."75.79.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.99.112.0/20:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."40.38.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.254.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."3.4.24.0/21:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.46.176.0/22:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.96.8.0/21:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."16.64.102.0/23:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."16.64.36.0/23:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.252.126.0/25:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.252.165.0/26:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.252.58.0/23:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.254.23.64/26:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.254.61.128/26:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."182.30.13.192/26:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."182.30.157.0/26:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."182.30.85.0/26:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."182.30.85.128/25:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."15.200.150.0/23:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."15.200.176.192/26:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."15.205.2.192/26:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."3.30.98.128/26:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."3.30.98.64/26:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."3.32.190.0/25:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."56.136.0.192/26:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."56.136.121.0/25:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."56.136.224.0/23:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."56.137.38.0/23:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."35.71.115.0/24:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."15.205.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."108.175.56.0/22:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."35.111.252.0/24:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."136.18.0.0/23:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."56.137.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."99.77.183.0/24:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."3.30.0.0/15:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."56.136.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."160.1.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."3.32.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."182.30.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."108.175.60.0/22:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.61.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."16.65.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.248.224/28:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.99.240.0/20:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.252.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."99.77.184.0/24:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."96.127.0.0/17:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."3.4.16.0/21:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."99.151.96.0/21:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."35.71.116.0/24:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.222.0.0/17:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."16.64.0.0/17:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."35.111.253.0/24:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."15.200.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.253.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."52.94.249.112/28:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.99.112.0/20:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."40.38.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.254.0.0/16:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."3.4.24.0/21:443" | bool | `true` |  |
| bb-common.networkPolicies.egress.from.karpenter.to.cidr."18.96.8.0/21:443" | bool | `true` |  |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

