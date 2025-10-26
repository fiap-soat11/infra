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

variable "dns_eks" {
  description = "DNS do LoadBalancer do Service no EKS"
  type        = string
}

variable "regionDefault" {
  type = string
}
