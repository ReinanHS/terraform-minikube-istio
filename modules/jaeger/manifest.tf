resource "kubernetes_manifest" "jaeger_gateway" {
  count = var.manifest_run == true ? 1 : 0
  manifest = {
    apiVersion = "networking.istio.io/v1alpha3"
    kind       = "Gateway"
    metadata = {
      name      = "jaeger-query"
      namespace = "jaeger"
    }
    spec = {
      selector = {
        istio = "ingressgateway"
      }
      servers = [
        {
          port = {
            number   = 80
            name     = "http"
            protocol = "HTTP"
          }
          hosts = [
            var.jaeger_virtual_service_host
          ]
        }
      ]
    }
  }

  depends_on = [
    helm_release.jaeger
  ]
}


resource "kubernetes_manifest" "jaeger_virtual_service" {
  count = var.manifest_run == true ? 1 : 0
  manifest = {
    "apiVersion" = "networking.istio.io/v1alpha3"
    "kind"       = "VirtualService"
    "metadata" = {
      "name"      = "jaeger-query"
      "namespace" = "jaeger"
    }
    "spec" = {
      "gateways" = [
        "jaeger-query",
      ]
      "hosts" = [
        var.jaeger_virtual_service_host,
      ]
      "http" = [
        {
          "match" = [
            {
              "uri" = {
                "prefix" = "/"
              }
            },
          ]
          "route" = [
            {
              "destination" = {
                "host" = "jaeger-query"
                "port" = {
                  "number" = 80
                }
              }
            },
          ]
        },
      ]
    }
  }

  depends_on = [
    helm_release.jaeger
  ]
}
