#!/bin/bash

if [ "$(docker inspect -f '{{.State.Running}}' "kind-registry" 2>/dev/null || true )" != 'true' ]; then
  docker run -d --restart=always -p "127.0.0.1:8081:5000" --name "kind-registry" registry:2
fi

kind create cluster --config config/kind-registry.yml

if [ "$(docker inspect -f='{{json .NetworkSettings.Networks.kind}}' "kind-registry")" = 'null' ]; then
  docker network connect "kind" "kind-registry"
fi
