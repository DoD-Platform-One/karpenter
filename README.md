<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# karpenter

![Version: 1.6.3-bb.0](https://img.shields.io/badge/Version-1.6.3--bb.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.6.3](https://img.shields.io/badge/AppVersion-1.6.3-informational?style=flat-square) ![Maintenance Track: unknown](https://img.shields.io/badge/Maintenance_Track-unknown-red?style=flat-square)

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

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

