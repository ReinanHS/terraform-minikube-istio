variable "istio_version" {
    type = string
    default = "1.17.1"
}

variable "istio_ingress_min_pods" {
  type        = number
  default     = 3
  description = "Minimum pods for istio-ingress-gateway"
}

variable "istio_ingress_max_pods" {
  type        = number
  default     = 9
  description = "Maximum pods for istio-ingress-gateway"
}

variable "kiali_virtual_service_host" {
  type    = string
  default = "kiali.k8s.raj.ninja"
}

variable "manifest_run" {
  type = bool
  default = false
}