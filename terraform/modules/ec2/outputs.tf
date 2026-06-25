output "instance_id" {
  description = "ID de l'instance EC2 creee"
  value       = aws_instance.this.id
}

output "private_ip" {
  description = "IP privee de l'instance"
  value       = aws_instance.this.private_ip
}

output "vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.this.id
}

output "security_group_id" {
  description = "ID du security group"
  value       = aws_security_group.this.id
}

