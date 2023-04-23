resource "aws_instance" "ec2" {
  ami = var.ami
  instance_type = var.ec2_type
  subnet_id = var.aws_subnet_id
  vpc_security_group_ids = [ "${var.aws_sg_id}" ]
  associate_public_ip_address = var.pub_ip
  tags = {
    Name = "ec2-in-${var.aws_sg_id}"
  }
}

/*resource "tls_private_key" "name" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_placement_group" "lab" {
  name     = "hunky-dory-pg"
  strategy = "cluster"
}*/