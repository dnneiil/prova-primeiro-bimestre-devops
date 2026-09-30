output "instance_id" {
  description = "ID da instância EC2 criada"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Endereço IP público da instância EC2"
  value       = aws_instance.this.public_ip
}
