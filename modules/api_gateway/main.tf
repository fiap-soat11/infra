resource "aws_api_gateway_rest_api" "fiap_api_gateway" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "fiap-api-gateway"
      version = "1.0"
    }
    paths = {
      "/lambda" = {
        post = {
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            type                 = "AWS_PROXY"
            uri                  = var.uri_lambda
            payloadFormatVersion = "1.0"
          }
        }
      }
      "/eks/{proxy+}" = {
        "x-amazon-apigateway-any-method" = {
          x-amazon-apigateway-integration = {
            httpMethod           = "ANY"
            type                 = "HTTP_PROXY"
            # Usa a variável passada pelo Actions
            uri                  = "http://${var.dns_eks}/{proxy}"
            payloadFormatVersion = "1.0"
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