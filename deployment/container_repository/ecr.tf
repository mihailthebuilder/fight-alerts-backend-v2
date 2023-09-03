resource "aws_ecr_repository" "fight_alerts_scraper" {
  name                 = "fight-alerts-scraper"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "fight_alerts_scraper_ecr_repo_url" {
  value = aws_ecr_repository.fight_alerts_scraper.repository_url
}