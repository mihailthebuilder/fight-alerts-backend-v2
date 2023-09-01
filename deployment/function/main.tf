locals {
  db_username = data.aws_ssm_parameter.db_username.value
  db_password = data.aws_ssm_parameter.db_password.value
}

# module "lambda" {
#   source      = "./modules/lambda"
#   environment = var.environment
#   region      = var.region
#   db_username = local.db_username
#   db_password = local.db_password
# }
