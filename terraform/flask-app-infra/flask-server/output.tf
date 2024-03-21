
output "flask-instance_id" {
    value = aws_instance.flask-server_tf.id
}



output "flask_server_private_ip" {

    value = aws_instance.flask-server_tf.private_ip 
}

