resource "kubernetes_manifest" "grafana_gateway" {
  count = var.manifest_run == true ? 1 : 0
  manifest = {
    "apiVersion" = "networking.istio.io/v1alpha3"
    "kind"       = "Gateway"
    "metadata" = {
      "name"      = "grafana"
      "namespace" = "prometheus"
    }
    "spec" = {
      "selector" = {
        "istio" = "ingressgateway"
      }
      "servers" = [
        {
          "hosts" = [
            var.grafana_virtual_service_host,
          ]
          "port" = {
            "name"     = "http"
            "number"   = 80
            "protocol" = "HTTP"
          }
        },
      ]
    }
  }

  depends_on = [
    helm_release.prometheus
  ]
}

resource "kubernetes_manifest" "grafana_service" {
  count = var.manifest_run == true ? 1 : 0
  manifest = {
    "apiVersion" = "networking.istio.io/v1alpha3"
    "kind"       = "VirtualService"
    "metadata" = {
      "name"      = "grafana"
      "namespace" = "prometheus"
    }
    "spec" = {
      "gateways" = [
        "grafana",
      ]
      "hosts" = [
        var.grafana_virtual_service_host,
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
                "host" = "prometheus-grafana"
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
    helm_release.prometheus
  ]
}
