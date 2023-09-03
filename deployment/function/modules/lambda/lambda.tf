resource "aws_lambda_function" "fight_alerts_lambda" {
  function_name = "${var.product}-${var.environment}"

  role = aws_iam_role.fight_alerts_lambda_iam_role.arn

  environment {
    variables = {
      DB_HOST     = db.host
      DB_PASSWORD = db.password
      DB_USERNAME = db.username
    }
  }
}


resource "aws_iam_role" "fight_alerts_lambda_iam_role" {
  name               = "${var.product}-lambda-iam-role"
  assume_role_policy = data.aws_iam_policy_document.fight_alerts_lambda_iam_policy_document.json
}

data "aws_iam_policy_document" "fight_alerts_lambda_iam_policy_document" {
  statement {
    effect = "Allow"
    principals = {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
