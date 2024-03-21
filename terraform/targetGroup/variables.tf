
variable "name" {
    type = list(string)
    default = ["JenkinsTG" , "FlaskTG"]
}  
variable "port" {
    default = ["8080" , "5000"]
}
variable "protocol" {
    default = "HTTP"
}
variable "vpc_id" {}

variable "instance_id" {
    type = list(string)
}

variable "path" {
    type = list(string)
    default = ["/login" , "/"]
}

