#!/usr/bin/env bash
set -euo pipefail
OUT=./inventory
mkdir -p "$OUT"

echo "Collecting workloads..."
kubectl get deploy,sts,ds,job,cronjob -A -o wide > "$OUT/workloads.txt"
kubectl get ingress -A -o yaml > "$OUT/ingress.yaml" || true
kubectl get svc -A -o yaml > "$OUT/services.yaml"
kubectl get cm -A -o yaml > "$OUT/configmaps.yaml"
kubectl get secret -A -o yaml > "$OUT/secrets.yaml"
kubectl get pvc -A -o yaml > "$OUT/pvcs.yaml"
kubectl get sa -A -o yaml > "$OUT/serviceaccounts.yaml"
kubectl get ns --show-labels > "$OUT/namespaces.txt"

# images referenced by all pods
kubectl get pods -A -o jsonpath='{range .items[*]}{.spec.containers[*].image}{"\n"}{end}' \
  | tr ' ' '\n' | sort -u > "$OUT/images.txt"

echo "Inventory saved in $OUT/"