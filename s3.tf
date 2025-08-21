

resource "aws_s3_bucket" "meu_bucket" {
  bucket = "fiap-soat-11-teste" 
  acl    = "private"
  
}