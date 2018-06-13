#!/usr/bin/env bash

echo "Usage:"
echo "curl https://....../check-cluster-health.sh | bash"
echo ""

COMMANDS=(
  "kubectl cluster-info"
  "kubectl get componentstatuses"
  "kubectl get nodes"
  "kubectl get pods -n kube-system"
);

for cmd in "${COMMANDS[@]}"; do
  echo ""
  echo "========== Executing: $cmd =========="
  echo ""
  $cmd || :
done