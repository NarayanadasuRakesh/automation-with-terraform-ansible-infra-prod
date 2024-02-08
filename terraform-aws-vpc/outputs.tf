output "az" {
  value = data.aws_availability_zones.az.names
}

output "allocated_az" {
  value = slice(data.aws_availability_zones.az.names,0,2)
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  value = aws_subnet.database[*].id
}
