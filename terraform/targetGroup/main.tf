
#create target Group
resource "aws_lb_target_group" "jenkinsTG" {
  count = 2
  name = var.name[count.index]
  port =  var.port[count.index]
  protocol = var.protocol
  vpc_id   = var.vpc_id
   health_check {
    path =  var.path[count.index] #"/login"   #path to be accessed on instance
    port =  var.port[count.index]
     #8080 #port that service on instance running on
    healthy_threshold = 6 #The number of consecutive health checks successes required before considering an unhealthy target healthy.
    unhealthy_threshold = 2 #The number of consecutive health check failures required before considering a target unhealthy.

    timeout = 2 #The amount of time, in seconds, during which no response means a failed health check.

    interval = 5 #The approximate amount of time between health checks of an individual target

    matcher = "200" #The HTTP codes to use when checking for a successful response from a target. You can specify multiple values (for example, "200,202") or a range of values (for example, "200-299").

  }

}

#aws_lb_target_group.jenkins_TG.id

#target group attachment
resource "aws_alb_target_group_attachment" "test" {
  count = 2
  target_group_arn = aws_lb_target_group.jenkinsTG[count.index].arn
  target_id        = var.instance_id[count.index]
  port             = var.port[count.index]
}









