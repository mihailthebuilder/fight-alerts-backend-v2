variable "resource_tags" {
  type = map(string)
  default = {
    Name    = "fight_alerts_resource"
    Owner   = "Mihail_Marian"
    Contact = "mihail@email.com"
    Product = "Fight_Alerts"
  }
}

variable "region" {
  default = "eu-west-2"
}

variable "product" {
  default = "fight-alerts"
}