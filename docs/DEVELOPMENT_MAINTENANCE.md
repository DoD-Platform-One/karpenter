# Development and Maintenance

## Getting Karpenter IAM Credentials

To retrieve the Karpenter IAM credentials from AWS Secrets Manager:

```bash
aws secretsmanager get-secret-value \
  --secret-id Karpenter-iam-credentials \
  --query SecretString \
  --output text
```

## Development Override for Testing

1. First, retrieve the Karpenter IAM credentials using the command above
1. Create a local override file (e.g., `karpenter-dev-overrides.yaml`) with the following configuration
1. Replace `<your-development-branch>` with your actual branch name
1. Use [fetch_aws_ip_list.sh](../fetch_aws_ip_list.sh) To configure Network Policies and Service Entries for your AWS region(s). The script will update [./chart/values.yaml](../chart/values.yaml) for you.
1. Replace `<AWS_ACCESS_KEY_ID_HERE>` and `<AWS_SECRET_ACCESS_KEY_HERE>` with the credentials from the secrets manager

```yaml
flux:
  driftDetection:
    mode: disabled

networkPolicies:
  enabled: false

kyverno:
  enabled: false

kyvernoPolicies:
  enabled: false

kyvernoReporter:
  enabled: false

packages:
  karpenter:
    enabled: true
    helmRelease:
      namespace: bigbang
    git:
      repo: "https://repo1.dso.mil/big-bang/apps/sandbox/karpenter.git"
      path: "./chart"
      branch: <your-development-branch>
      tag: ""
    values:
      upstream:
        topologySpreadConstraints: []
        settings:
          clusterName: bb-development-eks
          isolatedVPC: true
        controller:
          env:
            - name: AWS_REGION
              value: us-gov-west-1
            - name: AWS_ACCESS_KEY_ID
              value: <AWS_ACCESS_KEY_ID_HERE>
            - name: AWS_SECRET_ACCESS_KEY
              value: <AWS_SECRET_ACCESS_KEY_HERE>
            - name: AWS_SESSION_TOKEN
              value: ""
      bbtests:
        enabled: false # set to `true` to enable bbtests
      bb-common:
        routes:
    inbound:
      aws:
        enabled: true
        gateways:
          - istio-gateway/public-ingressgateway
        hosts:
          - < use ../fetch_aws_ip_list.sh to generate values>
        service: karpenter
        port: 443
        selector:
          app.kubernetes.io/name: karpenter
        networkPolicies:
          egress:
            from:
              karpenter:
                to:
                  cidr:
                   < use ../fetch_aws_ip_list.sh to generate values>
```

**Important:** Do not commit this file with real credentials. Add it to `.gitignore` or keep it outside the repository.

## Deploying with Development Overrides

Once you have created your `karpenter-dev-overrides.yaml` file with credentials, deploy from your local Big Bang repository using:

```bash
helm upgrade -i bigbang chart/ -n bigbang --create-namespace \
    --set registryCredentials.username=${REGISTRY1_USERNAME} \
    --set registryCredentials.password="${REGISTRY1_TOKEN}" \
    -f ./tests/test-values.yaml \
    -f ./chart/ingress-certs.yaml \
    -f karpenter-dev-overrides.yaml
```

## Merge Request Requirements

**Important:** When creating a Merge Request for Karpenter changes, add the `disable-ci` label to your MR. This is required because Karpenter requires AWS credentials with read access to the `bb-development-eks` cluster for testing with k3d-dev, which are not available in the standard CI environment.

# Files that require bigbang integration testing

### See [bb MR testing](./docs/test-package-against-bb.md) for details regarding testing changes against bigbang umbrella chart

