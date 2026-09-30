output "endpoint" {
  description = "Endpoint de conexão completo da instância RDS (host:porta)"
  value       = aws_db_instance.this.endpoint
}

output "address" {
  description = "Endereço (hostname) da instância RDS"
  value       = aws_db_instance.this.address
}

output "port" {
  description = "Porta de conexão da instância RDS"
  value       = aws_db_instance.this.port
}
