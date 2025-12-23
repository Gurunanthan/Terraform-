provider "aws" {
  region = tolist(var.region_for_non_prod)[1] #set doesnot maintain order so check this one carefully
}

resource "aws_instance" "instance" {
  count = var.instance_count_for_non_prod

  ami           = var.ami_id
  instance_type = var.instance_type_for_non_prod

  root_block_device {
    delete_on_termination = var.delete_on_termination
  }

  tags = var.tags_for_ec2_instance
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS traffic"
}


resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.cidr_values_for_non_prod_instances[2]
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  region = tolist(var.region_for_non_prod)[1]

}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  region = tolist(var.region_for_non_prod)[1]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.cidr_values_for_non_prod_instances[2]
  ip_protocol       = "-1"
  region = tolist(var.region_for_non_prod)[1]

}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
  region = tolist(var.region_for_non_prod)[1]

}
