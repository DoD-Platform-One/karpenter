#!/bin/bash
set -ex

echo "-----------------------------------------"
echo "BEGIN Karpenter health check"
echo "-----------------------------------------"

echo "[+] Testing metrics endpoint..."
STATUS_CODE=$(curl -sf --write-out '%{http_code}' "${METRICS_URL}" -o /dev/null)
echo "Metrics endpoint status code: ${STATUS_CODE}"
if [ "${STATUS_CODE}" != "200" ]; then
  echo "FAIL: Metrics endpoint returned ${STATUS_CODE}, expected 200"
  exit 1
fi

echo "[+] Validating Karpenter build info from metrics..."
KARPENTER_VERSION=$(curl -sf "${METRICS_URL}" | grep -v '^#' | grep karpenter_build_info | head -1 | sed -n 's/.*version="\([^"]*\)".*/\1/p')
echo "Karpenter Version: ${KARPENTER_VERSION}"
if [ -z "${KARPENTER_VERSION}" ]; then
  echo "FAIL: Could not extract Karpenter version from metrics"
  exit 1
fi

echo "[+] Checking health endpoint via pod IP..."
KARPENTER_POD_IP=$(kubectl get pods -n "${K8S_NAMESPACE}" -l app.kubernetes.io/name=karpenter -o jsonpath='{.items[0].status.podIP}')
echo "Karpenter pod IP: ${KARPENTER_POD_IP}"
HEALTH_CODE=$(curl -sf --write-out '%{http_code}' "http://${KARPENTER_POD_IP}:8081/healthz" -o /dev/null)
echo "Health endpoint status code: ${HEALTH_CODE}"
if [ "${HEALTH_CODE}" != "200" ]; then
  echo "FAIL: Health endpoint returned ${HEALTH_CODE}, expected 200"
  exit 1
fi

echo "-----------------------------------------"
echo "END Karpenter health check - ALL PASSED"
echo "-----------------------------------------"
