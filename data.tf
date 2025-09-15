data "aws_vpc" "vpc" {
  cidr_block = "172.31.0.0/16"
}

data "aws_subnets" "subnets"{
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.vpc.id]
    }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}

data "aws_lambda_function" "fiap-lambda" {
  function_name = "fiap-lambda"
}

data "aws_lambda_function_url" "fiap_lambda_url" {
  function_name = data.aws_lambda_function.fiap-lambda.function_name
}