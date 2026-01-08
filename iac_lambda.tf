# Pour récupérer votre compte
data "aws_caller_identity" "current" {}

# Package the Lambda function code
data "archive_file" "lambda_dir" {
  type        = "zip"
  source_dir = "${path.module}/lambda"
  output_path = "${path.module}/lambda/function.zip"
}

# Lambda function
resource "aws_lambda_function" "lambda_function" {
  filename         = data.archive_file.lambda_dir.output_path
  function_name    = "ma-premiere-lambda"
  role             = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole"
  handler          = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.lambda_dir.output_base64sha256

  runtime = "python3.13"

  environment {
    variables = {
      ENVIRONMENT = "production"
      LOG_LEVEL   = "info"
    }
  }

  tags = {
    Environment = "production"
    Application = "example"
  }
}