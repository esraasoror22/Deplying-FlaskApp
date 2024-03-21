variable "vpc_cidr" {
    type = string
} 

variable "public_subnet_cidr"{

    type = list(string)
}  

variable "public_subnet_names"{

    type = list(string)

}

variable "private_subnet_cidr" {

    type = list(string)
}
variable "private_subnet_names" {
    type = list(string)
}

variable "availability_zone" {
    type = list(string)
}

variable "ami_id" {
    default = "ami-0a0409af1cb831414" 
      #"ami-0694d931cee176e7d" 
}
variable "instance_type"{
    default = "t3.medium"
}

variable "instance_name" {
    default = "Jenkins_server_AWS"
}

#variable "user_data_script" {}


