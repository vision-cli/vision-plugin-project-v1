#!/bin/bash

if [ "$(docker inspect -f '{{.State.Running}}' "kind-pg" 2>/dev/null || true )" != 'true' ]; then
  docker run -d -p "5432:5432" --name "kind-pg" --env-file=config/env.postgres postgres:alpine 2>/dev/null || docker start kind-pg
fi

[ "$(docker inspect -f '{{.State.Status}}' "kind-control-plane" 2>/dev/null || true )" = 'running' ] && (
if [ "$(grep 'dockerhost' <(kubectl get svc -n external 2>/dev/null) || false )" ]
then
  kubectl rollout restart deploy dockerhost -n external
else
  kubectl apply -f config/dockerhost.yml
fi
) || true
