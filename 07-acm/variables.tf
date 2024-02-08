variable "common_tags" {
  type = map
  default = {
    Project     = "roboshop"
    Environment = "dev"
    Terraform   = true
  }
}

variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "tags" {
  default = {
    Component = "acm"
  }
}

variable "zone_name" {
  type = string
  default = "rakeshintech.online"
}
