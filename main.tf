module "vpc" {
  source = "./modules/vpc"
}

#module "lambda" {
#  source        = "./modules/lambda"
#  ami           = "ami-123456"
#  instance_type = "t2.micro"
#}

module "eks" {
  source        = "./modules/eks"
  projectName   = var.projectName
  regionDefault = var.regionDefault
  labRole      = var.labRole
  accessConfig = var.accessConfig
  policyArn    = var.policyArn
  principalArn = var.principalArn
  nodeGroup    = var.nodeGroup
  instanceType = var.instanceType
  aws_subnets = [ module.vpc.aws_subnet.eks1,
                  module.vpc.aws_subnet.eks2,
                  module.vpc.aws_subnet.eks3 ]
}

#module "api_gateway" {
#  source = "./modules/api_gateway"
#}

