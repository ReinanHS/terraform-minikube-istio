resource "helm_release" "jaeger" {
  name       = "jaeger"
  repository = "https://jaegertracing.github.io/helm-charts"
  chart      = "jaeger"
  namespace  = "jaeger"

  version          = "0.69.1"
  create_namespace = true
  wait             = false

  set {
    name  = "provisionDataStore.cassandra"
    value = "false"
  }

  set {
    name  = "storage.type"
    value = "memory"
  }

  set {
    name  = "agent.enabled"
    value = "true"
  }

  set {
    name  = "collector.enabled"
    value = "true"
  }

  set {
    name  = "query.enabled"
    value = "true"
  }
}
