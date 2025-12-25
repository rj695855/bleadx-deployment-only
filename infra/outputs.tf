output "ec2_id" {
  value = aws_instance.ec2.id
}

output "elastic_ip" {
  value = aws_eip.eip.public_ip
}

output "domain" {
  value = var.domain_name
}
