variable "vpc_cidr" {
  type = string
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "common_tags" {
  type = map
  default = {}
}

variable "vpc_tags" {
  type = map
  default = {}
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "igw_tags" {
  type = map
  default = {}
}

variable "public_subnets_cidr" {
  type = list
  validation {
    condition = length(var.public_subnets_cidr) == 2
    error_message = "Please provide two public valid CIDR"
  }
}

variable "public_subnets_tags" {
  type = map
  default = {}
}

variable "private_subnets_cidr" {
  type = list
  validation {
    condition = length(var.private_subnets_cidr) == 2
    error_message = "Please provie two private valid CIDR"
  }
}

variable "private_subnets_tags" {
  type = map
  default = {}
}

variable "database_subnets_cidr" {
  type = list
  validation {
    condition = length(var.database_subnets_cidr) == 2
    error_message = "Please provide two database valid CIDR"
  }
}

variable "database_subnets_tags" {
  type = map
  default = {}
}

variable "public_route_table_tags" {
  type = map
  default = {}
}

variable "private_route_table_tags" {
  type = map
  default = {}
}

variable "database_route_table_tags" {
  type = map
  default = {}
}

variable "is_vpc_peering_required" {
  type = bool
  default = false
}

variable "acceptor_vpc_id" {
  type = string
  default = ""
}

variable "vpc_peering_tags" {
  type = map
  default = {}
}
