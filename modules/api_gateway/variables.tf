variable "id" {
  type = string
  
}
variable "uri_lambda" {
  type        = string
}

variable "function_name" {
  type = string
}


variable "dns_eks" {
  description = "DNS do LoadBalancer do Service no EKS"
  type        = string
}

variable "regionDefault" {
  type = string
}
