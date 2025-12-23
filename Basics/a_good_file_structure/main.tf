# Fetch default VPC
data "aws_vpc" "default" {
  default = true
}

# Security Group
resource "aws_security_group" "non_prod_sg" {
  name        = "non-prod-sg"
  description = "Non-prod security group"
  vpc_id      = data.aws_vpc.default.id
}

# Ingress rules (HTTPS)
resource "aws_vpc_security_group_ingress_rule" "https" {
  for_each = toset(var.cidr_values_for_non_prod_instances)

  security_group_id = aws_security_group.non_prod_sg.id
  cidr_ipv4         = each.value
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

# Egress rule (allow all)
resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.non_prod_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# EC2 Instance
resource "aws_instance" "non_prod" {
  count         = var.instance_count_for_non_prod
  ami           = var.ami_id
  instance_type = var.instance_type_for_non_prod

  vpc_security_group_ids = [aws_security_group.non_prod_sg.id]

  root_block_device {
    delete_on_termination = var.delete_on_termination
  }

  tags = merge(
    var.tags_for_ec2_instance,
    {
      Index = count.index
    }
  )
}
