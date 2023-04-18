provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc1" {
  source = "C:/Users/CLOUDAZ/Desktop/labmodule/lab/vpc"
}

module "securityg" {
  source = "C:/Users/CLOUDAZ/Desktop/labmodule/lab/sg"
  aws_vpc_id = module.vpc1.vpc_id
}

module "public_ec2" {
  source = "C:/Users/CLOUDAZ/Desktop/labmodule/lab/ec2"
  aws_subnet_id = module.vpc1.pub_subnet_id
  aws_sg_id = module.securityg.vpc_sg_id
  pub_ip = true
}

/*module "private_ec2" {
  source = "C:/Users/CLOUDAZ/Desktop/labmodule/lab/ec2"
  aws_subnet_id = module.vpc1.pri_subnet_id
  aws_sg_id = module.securityg.vpc_sg_id
  pub_ip = false
} 

module "ebs" {
  source = "C:/Users/CLOUDAZ/Desktop/labmodule/lab/ebs"
  outec2 = module.public_ec2.ec2_id
}*/

resource "aws_vpc_peering_connection" "my-peer" {
  name = peeeeee
  vpc_id = module.vpc1.vpc_id

}