
output "app_lb_dns" {

    value = aws_lb.test.dns_name  
}

