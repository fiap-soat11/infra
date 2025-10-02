data "aws_vpc" "vpc" {
  cidr_block = "172.31.0.0/16"
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
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
data "aws_lambda_function" "fiap-auth" {
  function_name = "fiap-auth"
}
data "aws_lambda_function" "fiap-login" {
  function_name = "fiap-login"
}


locals {
  fiap_lambda_config = {
    name          = data.aws_lambda_function.fiap-lambda.function_name
    function_name = data.aws_lambda_function.fiap-lambda.function_name
    arn           = data.aws_lambda_function.fiap-lambda.arn
    invoke_arn    = data.aws_lambda_function.fiap-lambda.invoke_arn
  }

  fiap_auth_config = {
    name          = data.aws_lambda_function.fiap-auth.function_name
    function_name = data.aws_lambda_function.fiap-auth.function_name
    arn           = data.aws_lambda_function.fiap-auth.arn
    invoke_arn    = data.aws_lambda_function.fiap-auth.invoke_arn
  }

  fiap_login_config = {
    name          = data.aws_lambda_function.fiap-login.function_name
    function_name = data.aws_lambda_function.fiap-login.function_name
    arn           = data.aws_lambda_function.fiap-login.arn
    invoke_arn    = data.aws_lambda_function.fiap-login.invoke_arn
  }
}
