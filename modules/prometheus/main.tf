resource "helm_release" "prometheus" {
  name             = "prometheus"
  chart            = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  namespace        = "prometheus"
  create_namespace = true
  wait             = false

  version = "45.8.0"

  values = [
    "${file("./modules/prometheus/values.yml")}"
  ]
}
