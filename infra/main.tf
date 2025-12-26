terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    godaddy = {
      source  = "n3integration/godaddy"
      version = "~> 1.9"
    }
  }
}

# ---------- AWS ----------
provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.bleadx-web-sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name

  user_data = <<-EOF
              #cloud-config
              write_files:
                - path: /tmp/setup.sh
                  permissions: '0755'
                  content: |
                    ${indent(20, file("${path.module}/scripts/deploy.sh"))}

              runcmd:
                - /tmp/setup.sh
              EOF

  tags = {
    Name = "production-ec2"
  }
}

resource "aws_eip" "eip" {
  instance = aws_instance.ec2.id
  domain   = "vpc"

  tags = {
    Name = "github-action-eip"
  }
}

# ---------- GoDaddy ----------
provider "godaddy" {
  key    = var.godaddy_api_key
  secret = var.godaddy_api_secret
}

resource "godaddy_domain_record" "root_domain" {
  domain = var.domain_name

  record {
    type = "A"
    name = "@"
    data = aws_eip.eip.public_ip
    ttl  = 600
  }
}

resource "godaddy_domain_record" "www_domain" {
  domain = var.domain_name

  record {
    type = "A"
    name = "www"
    data = aws_eip.eip.public_ip
    ttl  = 600
  }
}
