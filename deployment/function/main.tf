locals {
  db = {
    username = data.aws_ssm_parameter.db_username.value
    password = data.aws_ssm_parameter.db_password.value
    host = "localhost"
  }
}

module "lambda" {
  source      = "./modules/lambda"
  environment = var.environment
  region      = var.region
  db          = local.db
  product     = var.product
}
