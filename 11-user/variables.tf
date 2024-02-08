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
    Component = "user"
  }
}

variable "zone_name" {
  type = string
  default = "rakeshintech.online"
}

variable "iam_instance_profile" {
  type = string
  default = "ansible-tf-shell"
}