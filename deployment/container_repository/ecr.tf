resource "aws_ecr_repository" "fight_alerts_scraper" {
  name                 = "fight-alerts-scraper"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

data "aws_ecr_authorization_token" "fight_alerts_scraper" {
  registry_id = aws_ecr_repository.fight_alerts_scraper.registry_id
}

output "fight_alerts_scraper_ecr_repo_url" {
  value = aws_ecr_repository.fight_alerts_scraper.repository_url
}

output "fight_alerts_scraper_ecr_repo_login_password" {
  value     = data.aws_ecr_authorization_token.fight_alerts_scraper.password
  sensitive = true
}