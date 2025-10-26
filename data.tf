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

data "aws_lambda_function" "users_service_lambda" {
  function_name = "users_service_lambda"
}
data "aws_lambda_function" "users_service_authorizer" {
  function_name = "users_service_authorizer"
}
data "aws_lambda_function" "users_service_login" {
  function_name = "users_service_login"
}


locals {
  fiap_lambda_config = {
    name          = data.aws_lambda_function.users_service_lambda.function_name
    function_name = data.aws_lambda_function.users_service_lambda.function_name
    arn           = data.aws_lambda_function.users_service_lambda.arn
    invoke_arn    = data.aws_lambda_function.users_service_lambda.invoke_arn
  }

  fiap_auth_config = {
    name          = data.aws_lambda_function.users_service_authorizer.function_name
    function_name = data.aws_lambda_function.users_service_authorizer.function_name
    arn           = data.aws_lambda_function.users_service_authorizer.arn
    invoke_arn    = data.aws_lambda_function.users_service_authorizer.invoke_arn
  }

  fiap_login_config = {
    name          = data.aws_lambda_function.users_service_login.function_name
    function_name = data.aws_lambda_function.users_service_login.function_name
    arn           = data.aws_lambda_function.users_service_login.arn
    invoke_arn    = data.aws_lambda_function.users_service_login.invoke_arn
  }
}
