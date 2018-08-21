#!/bin/bash

set -xeuo pipefail
for container in $(docker ps --filter name=terrarium --format '{{.Names}}'); do
    docker logs "${container}" > "data/${container}_stdout.txt"
done
