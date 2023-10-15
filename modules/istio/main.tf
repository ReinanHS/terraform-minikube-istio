# helm repo add istio https://istio-release.storage.googleapis.com/charts
# helm repo update
# helm install my-istio-base-release -n istio-system --create-namespace istio/base --set global.istioNamespace=istio-system
resource "helm_release" "istio_base" {
  name = "my-istio-base-release"

  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "base"
  namespace        = "istio-system"
  create_namespace = true
  version          = var.istio_version
  wait             = false

  set {
    name  = "global.istioNamespace"
    value = "istio-system"
  }
}

# helm repo add istio https://istio-release.storage.googleapis.com/charts
# helm repo update
# helm install my-istiod-release -n istio-system --create-namespace istio/istiod --set telemetry.enabled=true --set global.istioNamespace=istio-system
resource "helm_release" "istiod" {
  name = "my-istiod-release"

  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "istiod"
  namespace        = "istio-system"
  create_namespace = true
  version          = var.istio_version
  wait             = false

  set {
    name  = "telemetry.enabled"
    value = "true"
  }

  set {
    name  = "global.istioNamespace"
    value = "istio-system"
  }

  set {
    name  = "meshConfig.ingressService"
    value = "istio-gateway"
  }

  set {
    name  = "meshConfig.ingressSelector"
    value = "gateway"
  }

  depends_on = [helm_release.istio_base]
}

# helm repo add istio https://istio-release.storage.googleapis.com/charts
# helm repo update
# helm install gateway -n istio-ingress --create-namespace istio/gateway
resource "helm_release" "istio_ingress" {
  name             = "istio-ingressgateway"
  chart            = "gateway"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  namespace        = "istio-system"
  create_namespace = true
  wait             = false

  version = var.istio_version

  set {
    name  = "service.type"
    value = "NodePort"
  }

  set {
    name  = "autoscaling.minReplicas"
    value = var.istio_ingress_min_pods
  }

  set {
    name  = "autoscaling.maxReplicas"
    value = var.istio_ingress_max_pods
  }

  set {
    name  = "service.ports[0].name"
    value = "status-port"
  }

  set {
    name  = "service.ports[0].port"
    value = 15021
  }

  set {
    name  = "service.ports[0].targetPort"
    value = 15021
  }

  set {
    name  = "service.ports[0].nodePort"
    value = 30021
  }

  set {
    name  = "service.ports[0].protocol"
    value = "TCP"
  }


  set {
    name  = "service.ports[1].name"
    value = "http2"
  }

  set {
    name  = "service.ports[1].port"
    value = 80
  }

  set {
    name  = "service.ports[1].targetPort"
    value = 80
  }

  set {
    name  = "service.ports[1].nodePort"
    value = 30080
  }

  set {
    name  = "service.ports[1].protocol"
    value = "TCP"
  }


  set {
    name  = "service.ports[2].name"
    value = "https"
  }

  set {
    name  = "service.ports[2].port"
    value = 443
  }

  set {
    name  = "service.ports[2].targetPort"
    value = 443
  }

  set {
    name  = "service.ports[2].nodePort"
    value = 30443
  }

  set {
    name  = "service.ports[2].protocol"
    value = "TCP"
  }

  depends_on = [
    helm_release.istio_base,
    helm_release.istiod,
  ]
}

resource "helm_release" "kiali-server" {
  name             = "kiali-server"
  chart            = "kiali-server"
  repository       = "https://kiali.org/helm-charts"
  namespace        = "istio-system"
  create_namespace = true
  wait             = false

  version = "1.67.0"

  set {
    name  = "server.web_fqdn"
    value = "kiali.k8s.raj.ninja"
  }

  set {
    name  = "auth.strategy"
    value = "anonymous"
  }

  set {
    name  = "external_services.tracing.enabled"
    value = true
  }

  set {
    name  = "external_services.tracing.in_cluster_url"
    value = "http://jaeger-query.jaeger.svc.cluster.local:80"
  }

  set {
    name  = "external_services.tracing.use_grpc"
    value = false
  }

  set {
    name  = "external_services.prometheus.url"
    value = "http://prometheus-kube-prometheus-prometheus.prometheus.svc.cluster.local:9090"
  }

  set {
    name  = "external_services.grafana.enabled"
    value = true
  }

  set {
    name  = "external_services.grafana.url"
    value = "http://prometheus-grafana.prometheus.svc.cluster.local:80"
  }

  depends_on = [
    helm_release.istio_base,
    helm_release.istiod,
    helm_release.istio_ingress
  ]
}
