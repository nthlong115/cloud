resource "aws_security_group" "sg" {
  name = var.sg_name
  vpc_id = var.aws_vpc_id
  ingress  {
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port   = 22
    to_port     = 22
  } 

  egress {
   protocol     = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port   = 0
    to_port     = 0
  } 
}