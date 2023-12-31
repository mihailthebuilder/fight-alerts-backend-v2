resource "aws_lambda_function" "fight_alerts_lambda" {
  function_name = "${var.product}-${var.environment}"

  role         = aws_iam_role.lambda_assume_role.arn
  image_uri    = "${data.aws_ecr_repository.fight_alerts_ecr_repo.repository_url}:${data.aws_ecr_repository.fight_alerts_ecr_repo.most_recent_image_tags[0]}"
  package_type = "Image"

  environment {
    variables = {
      DB_HOST     = var.db_host
      DB_PASSWORD = var.db_password
      DB_USERNAME = var.db_username
    }
  }
}

resource "aws_iam_role" "lambda_assume_role" {
  name               = "${var.product}-lambda-iam-assume-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
