
module "networking" {

    source = "./networking"
    vpc_cidr = var.vpc_cidr
    public_subnet_cidr = var.public_subnet_cidr
    public_subnet_names = var.public_subnet_names
    private_subnet_cidr = var.private_subnet_cidr
    private_subnet_names= var.private_subnet_names
    availability_zone = var.availability_zone

}

module "securitygroup" {

    source = "./securitygroup"
    vpc_id = module.networking.X_VPC_ID
}

module "Jenkins_server" {
    source = "./EC2"
    ami_id = var.ami_id
    Sg_id = [module.securitygroup.SG_ID]
    instance_type = var.instance_type 
    instance_name = var.instance_name
    subnet_id = module.networking.first_subnet_id[0]
    user_data_install_jenkins = <<-EOF
              ${file("./jenkins-script/jenkins.sh")}
    EOF

}


module "TG" {
 
   source = "./targetGroup"
   #name = "JenkinsfirstTG"
   #port = 8080
   #protocol = "HTTP"
   vpc_id = module.networking.X_VPC_ID
   instance_id = [module.Jenkins_server.instance_id ,module.flask_server.flask-instance_id] #module.Jenkins_server.instance_id

   

}

#Sg_id  subnet_id  target_group_arn module.LoadBalancer
module "LoadBalancer" {
    source = "./load-balancer"
    Sg_id = [module.securitygroup.LB_SG_managed]
    #Sg_id = [module.securitygroup.SG_ID, module.flask_server_SG.Flask_SG_ID]
    subnet_id = module.networking.first_subnet_id
    target_group_arn = module.TG.TG_arn
    #target_group_arn
}


module "flask_server_SG" {

    source = "./flask-app-infra/SG"
    vpc_id = module.networking.X_VPC_ID
}


module "flask_server" {

    source = "./flask-app-infra/flask-server"
    Sg_id = [module.flask_server_SG.Flask_SG_ID]
    subnet_id = module.networking.private_subnet_id[0]
    key_name = module.Jenkins_server.ec2_key
    ami_id = "ami-0a0409af1cb831414"
    user_data_install_docker = <<-EOF
              ${file("./docker-script/docker-installation.sh")}
    EOF
    type = "t3.medium"

}

#module "RDs" {

#    source = "./flask-app-infra/rds"
#    subnet_id = module.networking.private_subnet_id[*]

#}







