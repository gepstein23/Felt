resource "aws_iam_role" "lambda_exec" {
  name = "${var.app_name}-${var.environment}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "lambda_app" {
  name = "${var.app_name}-${var.environment}-lambda-policy"
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:Query", "dynamodb:UpdateItem", "dynamodb:DeleteItem"]
        Resource = var.dynamodb_table_arn
      },
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject"]
        Resource = "${var.s3_bucket_arn}/*"
      }
    ]
  })
}

resource "aws_lambda_function" "api" {
  function_name = "${var.app_name}-${var.environment}-api"
  role          = aws_iam_role.lambda_exec.arn
  runtime       = "java21"
  handler       = "com.felt.Handler::handleRequest" # Update when Java project is created
  filename      = "placeholder.zip"                 # Replace with actual JAR artifact path

  memory_size = 512
  timeout     = 30

  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }

  lifecycle {
    ignore_changes = [filename] # Deployments managed by CI/CD, not Terraform
  }
}
