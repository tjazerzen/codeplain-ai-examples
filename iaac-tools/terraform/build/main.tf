terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.44.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "hcloud" {
  token = var.hcloud_token
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

resource "hcloud_server" "vm" {
  name        = var.vm_name
  server_type = var.server_type
  image       = var.image
  location    = var.location

  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  
  user_data = templatefile("${path.module}/cloud-init.yaml", {
    cloudflare_api_token = var.cloudflare_api_token
  })
  
  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "cloudflare_record" "domain" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  value   = hcloud_server.vm.ipv4_address
  type    = "A"
  proxied = true
  ttl     = 1 # Auto
}

resource "aws_security_group" "web_server" {
  name        = "web-server-sg"
  description = "Security group for web server"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP access"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS access"
  }

  tags = {
    Name = "web-server-security-group"
  }
}