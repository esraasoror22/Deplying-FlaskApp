
#create Application loadbalancer
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.Sg_id
  subnets            = var.subnet_id

  #enable_deletion_protection = true

}

resource "aws_lb_listener" "front_end" {
  count = 2
  load_balancer_arn = aws_lb.test.arn
  port              = var.port[count.index]
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn[count.index]
  }
}

#resource "aws_lb_target_group_attachment" "JenkinsloadBalancer" {
#  target_group_arn = var.targetgroup_arn
#  target_id        = var.instance_id
#  port             = 8080
#}

#aws_lb_target_group_attachment.JenkinsloadBalancer.dns_name
#targetgroup_arn  instance_id
