variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "web-server"
}

variable "server_type" {
  description = "Hetzner Cloud server type"
  type        = string
  default     = "cx11"  # Smallest instance type
}

variable "image" {
  description = "Operating system image"
  type        = string
  default     = "ubuntu-22.04"
}

variable "location" {
  description = "Datacenter location"
  type        = string
  default     = "nbg1"  # Nuremberg
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID for the domain"
  type        = string
}

variable "domain_name" {
  description = "Domain name for the DNS record"
  type        = string
  default     = "tjazerzen.com"
}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}