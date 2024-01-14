# Create KMS CMK
resource "aws_kms_key" "this" {
  description              = "Customer managed KMS CMK for the DynamoDB"
  customer_master_key_spec = var.key_spec
  is_enabled               = true
}

# Add an alias for the key
resource "aws_kms_alias" "this" {
  name          = "alias/${var.alias}"
  target_key_id = aws_kms_key.this.key_id
}

# Create DynamoDB table
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
    type = var.range_key_type
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.this.arn
  }

}
