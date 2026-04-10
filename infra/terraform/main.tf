module "cognito" {
  source      = "./modules/cognito"
  app_name    = var.app_name
  environment = var.environment
}

module "dynamodb" {
  source      = "./modules/dynamodb"
  app_name    = var.app_name
  environment = var.environment
}

module "s3" {
  source      = "./modules/s3"
  app_name    = var.app_name
  environment = var.environment
}

module "lambda" {
  source             = "./modules/lambda"
  app_name           = var.app_name
  environment        = var.environment
  dynamodb_table_arn = module.dynamodb.hands_table_arn
  s3_bucket_arn      = module.s3.uploads_bucket_arn
}

module "api_gateway" {
  source             = "./modules/api_gateway"
  app_name           = var.app_name
  environment        = var.environment
  lambda_invoke_arn  = module.lambda.invoke_arn
  lambda_function_name = module.lambda.function_name
}
