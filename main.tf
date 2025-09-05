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
  vpc_id       = data.aws_vpc.vpc.id
  aws_subnets = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.regionDefault}e"]
}

module "api_gateway" {
  source = "./modules/api_gateway"
  uri_lambda = module.lambda.uri_lambda
  dns_eks   = module.eks.dns_eks
}

