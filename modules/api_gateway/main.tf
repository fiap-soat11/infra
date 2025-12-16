resource "aws_api_gateway_rest_api" "fiap_api_gateway" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "fiap-api-gateway"
      version = "1.0"
    }
    paths = {
      "/lambda" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            type                 = "AWS"
            uri                  = "arn:aws:apigateway:${var.regionDefault}:lambda:path/2015-03-31/functions/${var.fiap_lambda.arn}/invocations"
            requestTemplates     = {
               "application/json" = "$input.body"
            }
            payloadFormatVersion = "1.0"
          }
        }
      }
     "/login" = {
        post = {
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            type                 = "AWS"
            uri                  = "arn:aws:apigateway:${var.regionDefault}:lambda:path/2015-03-31/functions/${var.fiap_login.arn}/invocations"
            requestTemplates     = {
               "application/json" = "$input.body"
            }
            payloadFormatVersion = "1.0"
            
            responses = {
              default = {
                statusCode = "200"
                responseTemplates = {
                  "application/json" = ""
                }
              }
            }
          }
          
          responses = {
            "200" = {
              description = "Retorna o token JWT"
            }
          }
        }
      }
      "/auth" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            type                 = "AWS"
            uri                  = "arn:aws:apigateway:${var.regionDefault}:lambda:path/2015-03-31/functions/${var.fiap_auth.arn}/invocations"
            requestTemplates     = {
               "application/json" = "$input.body"
            }
            payloadFormatVersion = "1.0"
          }
        }
      }
      "/eks/pedido/{proxy+}" = {
        "x-amazon-apigateway-any-method" = {
          x-amazon-apigateway-integration = {
            httpMethod           = "ANY"
            type                 = "HTTP_PROXY"
            uri                  = "http://${var.dns_eks_pedido}/{proxy}"
            payloadFormatVersion = "1.0"
            requestParameters = {
              "integration.request.path.proxy" = "method.request.path.proxy"
            }
          }
          requestParameters = {
            "method.request.path.proxy" = true
          }
        }
      }
      "/eks/pagamento/{proxy+}" = {
        "x-amazon-apigateway-any-method" = {
          x-amazon-apigateway-integration = {
            httpMethod           = "ANY"
            type                 = "HTTP_PROXY"
            uri                  = "http://${var.dns_eks_pagamento}/{proxy}"
            payloadFormatVersion = "1.0"
            requestParameters = {
              "integration.request.path.proxy" = "method.request.path.proxy"
            }
          }
          requestParameters = {
            "method.request.path.proxy" = true
          }
        }
      }
      "/eks/preparo/{proxy+}" = {
        "x-amazon-apigateway-any-method" = {
          x-amazon-apigateway-integration = {
            httpMethod           = "ANY"
            type                 = "HTTP_PROXY"
            uri                  = "http://${var.dns_eks_preparo}/{proxy}"
            payloadFormatVersion = "1.0"
            requestParameters = {
              "integration.request.path.proxy" = "method.request.path.proxy"
            }
          }
          requestParameters = {
            "method.request.path.proxy" = true
          }
        }
      }
    }
  })

  name = "fiap-api-gateway"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "fiap_api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.fiap_api_gateway.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.fiap_api_gateway.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "fiap_api_gateway_stage" {
  deployment_id = aws_api_gateway_deployment.fiap_api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.fiap_api_gateway.id
  stage_name    = "fiap-api-gateway-stage"
}

resource "aws_lambda_permission" "allow_apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.fiap_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.fiap_api_gateway.execution_arn}/*/*/lambda"
}

resource "aws_lambda_permission" "allow_apigw_login" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.fiap_login.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.fiap_api_gateway.execution_arn}/*/*/login"
}

resource "aws_lambda_permission" "allow_apigw_auth" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.fiap_auth.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.fiap_api_gateway.execution_arn}/*/*/auth"
}