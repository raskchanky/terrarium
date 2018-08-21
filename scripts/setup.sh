#!/bin/bash

set -xeuo pipefail

for container in $(docker-compose config --services); do
    mkdir -p "data/${container}/hab-sup-default"
    cp CTL_SECRET "data/${container}/hab-sup-default"
    sudo chown root:root "data/${container}/hab-sup-default/CTL_SECRET"
done
