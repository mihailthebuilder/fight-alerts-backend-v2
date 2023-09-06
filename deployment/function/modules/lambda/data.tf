data "aws_ecr_repository" "fight_alerts_ecr_repo" {
  name = "fight-alerts-scraper"
}

data "aws_internet_gateway" "vpc_default" {
  filter {
    name   = "attachment.vpc-id"
    values = [var.vpc_id]
  }
}