variable "key_spec" {
  type    = string
  default = "SYMMETRIC_DEFAULT"
}

variable "alias" {
  type    = string
  default = "tf-cmk"
}

variable "table_name" {
  type    = string
  default = "test-table"
}

variable "read_capacity" {
  type    = number
  default = 5
}

variable "write_capacity" {
  type    = number
  default = 5
}

variable "hash_key" {
  type    = string
  default = "UserId"
}

variable "range_key" {
  type    = string
  default = "FullName"
}

variable "hash_key_type" {
  type    = string
  default = "S"
}

variable "range_key_type" {
  type    = string
  default = "S"
}
