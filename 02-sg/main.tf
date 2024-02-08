# VPN security group
module "vpn" {
  source         = "../terraform-aws-security-group"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "vpn"
  sg_description = "SG for VPN"
  vpc_id         = data.aws_vpc.default.id
}

module "mongodb" {
  source         = "../terraform-aws-security-group"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "mongodb"
  sg_description = "SG for MONGODB"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
}

module "redis" {
  source         = "../terraform-aws-security-group"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "redis"
  sg_description = "SG for REDIS"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
}

module "mysql" {
  source         = "../terraform-aws-security-group"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "mysql"
  sg_description = "SG for MYSQL"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
}

module "rabbitmq" {
  source         = "../terraform-aws-security-group"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "rabbitmq"
  sg_description = "SG for RABBITMQ"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
}

module "catalogue" {
  source         = "../terraform-aws-security-group"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "catalogue"
  sg_description = "SG for CATALOGUE"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
}

module "user" {
  source         = "../terraform-aws-security-group"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "user"
  sg_description = "SG for USER"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
}

module "cart" {
  source         = "../terraform-aws-security-group"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "cart"
  sg_description = "SG for CART"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
}

module "shipping" {
  source         = "../terraform-aws-security-group"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "shipping"
  sg_description = "SG for SHIPPING"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
}

module "payment" {
  source         = "../terraform-aws-security-group"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "payment"
  sg_description = "SG for PAYMENT"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
}

# module "dispatch" {
#   source         = "../terraform-aws-security-group"
#   project_name   = var.project_name
#   environment    = var.environment
#   sg_name        = "dispatch"
#   sg_description = "SG for DISPATCH"
#   vpc_id         = data.aws_ssm_parameter.vpc_id.value
# }

module "web" {
  source         = "../terraform-aws-security-group"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "web"
  sg_description = "SG for WEB"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
}

# Application LoadBalancer security group
module "app_alb" {
  source         = "../terraform-aws-security-group"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "app_alb"
  sg_description = "SG for APP ALB"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
}

module "web_alb" {
  source         = "../terraform-aws-security-group"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "web_alb"
  sg_description = "SG for WEB ALB"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
}

# This is WEB ALB SG rule accepts connections from INTERNET
resource "aws_security_group_rule" "web_alb_internet" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = module.web_alb.sg_id
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "vpn" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  security_group_id        = module.vpn.sg_id
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "app_alb_vpn" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
  source_security_group_id = module.vpn.sg_id
}

# This is APP-ALB SG rule accepts connections from web
resource "aws_security_group_rule" "app_alb_web" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
  source_security_group_id = module.web.sg_id
}

resource "aws_security_group_rule" "app_alb_catalogue" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
  source_security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "app_alb_user" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
  source_security_group_id = module.user.sg_id
}

resource "aws_security_group_rule" "app_alb_cart" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
  source_security_group_id = module.cart.sg_id
}

resource "aws_security_group_rule" "app_alb_shipping" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
  source_security_group_id = module.shipping.sg_id
}

resource "aws_security_group_rule" "app_alb_payment" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
  source_security_group_id = module.payment.sg_id
}

resource "aws_security_group_rule" "mongodb_vpn" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.mongodb.sg_id
  source_security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "mongodb_catalogue" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = module.mongodb.sg_id
  source_security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = module.mongodb.sg_id
  source_security_group_id = module.user.sg_id
}

resource "aws_security_group_rule" "redis_vpn" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
  source_security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "redis_cart" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
  source_security_group_id = module.cart.sg_id
}

resource "aws_security_group_rule" "redis_user" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
  source_security_group_id = module.user.sg_id
}

resource "aws_security_group_rule" "mysql_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.mysql.sg_id
  source_security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "mysql_shipping" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = module.mysql.sg_id
  source_security_group_id = module.shipping.sg_id
}

resource "aws_security_group_rule" "rabbitmq_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.rabbitmq.sg_id
  source_security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  type              = "ingress"
  from_port         = 5672
  to_port           = 5672
  protocol          = "tcp"
  security_group_id = module.rabbitmq.sg_id
  source_security_group_id = module.payment.sg_id
}

resource "aws_security_group_rule" "catalogue_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.catalogue.sg_id
  source_security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "catalogue_app_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.catalogue.sg_id
  source_security_group_id = module.app_alb.sg_id
}

# resource "aws_security_group_rule" "catalogue_web" {
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"
#   security_group_id = module.catalogue.sg_id
#   source_security_group_id = module.web.sg_id
# }

resource "aws_security_group_rule" "user_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.user.sg_id
  source_security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "user_app_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.user.sg_id
  source_security_group_id = module.app_alb.sg_id
}

# resource "aws_security_group_rule" "user_web" {
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"
#   security_group_id = module.user.sg_id
#   source_security_group_id = module.web.sg_id
# }

# resource "aws_security_group_rule" "user_payment" {
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"
#   security_group_id = module.user.sg_id
#   source_security_group_id = module.payment.sg_id
# }

resource "aws_security_group_rule" "cart_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.cart.sg_id
  source_security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "cart_app_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.cart.sg_id
  source_security_group_id = module.app_alb.sg_id
}

# resource "aws_security_group_rule" "cart_web" {
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"
#   security_group_id = module.cart.sg_id
#   source_security_group_id = module.web.sg_id
# }

resource "aws_security_group_rule" "cart_shipping" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.cart.sg_id
  source_security_group_id = module.shipping.sg_id
}

resource "aws_security_group_rule" "cart_payment" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.cart.sg_id
  source_security_group_id = module.payment.sg_id
}

resource "aws_security_group_rule" "shipping_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.shipping.sg_id
  source_security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "shipping_app_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.shipping.sg_id
  source_security_group_id = module.app_alb.sg_id
}

# resource "aws_security_group_rule" "shipping_web" {
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"
#   security_group_id = module.shipping.sg_id
#   source_security_group_id = module.web.sg_id
# }

resource "aws_security_group_rule" "payment_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.payment.sg_id
  source_security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "payment_app_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.payment.sg_id
  source_security_group_id = module.app_alb.sg_id
}

# resource "aws_security_group_rule" "payment_web" {
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"
#   security_group_id = module.payment.sg_id
#   source_security_group_id = module.web.sg_id
# }

resource "aws_security_group_rule" "web_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.web.sg_id
  source_security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "web_internet" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.web.sg_id
  cidr_blocks = [ "0.0.0.0/0" ]
}
