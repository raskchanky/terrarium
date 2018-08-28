#!/bin/bash

set -euo pipefail

usage() {
  echo "Usage: create-builder-docker-images.sh <BUILDER_DIRECTORY>"
  exit 1
}

if [ -z "${1:-}" ]; then
  usage
fi

builder_dir="$1"
components=(api api-proxy datastore jobsrv originsrv router sessionsrv worker minio)

pushd "$builder_dir"

for component in "${components[@]}"
do
  HAB_ORIGIN=habitat hab pkg build --reuse "./components/builder-$component"
  hart=$(cat ./results/last_build.env | grep pkg_artifact | awk -F "=" '{ print $2 }')
  hab pkg export docker --no-push-image "./results/$hart"
done

popd
