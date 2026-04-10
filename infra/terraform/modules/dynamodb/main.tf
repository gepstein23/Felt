resource "aws_dynamodb_table" "hands" {
  name         = "${var.app_name}-${var.environment}-hands"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"
  range_key    = "handId"

  attribute {
    name = "userId"
    type = "S"
  }

  attribute {
    name = "handId"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }

  # Full schema to be defined in I1-3
}
