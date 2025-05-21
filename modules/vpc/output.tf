output "vpc_id" {
  value = aws_vpc.alb-vpc.id
}

output "subnet_ids" {
  value = {
    a = aws_subnet.public_a.id
    b = aws_subnet.public_b.id
    c = aws_subnet.public_c.id 
  }
}