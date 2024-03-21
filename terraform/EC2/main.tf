
resource "aws_instance" "jenkins" {
  ami = var.ami_id
  vpc_security_group_ids = var.Sg_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  associate_public_ip_address = true
  key_name = aws_key_pair.key_pair.key_name # private key
  user_data = var.user_data_install_jenkins

  provisioner "file" {
    source      = "./linux-key-pair-x.pem"
    destination = "/home/ubuntu/linux-key-pair-xyz.pem"
  }

  

  tags = {
    Name = var.instance_name
  }

  depends_on = [aws_key_pair.key_pair]
}



#create public && private key
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create the Key Pair {this step gets public key that will stored on .ssh/authorized_keys}
resource "aws_key_pair" "key_pair" {
  key_name   = "linux-key-pair-x" #private key
  public_key = tls_private_key.private_key.public_key_openssh
}

# Save file store private key that used when ssh to machine local
resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.key_pair.key_name}.pem"
  content  = tls_private_key.private_key.private_key_pem
}

