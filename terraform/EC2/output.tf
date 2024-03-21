
output "instance_id" {
    value = aws_instance.jenkins.id
}

output "instance_public_ip" {
    value = aws_instance.jenkins.public_ip
}

output "ec2_key" {

    value = aws_key_pair.key_pair.id
    #aws_key_pair.key_pair.key_name
}


