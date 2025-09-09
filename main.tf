module "lambda" {
  source        = "./modules/lambda"
  name = "fiap-lambda"
  labRole      = "arn:aws:iam::${var.id}:role/LabRole"
  image_uri   = "${var.id}.dkr.ecr.${var.regionDefault}.amazonaws.com/fiap-lambda@sha256:ff5673c87b712777e5c1b68d1ccc59e81ec2b074efae954305c3a28130d37313"
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
  dns_eks   = ""
}

