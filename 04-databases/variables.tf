variable "project_name" {
  type = string
  default = "roboshop"
}

variable "environment" {
  type = string
  default = "prod"
}

variable "common_tags" {
  type = map
  default = {
    Project = "roboshop"
    Environment = "prod"
    Terraform = "true"
  }
}

variable "zone_name" {
  type = string
  default = "rakeshintech.online"
}