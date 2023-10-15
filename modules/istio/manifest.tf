resource "kubernetes_manifest" "kiali_gateway" {
  count = var.manifest_run == true ? 1 : 0
  depends_on = [
    helm_release.istio_base,
    helm_release.istiod,
    helm_release.istio_ingress
  ]
  manifest = {
    "apiVersion" = "networking.istio.io/v1alpha3"
    "kind"       = "Gateway"
    "metadata" = {
      "name"      = "kiali-gateway"
      "namespace" = "istio-system"
    }
    "spec" = {
      "selector" = {
        "istio" = "ingressgateway"
      }
      "servers" = [
        {
          "hosts" = [
            var.kiali_virtual_service_host,
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
}

resource "kubernetes_manifest" "kiali_virtual_service" {
  count = var.manifest_run == true ? 1 : 0
  depends_on = [
    helm_release.istio_base,
    helm_release.istiod,
    helm_release.istio_ingress
  ]
  manifest = {
    "apiVersion" = "networking.istio.io/v1alpha3"
    "kind"       = "VirtualService"
    "metadata" = {
      "name"      = "kiali"
      "namespace" = "istio-system"
    }
    "spec" = {
      "gateways" = [
        "kiali-gateway",
      ]
      "hosts" = [
        var.kiali_virtual_service_host,
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
                "host" = "kiali"
                "port" = {
                  "number" = 20001
                }
              }
            },
          ]
        },
      ]
    }
  }
}
