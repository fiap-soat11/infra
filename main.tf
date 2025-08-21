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
}

module "api_gateway" {
  source = "./modules/api_gateway"
}

