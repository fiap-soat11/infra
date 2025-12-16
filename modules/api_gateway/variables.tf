variable "id" {
  type = string
  
}
variable "fiap_lambda" {
  type        = object({
    function_name = string
    name = string
    arn = string 
  })
}

variable "fiap_auth" {
  type        = object({
    function_name = string
    name = string
    arn = string 
  })
}

variable "fiap_login" {
  type        = object({
    function_name = string
    name = string
    arn = string 
  })
}

variable "dns_eks_pedido" {
  description = "DNS do LoadBalancer do Service Pedido no EKS"
  type        = string
}
variable "dns_eks_pagamento" {
  description = "DNS do LoadBalancer do Service Pagamento no EKS"
  type        = string
}
variable "dns_eks_preparo" {
  description = "DNS do LoadBalancer do Service Preparo no EKS"
  type        = string
}
variable "regionDefault" {
  type = string
}
