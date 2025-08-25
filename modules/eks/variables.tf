variable "regionDefault" {
  type = string
}

variable "projectName" {
  type = string
}

variable "labRole" {
  type = string
}

variable "accessConfig" {
  type = string
}

variable "principalArn" {
  type = string
}

variable "policyArn" {
  type = string
}

variable "nodeGroup" {
  type = string
}

variable "instanceType" {
  type = string
}

variable "aws_subnets" {
  type = list(object({
    vpc_id     = string
    cidr_block = string
  }))
}