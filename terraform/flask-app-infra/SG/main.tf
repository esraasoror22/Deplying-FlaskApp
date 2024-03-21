#aws_security_group.SG aws_security_group.Flask_SG
resource "aws_security_group" "Flask_SG" {
  # ... other configuration ...
  name = "allow_flask_port"
  vpc_id = var.vpc_id
  #how to get id of resource created on other module using output
  
   dynamic "ingress" {
        for_each = local.input_ports
        content{
            from_port       = ingress.value
            to_port         = ingress.value
            protocol        = "tcp"
            cidr_blocks = ["10.0.0.0/16"]
        }
    
    }
  egress {

    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}