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

# Lambda script
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "inserter.py"
  output_path = "lambda_function_payload.zip"
}

# Lambda
resource "aws_lambda_function" "insert-into-dynamodb" {
  filename      = "lambda_function_payload.zip"
  function_name = "tf-insert-into-dynamodb"
  runtime       = "python3.11"
  role          = aws_iam_role.iam_for_lambda_tf.arn
  handler       = "inserter.insert_data"
}

resource "aws_iam_role" "iam_for_lambda_tf" {
  name = "iam_for_lambda_tf"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "*:*",
      "Principal": {
        "Service": "*"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# SSM with table name. Used by the py script
resource "aws_ssm_parameter" "foo" {
  name  = "/dev/table_name"
  type  = "String"
  value = var.table_name
}

# SQS trigger for the lambda
resource "aws_sqs_queue" "dev-sqs" {
  name = "dev-sqs"
}

# Lambda SQS trigger
resource "aws_lambda_event_source_mapping" "lambda_sqs_trigger" {
  event_source_arn = aws_sqs_queue.dev-sqs.arn
  function_name    = aws_lambda_function.insert-into-dynamodb.arn
  depends_on       = [aws_sqs_queue.dev-sqs]
}
