variable "aws_region" {
  default = "ap-south-1"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI"
  default     = "ami-0f5ee92e2d63afc18" # ap-south-1 (verify once)
}

variable "instance_type" {
  default = "t2.micro"
}
