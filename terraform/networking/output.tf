output "X_VPC_ID" {

    value = aws_vpc.X_VPC.id
}

output "first_subnet_id" {
    value = aws_subnet.public_subnets[*].id
}

output "private_subnet_id" {

    value = aws_subnet.private_subnets[*].id
}

