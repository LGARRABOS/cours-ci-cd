variable "environment" {
  description = "Nom de l'environnement"
  type        = string
}

variable "vpc_cidr" {
  description = "Plage CIDR de la VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "Plage CIDR du subnet"
  type        = string
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
}

variable "ami" {
  description = "AMI a utiliser"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}
