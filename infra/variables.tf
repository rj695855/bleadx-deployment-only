variable "aws_region" {
  default = "ap-south-1"
}

variable "ami_id" {
  description = "Ubuntu Server 24.04 LTS (HVM)"
  default     = "ami-02b8269d5e85954ef"
}

variable "instance_type" {
  default = "c7i-flex.large"
}

# -------- GoDaddy --------
variable "godaddy_api_key" {
  type      = string
  sensitive = true
}

variable "godaddy_api_secret" {
  type      = string
  sensitive = true
}

variable "domain_name" {
  description = "example.com"
  type        = string
}
