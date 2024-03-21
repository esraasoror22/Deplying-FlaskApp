
output "SG_ID" {
    value = aws_security_group.SG.id
}


output "LB_SG_managed" {

    value = aws_security_group.LB_SG.id
}