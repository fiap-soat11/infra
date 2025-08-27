output "vpc_id" {
  value = aws_vpc.main.id
}

output "aws_subnet_eks1" {
  value = aws_subnet.eks1
}
output "aws_subnet_eks2" {
  value = aws_subnet.eks2
}
output "aws_subnet_eks3" {
  value = aws_subnet.eks3
}