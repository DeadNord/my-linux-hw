output "vpc_id" {
  description = "ID VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "ID усіх public-subnet"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "ID усіх private-subnet"
  value       = aws_subnet.private[*].id
}

output "nat_gateway_id" {
  description = "Єдиний NAT Gateway"
  value       = aws_nat_gateway.this.id
}
