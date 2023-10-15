variable "jaeger_virtual_service_host" {
  type    = string
  default = "jaeger.k8s.raj.ninja"
}

variable "manifest_run" {
  type = bool
  default = false
}