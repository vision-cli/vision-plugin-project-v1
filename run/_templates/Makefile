cilium-install-cli:
	./scripts/install_cilium_cli.sh

hubble-install-cli:
	./scripts/install_hubble_cli.sh

cilium-deploy:
	./scripts/install_cilium.sh

cilium-remove:
	./scripts/uninstall_cilium.sh

pg-local:
	./scripts/create_local_pg.sh

cluster-local:
	./scripts/create_local_cluster.sh
	./scripts/create_local_pg.sh

apply-network-policy:
	kubectl create -f config/ciliumNetworkPolicy.yml

prometheus-deploy:
	kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/HEAD/examples/kubernetes/addons/prometheus/monitoring-example.yaml

prometheus-remove:
	kubectl delete -f https://raw.githubusercontent.com/cilium/cilium/HEAD/examples/kubernetes/addons/prometheus/monitoring-example.yaml

grafana-port-forward:
	kubectl -n cilium-monitoring port-forward service/grafana --address 0.0.0.0 --address :: 3000:3000

cert-manager-deploy:
	kubectl apply -k github.com/cilium/kustomize-bases/cert-manager

cert-manager-status:
	./scripts/cert-manager-status.sh

jaeger-operator-deploy:
	kubectl apply -k github.com/cilium/kustomize-bases/jaeger

jaeger-operator-remove:
	kubectl delete -k github.com/cilium/kustomize-bases/jaeger

jaeger-deploy:
	kubectl apply -f config/jaeger.yml

jaeger-remove:
	kubectl delete -f config/jaeger.yml

jaeger-port-forward:
	kubectl port-forward svc/jaeger-default-query -n jaeger 16686

opentelemetry-operator-deploy:
	kubectl apply -k github.com/cilium/kustomize-bases/opentelemetry

opentelemetry-operator-remove:
	kubectl delete -k github.com/cilium/kustomize-bases/opentelemetry

opentelemetry-collector-deploy:
	kubectl apply -f config/otelcol.yml

opentelemetry-collector-remove:
	kubectl delete -f config/otelcol.yml

opentelemetry-collector-status:
	kubectl get pod -n kube-system -l app.kubernetes.io/name=otelcol-hubble-collector

opentelemetry-collector-logs:
	kubectl logs -n kube-system -l app.kubernetes.io/name=otelcol-hubble-collector

