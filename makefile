pods:
	kubectl get pods -n istio-system
	kubectl get pods -n jaeger
	kubectl get pods -n prometheus
kiali:
	kubectl port-forward svc/kiali 20001 -n istio-system
jaeger:
	kubectl port-forward svc/jaeger-query 16686:80 -n jaeger