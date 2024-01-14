resource "aws_dynamodb_table" "dynamodb-table" {
  name           = var.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  range_key      = var.range_key

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  attribute {
    name = var.range_key
    type = va.range_key_type
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

}
