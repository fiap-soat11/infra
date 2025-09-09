resource "aws_lambda_function" "fiap-lambda" {
  function_name = var.name
  role          = var.labRole
  package_type  = var.package_type
  #image_uri     = "${aws_ecr_repository.example.repository_url}:latest"
  image_uri     = var.image_uri

  #image_config {
  #  entry_point = ["/lambda-entrypoint.sh"]
  #  command     = ["app.handler"]
  #}

  memory_size = 512
  timeout     = 60

  architectures = ["x86_64"]
}

resource "aws_lambda_function_url" "fiap-lambda-url" {
  function_name      = aws_lambda_function.fiap-lambda.function_name
  authorization_type = "NONE"
}