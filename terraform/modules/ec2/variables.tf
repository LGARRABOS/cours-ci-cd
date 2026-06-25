variable "environment" {
  description = "Nom de l'environnement (dev, prod...)"
  type        = string
}

variable "vpc_cidr" {
  description = "Plage CIDR de la VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "Plage CIDR du subnet (doit etre inclus dans vpc_cidr)"
  type        = string
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
}

variable "ami" {
  description = "AMI a utiliser pour l'instance"
  type        = string
}

variable "ingress_ports" {
  description = "Liste des ports TCP a ouvrir en entree"
  type        = list(number)
  default     = [22, 80]
}

