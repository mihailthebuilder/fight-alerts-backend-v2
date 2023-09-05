data "aws_ssm_parameter" "db_username" {
  name = "/${var.product}/${var.environment}/db/username"
}

data "aws_ssm_parameter" "db_password" {
  name = "/${var.product}/${var.environment}/db/password"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/fight-alerts/security/vpc-id"
}

data "aws_ssm_parameter" "ip_address" {
  name = "/fight-alerts/security/allow-ip"
}

data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_ssm_parameter.jenkins_vpc_id.value]
  }
}