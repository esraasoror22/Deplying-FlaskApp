
#
#variable "targetgroup_arn" {}  
#variable "instance_id" {}

variable "Sg_id" {
    type = list(string)
}
variable "subnet_id" {}
variable "target_group_arn" {
    
    type = list(string)
}


variable "port" {
    type = list(number)
    default = [80 , 4000]
}

#Sg_id  subnet_id  target_group_arn