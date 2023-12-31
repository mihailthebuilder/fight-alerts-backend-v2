locals {
  db_username = data.aws_ssm_parameter.db_username.value
  db_password = data.aws_ssm_parameter.db_password.value
}

module "lambda" {
  source      = "./modules/lambda"
  environment = var.environment
  region      = var.region
  db_username = local.db_username
  db_password = local.db_password
  db_host     = "localhost"
  product     = var.product
}

module "rds" {
  source      = "./modules/rds"
  environment = var.environment
  region      = var.region
  db_username = local.db_username
  db_password = local.db_password
  product     = var.product
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  ip_address  = data.aws_ssm_parameter.ip_address.value
  vpc_subnets = data.aws_subnets.vpc_subnets.ids
}
