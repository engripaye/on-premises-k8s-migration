#!/usr/bin/env bash
set -euo pipefail
# Requires: podman/skopeo login to both source and OpenShift registry
SRC_IMAGE="$1"            # e.g. docker.io/library/nginx:1.25
DST_NS="$2"               # e.g. team-a
APP="$3"                  # e.g. sample-app

REG=$(oc get route default-route -n openshift-image-registry -o jsonpath='{.spec.host}')
DST="${REG}/${DST_NS}/${APP}:$(echo "$SRC_IMAGE" | tr ':/' '-')"

echo "Mirroring $SRC_IMAGE -> $DST"
skopeo copy docker://"$SRC_IMAGE" docker://"$DST" --all

# Create ImageStream (optional but recommended)
oc -n "$DST_NS" apply -f - <<YAML
apiVersion: image.openshift.io/v1
kind: ImageStream
metadata:
  name: ${APP}
YAML

oc -n "$DST_NS" tag "$DST" ${APP}:latest || true