There are certain integrations within the bigbang ecosystem and this package that require additional testing outside of the specific package tests ran during CI.  This is a requirement when files within those integrations are changed, as to avoid causing breaks up through the bigbang umbrella.  Currently, these include changes to the istio implementation within the package (see: [istio templates](../chart/values.yaml#L26), [network policy templates](../chart/values.yaml#L54), [service entry templates](../chart/values.yaml#L39)).

Be aware that any changes to files listed in the [Modifications made to upstream chart](#modifications-made-to-upstream-chart) section will also require a codeowner to validate the changes using above method, to ensure that they do not affect the package or its integrations adversely.

Be sure to also test against monitoring locally as it is integrated by default with these high-impact service control packages, and needs to be validated using the necessary chart values beneath `istio.hardened` block with `monitoring.enabled` set to true as part of your dev-overrides as noted in [Deploying with Development Overrides](#deploying-with-development-overrides).

# How to upgrade the Package chart

BigBang makes modifications to the upstream helm chart. The full list of changes is at the end of  this document.

1. Read release notes from upstream [Karpenter](https://github.com/aws/karpenter-provider-aws/tree/main/charts/karpenter). Be aware of changes that are included in the upgrade, you can find those by [comparing the current and new revision Karpenter](). Take note of any manual upgrade steps that customers might need to perform, if any.
1. Do diff of [upstream chart Karpenter](https://github.com/aws/karpenter-provider-aws/tree/main/charts/karpenter) between old and new release tags to become aware of any significant chart changes. A graphical diff tool such as [Meld](https://meldmerge.org/) is useful.
1. Create a development branch and merge request tied to the Repo1 issue created for the package upgrade.  The association between the branch and the issue can be made by prefixing the branch name with the issue number, e.g. `56-update-package`. DO NOT create a branch if working `renovate/ironbank`. Continue edits on `renovate/ironbank`.
1. Update the upstream chart dependency in `/chart/Chart.yaml` to the new version. The upstream chart is managed as a subchart dependency using the passthrough pattern.
1. Delete all the `/chart/charts/*.tgz` files and the `/chart/Chart.lock`. You will replace these files in the next step.
1. In `/chart/Chart.yaml` update the gluon library to the latest version.
1. Run a helm dependency command to update the `chart/charts/*.tgz` archives and create a new Chart.lock file. You will commit the tar archives along with the Chart.lock that was generated.

    ```bash
    helm dependency update ./chart
    ```

1. In `/chart/values.yaml` update all the image tags to the new version.
1. Update `/CHANGELOG.md` with an entry for "upgrade to app version X.X.X chart version X.X.X-bb.X". Or, whatever description is appropriate.
1. Update the `/README.md` following the [gluon library script](https://repo1.dso.mil/platform-one/big-bang/apps/library-charts/gluon/-/blob/master/docs/bb-package-readme.md).
1. Update `/chart/Chart.yaml` to the appropriate versions. The annotation version should match the `appVersion`.

    ```yaml
    version: X.X.X-bb.X
    appVersion: X.X.X
    annotations:
      dev.bigbang.mil/applicationVersions: |
        - Karpenter: X.X.X
    ```

1. Update `annotations.helm.sh/images` section in `/chart/Chart.yaml` to fix references to updated packages (if needed).
1. Use a development environment to deploy and test. See more detailed testing instructions below. Also test an upgrade by deploying the old version first and then deploying the new version.
1. Update the `/README.md` and `/CHANGELOG.md` again if you have made any additional changes during the upgrade/testing process.

# Testing new version

1. Follow the [Development Override for Testing](#development-override-for-testing) section above to create your `karpenter-dev-overrides.yaml` file with AWS credentials.
1. Deploy Karpenter using the [Deploying with Development Overrides](#deploying-with-development-overrides) command from your local Big Bang repository.
1. Verify the Karpenter Helm release is successful:

    ```bash
    kubectl get helmrelease -n bigbang karpenter
    ```

   The output should show the release as `Ready`.

1. Verify Karpenter pods are running and ready:

    ```bash
    kubectl get pods -n bigbang -l app.kubernetes.io/name=karpenter
    ```

   All pods should be in `Running` status with all containers ready as well as no errors in the container logs.

1. Perform a manual upgrade test. First deploy the current version. Then deploy your development branch. Verify that the upgrade is successful and that the Karpenter Helm release and pods remain healthy.
1. Retest with monitoring and logging enabled. Verify that the logging and monitoring are working.

# Modifications made to upstream chart

This is a high-level list of modifications that Big Bang has made to the upstream helm chart. You can use this as as cross-check to make sure that no modifications were lost during the upgrade process.

## chart/templates/bigbang/*

Everything under this directory is a modification to the upstream chart.  The files are modified to work with the Big Bang umbrella chart.  The files are also modified to work with the Istio service mesh.  The Istio modifications are not upstreamed to the original chart.

- `dashboards` - Grafana dashboards.  This is a low-impact integration.

- `tests/` - Validation tetss

- Karpenter: Add more files here
