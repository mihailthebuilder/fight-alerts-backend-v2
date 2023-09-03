variable "environment" {}
variable "product" {}
variable "db" {
  type = object({
    username    = string
    password = string
    host = string
  })    
}
variable "region" {}
