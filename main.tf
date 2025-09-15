module "lambda" {
  source        = "./modules/lambda"
  name = "fiap-lambda"
  labRole      = "arn:aws:iam::${var.id}:role/LabRole"
  image_uri   = "${var.id}.dkr.ecr.${var.regionDefault}.amazonaws.com/fiap-lambda:latest"
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
  id = var.id
  uri_lambda = data.aws_lambda_function.fiap-lambda.arn
  function_name = data.aws_lambda_function.fiap-lambda.function_name
  regionDefault = var.regionDefault
  dns_eks   = ""
}

