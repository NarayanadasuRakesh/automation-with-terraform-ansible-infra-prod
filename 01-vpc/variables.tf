variable "vpc_cidr" {
  type    = string
  default = "10.1.0.0/16"
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "common_tags" {
  type = map
  default = {
    Project     = "roboshop"
    Environment = "prod"
    Terraform   = true
  }
}

variable "vpc_tags" {
  default = {}
}

variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "prod"
}

variable "igw_tags" {
  type = map
  default = {
    Purpose = "Internet Gateway for VPC"
  }
}


variable "public_subnets_cidr" {
  default = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "public_subnets_tags" {
  default = {
    Type = "public"
  }
}

variable "private_subnets_cidr" {
  default = ["10.1.11.0/24", "10.1.12.0/24"]
}

variable "private_subnets_tags" {
  default = {
    Type = "private"
  }
}

variable "database_subnets_cidr" {
  default = ["10.1.21.0/24", "10.1.22.0/24"]
}

variable "database_subnets_tags" {
  default = {
    Type = "database"
  }
}

variable "is_vpc_peering_required" {
  default = true
}
