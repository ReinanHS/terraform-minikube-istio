variable "grafana_virtual_service_host" {
  type    = string
  default = "grafana.k8s.raj.ninja"
}

variable "manifest_run" {
  type = bool
  default = false
}