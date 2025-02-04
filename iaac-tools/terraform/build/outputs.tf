output "server_ip" {
  description = "Public IPv4 address of the server"
  value       = hcloud_server.vm.ipv4_address
}

output "dns_record" {
  description = "Fully qualified domain name (FQDN) of the DNS record"
  value       = cloudflare_record.domain.hostname
}