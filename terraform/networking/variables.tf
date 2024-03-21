variable "vpc_cidr" {}
variable "public_subnet_cidr" {

    type = list(string)

}

variable public_subnet_names {

    type = list(string)
}

variable "private_subnet_cidr" {}
variable "private_subnet_names" {}
variable "availability_zone" {}