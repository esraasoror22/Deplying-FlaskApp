
#aws_security_group.SG
resource "aws_security_group" "SG" {
  # ... other configuration ...
  name = "SG_allow_SSH_Http_https_jenkins"
  vpc_id = var.vpc_id
  #how to get id of resource created on other module using output
  dynamic "ingress" {
    for_each = local.inbound_ports
    content{
        from_port       = ingress.value
        to_port         = ingress.value
        protocol        = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
  }
  egress {

    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

#Load balancer SG
#local.lb_inbound_rules
resource "aws_security_group" "LB_SG" {
  # ... other configuration ...
  name = "allow web ports"
  vpc_id = var.vpc_id
  #how to get id of resource created on other module using output
  dynamic "ingress" {
    for_each = local.lb_inbound_rules
    content{
        from_port       = ingress.value
        to_port         = ingress.value
        protocol        = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
  }
  egress {

    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}



