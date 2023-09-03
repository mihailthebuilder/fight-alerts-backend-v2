resource "aws_lambda_function" "fight_alerts_lambda" {
  function_name = "${var.product}-${var.environment}"

  role = aws_iam_role.fight_alerts_lambda_iam_role.arn
  image_uri = data.aws_ecr_image.lambda_image.image_uris[0]

  environment {
    variables = {
      DB_HOST     = var.db.host
      DB_PASSWORD = var.db.password
      DB_USERNAME = var.db.username
    }
  }
}


resource "aws_iam_role" "fight_alerts_lambda_iam_role" {
  name               = "${var.product}-lambda-iam-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
