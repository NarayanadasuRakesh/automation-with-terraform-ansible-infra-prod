module "roboshop" {
  source               = "../terraform-aws-vpc"
  vpc_cidr             = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  project_name         = var.project_name
  environment          = var.environment

  public_subnets_cidr = var.public_subnets_cidr

  private_subnets_cidr = var.private_subnets_cidr

  database_subnets_cidr = var.database_subnets_cidr

  is_vpc_peering_required = var.is_vpc_peering_required
}
