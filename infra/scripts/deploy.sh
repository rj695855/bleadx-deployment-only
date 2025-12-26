#!/bin/bash
set -e

yum update -y
yum install -y nginx docker

systemctl enable nginx
systemctl start nginx

systemctl enable docker
systemctl start docker

echo "<h1>Production EC2 deployed by Terraform + GitHub Actions</h1>" \
> /usr/share/nginx/html/index.html
