output "TG_arn" {
    value = aws_lb_target_group.jenkinsTG[*].arn
}