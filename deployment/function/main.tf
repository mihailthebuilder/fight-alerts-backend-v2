locals {
  db_username = data.aws_ssm_parameter.db_username.value
  db_password = data.aws_ssm_parameter.db_password.value
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  vpc_subnets = data.aws_subnets.vpc_subnets.ids
}

module "lambda" {
  source      = "./modules/lambda"
  environment = var.environment
  region      = var.region
  db_username = local.db_username
  db_password = local.db_password
  db_host     = module.rds.rds_database_endpoint_rw
  product     = var.product
  vpc_id      = local.vpc_id
  vpc_subnets = local.vpc_subnets
}

module "rds" {
  source      = "./modules/rds"
  environment = var.environment
  region      = var.region
  db_username = local.db_username
  db_password = local.db_password
  product     = var.product
  vpc_id      = local.vpc_id
  ip_address  = data.aws_ssm_parameter.ip_address.value
  vpc_subnets = local.vpc_subnets
}

resource "aws_security_group" "rds_access" {
  name   = "${var.product}-${var.environment}-rds-sg"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}