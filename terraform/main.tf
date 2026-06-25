module "ec2" {
  source = "./modules/ec2"

  environment   = var.environment
  vpc_cidr      = var.vpc_cidr
  subnet_cidr   = var.subnet_cidr
  instance_type = var.instance_type
  ami           = var.ami

  ingress_ports = [22, 80]
}