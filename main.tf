module "lambda" {
  source        = "./modules/lambda"
  name = "fiap-lambda"
  labRole      = "arn:aws:iam::${var.id}:role/LabRole"
  image_uri   = module.ecr.repository_url
  package_type = "Image"
  
}

module "eks" {
  source        = "./modules/eks"
  projectName   = var.projectName
  regionDefault = var.regionDefault
  labRole      = "arn:aws:iam::${var.id}:role/LabRole"
  accessConfig = var.accessConfig
  policyArn    = var.policyArn
  principalArn = "arn:aws:iam::${var.id}:role/voclabs"
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

