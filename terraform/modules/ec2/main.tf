# =========================================================
#  Reseau : VPC -> Internet Gateway -> Subnet -> Routing
# =========================================================

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  }
}

resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-subnet"
    Environment = var.environment
  }
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name        = "${var.environment}-rt"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}

# =========================================================
#  Securite : Security Group + regles ingress / egress
# =========================================================

resource "aws_security_group" "this" {
  name        = "${var.environment}-sg"
  description = "Security group pour l'environnement ${var.environment}"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name        = "${var.environment}-sg"
    Environment = var.environment
  }
}

# Une regle ingress par port demande (boucle for_each)
resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = toset([for p in var.ingress_ports : tostring(p)])

  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = tonumber(each.value)
  to_port           = tonumber(each.value)
  ip_protocol       = "tcp"

  tags = {
    Name = "${var.environment}-ingress-${each.value}"
  }
}

# Egress : tout autorise en sortie
resource "aws_vpc_security_group_egress_rule" "this" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # -1 = tous protocoles

  tags = {
    Name = "${var.environment}-egress-all"
  }
}

# =========================================================
#  Compute : l'instance EC2
# =========================================================

resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.this.id
  vpc_security_group_ids = [aws_security_group.this.id]

  tags = {
    Name        = "${var.environment}-ec2"
    Environment = var.environment
  }
}

