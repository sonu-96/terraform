# terraform
### add cred.tf file
```
variable "access_key" {
  type = string
  default = ""
  description = "IAM user access_id"
}

variable "secret_key" {
  type = string
  default = ""
  description = "IAM user secret_id"
}
```
