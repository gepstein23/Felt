variable "app_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "lambda_invoke_arn" {
  type = string
}

variable "lambda_function_name" {
  type = string
}

variable "cors_allow_origins" {
  type        = list(string)
  description = "Allowed CORS origins — never use [\"*\"] in prod"
}
