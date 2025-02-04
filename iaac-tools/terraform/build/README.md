# Infrastructure as Code for Web Server Deployment

This project provides Infrastructure as Code (IaC) configuration to deploy a web server on Hetzner Cloud with automated DNS management through Cloudflare and SSL certificate provisioning using Let's Encrypt.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (>= 1.0.0)
- [Hetzner Cloud](https://console.hetzner.cloud/) account and API token
- [Cloudflare](https://dash.cloudflare.com/) account and API token
- [AWS](https://aws.amazon.com/) account with access and secret keys
- Domain name managed by Cloudflare (currently configured for tjazerzen.com)

## Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. Copy the example variables file and configure your settings:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. Edit `terraform.tfvars` with your credentials and configuration:
   ```hcl
   hcloud_token = "your-hetzner-cloud-api-token"
   cloudflare_api_token = "your-cloudflare-api-token"
   cloudflare_zone_id = "your-cloudflare-zone-id"
   aws_access_key = "your-aws-access-key"
   aws_secret_key = "your-aws-secret-key"
   ```

## Configuration

### Required Tokens and Credentials

1. **Hetzner Cloud API Token**
   - Go to Hetzner Cloud Console
   - Navigate to Security → API Tokens
   - Create a new token with read/write permissions

2. **Cloudflare API Token**
   - Log into Cloudflare Dashboard
   - Go to Profile → API Tokens
   - Create a token with DNS:Edit permissions for your zone

3. **AWS Credentials**
   - Access IAM in AWS Console
   - Create a new user with programmatic access
   - Attach policies for EC2 security group management

### Optional Configuration

You can customize the following variables in `terraform.tfvars`:
- `vm_name`: Name of the virtual machine
- `server_type`: Hetzner server size (default: cx11)
- `location`: Server location (default: nbg1)
- `aws_region`: AWS region (default: eu-central-1)

## Usage

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Review the planned changes:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

4. To destroy the infrastructure:
   ```bash
   terraform destroy
   ```

## Security Considerations

- Keep your API tokens and credentials secure
- Don't commit `terraform.tfvars` to version control
- The security group allows SSH (22), HTTP (80), and HTTPS (443) access
- SSL certificates are automatically renewed every 60 days
- Nginx is configured with secure SSL settings

## Troubleshooting

### Common Issues

1. **Terraform initialization fails**
   - Verify your internet connection
   - Check if required providers are accessible

2. **API authentication errors**
   - Verify API tokens are correct in terraform.tfvars
   - Ensure tokens have necessary permissions

3. **SSL certificate issues**
   - Check Cloudflare API token permissions
   - Verify domain DNS records are properly configured

### Getting Help

If you encounter issues:
1. Check the Terraform logs
2. Review cloud-init logs: `/var/log/cloud-init-output.log`
3. Verify Nginx status: `systemctl status nginx`
4. Check SSL certificate status: `certbot certificates`

## Output Values

After successful deployment, you can view:
- Server IP address: `terraform output server_ip`
- DNS record: `terraform output dns_record`