module "cert_manager" {
  source        = "terraform-iaac/cert-manager/kubernetes"

  cluster_issuer_email                   = "admin@mysite.com"
  cluster_issuer_name                    = "cert-manager-global"
  cluster_issuer_private_key_secret_name = "cert-manager-private-key"
}

module "istio" {
  source = "./modules/istio"
  depends_on = [ module.cert_manager ]
  manifest_run = var.manifest_run
}

module "jaeger" {
  source = "./modules/jaeger"
  depends_on = [ module.istio, module.cert_manager ]
  manifest_run = var.manifest_run
}

module "prometheus" {
  source = "./modules/prometheus"
  depends_on = [ module.istio ]
  manifest_run = var.manifest_run
}