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
    Component = "web"
  }
}

variable "zone_name" {
  type = string
  default = "rakeshintech.online"
}
