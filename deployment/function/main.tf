locals {
  db_username = data.aws_ssm_parameter.db_username.value
  db_password = data.aws_ssm_parameter.db_password.value
  vpc_subnets = data.aws_subnets.vpc_subnets.ids
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
}

module "lambda" {
  source                 = "./modules/lambda"
  environment            = var.environment
  region                 = var.region
  db_username            = local.db_username
  db_password            = local.db_password
  db_host                = module.rds.rds_database_endpoint_rw
  product                = var.product
  live_in_security_group = aws_security_group.rds_access.id
  vpc_subnets            = local.vpc_subnets
  vpc_id                 = local.vpc_id
}

module "rds" {
  source                              = "./modules/rds"
  environment                         = var.environment
  region                              = var.region
  db_username                         = local.db_username
  db_password                         = local.db_password
  product                             = var.product
  vpc_id                              = local.vpc_id
  ip_address                          = data.aws_ssm_parameter.ip_address.value
  vpc_subnets                         = local.vpc_subnets
  allow_access_from_security_group_id = aws_security_group.rds_access.id
}

resource "aws_security_group" "rds_access" {
  name   = "${var.product}-${var.environment}-rds-sg"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}

resource "aws_security_group_rule" "allow_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_access.id
}

resource "aws_security_group_rule" "allow_all_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_access.id
}