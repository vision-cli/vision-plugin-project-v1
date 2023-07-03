#!/bin/bash

cilium install --kube-proxy-replacement=strict \
--helm-set ingressController.enabled=true \
--helm-set prometheus.enabled=true \
--helm-set operator.prometheus.enabled=true \
--helm-set hubble.metrics.enabled="{dns,drop,tcp,flow,icmp,http}"


cilium status --wait
cilium hubble enable --ui
echo '⌛ Waiting for hubble-relay and hubble-ui...'
# if resources don't exist yet, wait will error. Keep looping to pass checks
while ! kubectl wait -n kube-system --for=condition=ready pods -l 'k8s-app in (hubble-relay, hubble-ui)' --timeout=120s; do sleep 1; done
cilium hubble port-forward&
hubble status
cilium hubble ui
