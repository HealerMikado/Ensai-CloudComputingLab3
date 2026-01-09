# Pour récupérer votre compte
data "aws_caller_identity" "current" {}

# Package the Lambda function code
data "archive_file" "lambda_dir" {
  type        = "zip"
  source_dir = "${path.module}/lambda"
  output_path = "${path.module}/output/function.zip"
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
      foo = "bar"
    }
  }

  tags = {
    Environment = "production"
    Application = "example"
  }
}

# # EventBridge rule (every minute)
# resource "aws_cloudwatch_event_rule" "every_minute" {
#   name                = "every-minute-rule"
#   schedule_expression = "rate(1 minute)"
# }

# # EventBridge target
# resource "aws_cloudwatch_event_target" "lambda_target" {
#   rule      = aws_cloudwatch_event_rule.every_minute.name
#   target_id = "lambda"
#   arn       = aws_lambda_function.lambda_function.arn
# }

# # Allow EventBridge to invoke Lambda
# resource "aws_lambda_permission" "allow_eventbridge" {
#   statement_id  = "AllowExecutionFromEventBridge"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.lambda_function.function_name
#   principal     = "events.amazonaws.com"
#   source_arn    = aws_cloudwatch_event_rule.every_minute.arn
# }