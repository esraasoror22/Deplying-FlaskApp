resource "aws_instance" "flask-server_tf" {
  ami = var.ami_id #"ami-0a0409af1cb831414"
  vpc_security_group_ids = var.Sg_id
  instance_type = var.type #"t3.medium"
  subnet_id = var.subnet_id
  #associate_public_ip_address = true
  key_name = var.key_name # private key
  user_data = var.user_data_install_docker

  tags = {
    Name = "Flask-server"
  }
}

#ami_id  Sg_id var subnet_id key_name user_data_install_docker

