# tf-module-dynamodb

![Flow chart of how this works](/docs/assets/images/db.jpg)

- This has been made using localstack.
- To deploy, you can use a file `main.tf` with the following content:
```
module "tf-module-dynamodb" {
  source        = "git@github.com:k-candidate/tf-module-dynamodb.git"
  table_name    = "tf-test"
  hash_key      = "id"
  hash_key_type = "N"
  range_key     = "name"
  alias         = "mykey"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.dynamodb-table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_role.iam_for_lambda_tf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_kms_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_lambda_event_source_mapping.lambda_sqs_trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping) | resource |
| [aws_lambda_function.insert-into-dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_sqs_queue.dev-sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_ssm_parameter.foo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [archive_file.lambda](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias"></a> [alias](#input\_alias) | n/a | `string` | `"tf-cmk"` | no |
| <a name="input_hash_key"></a> [hash\_key](#input\_hash\_key) | n/a | `string` | `"UserId"` | no |
| <a name="input_hash_key_type"></a> [hash\_key\_type](#input\_hash\_key\_type) | n/a | `string` | `"S"` | no |
| <a name="input_key_spec"></a> [key\_spec](#input\_key\_spec) | n/a | `string` | `"SYMMETRIC_DEFAULT"` | no |
| <a name="input_range_key"></a> [range\_key](#input\_range\_key) | n/a | `string` | `"FullName"` | no |
| <a name="input_range_key_type"></a> [range\_key\_type](#input\_range\_key\_type) | n/a | `string` | `"S"` | no |
| <a name="input_read_capacity"></a> [read\_capacity](#input\_read\_capacity) | n/a | `number` | `5` | no |
| <a name="input_table_name"></a> [table\_name](#input\_table\_name) | n/a | `string` | n/a | yes |
| <a name="input_write_capacity"></a> [write\_capacity](#input\_write\_capacity) | n/a | `number` | `5` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
