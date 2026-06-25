output "instance_id" {
  description = "ID de l'instance EC2 (remonte depuis le module)"
  value       = module.ec2.instance_id
}

output "private_ip" {
  value = module.ec2.private_ip
}
