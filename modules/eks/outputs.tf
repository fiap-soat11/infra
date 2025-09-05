output "dns_eks" {
  value = aws_lb.eks_lb.dns_name
}