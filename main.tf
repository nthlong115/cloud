provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc1" {
  source = "C:/Users/Long Vippro Luxury/Desktop/cloud/vpc"
}   

module "securityg" {
  source = "C:/Users/Long Vippro Luxury/Desktop/cloud/sg"
  aws_vpc_id = module.vpc1.vpc_id
}

module "public_ec2" {
  source = "C:/Users/Long Vippro Luxury/Desktop/cloud/ec2"
  aws_subnet_id = module.vpc1.pub_subnet_id
  aws_sg_id = module.securityg.vpc_sg_id
  pub_ip = true
}

module "private_ec2" {
  source = "C:/Users/Long Vippro Luxury/Desktop/cloud/ec2"
  aws_subnet_id = module.vpc1.pri_subnet_id
  aws_sg_id = module.securityg.vpc_sg_id
  pub_ip = false
} 

module "ebs" {
  source = "C:/Users/Long Vippro Luxury/Desktop/cloud/ebs"
  outec2 = module.public_ec2.ec2_id
}

module "cluster" {
  source       = "C:/Users/Long Vippro Luxury/Desktop/cloud/redis"
  eks_sg_id    = [ "module.securityg.vpc_sg_id" ]
  esg_sub_ids  = [ "module.vpc1.pub_subnet_id", "module.vpc1.pri_subnet_id" ]
}

module "eks" {
  source  = "C:/Users/Long Vippro Luxury/Desktop/cloud/eks"
  sub_eks = [ "module.vpc1.pub_subnet_id" ]
}

module "elb" {
  source         = "C:/Users/Long Vippro Luxury/Desktop/cloud/elb"
  lb_vpc_id      = module.vpc1.vpc_id
  lb_sg          = [ "module.securityg.vpc_sg_id" ]
  lb_subnet      = [ "module.vpc1.pub_subnet_id", "module.vpc1.pri_subnet_id" ]
  public_ec2_id  = module.public_ec2.ec2_id
  private_ec2_id = module.private_ec2.ec2_id
}

module "autoscaling" {
  source = "C:/Users/Long Vippro Luxury/Desktop/cloud/autoscaling"
  asg_vpc_zone = [ "module.vpc1.pub_subnet_id", "module.vpc1.pri_subnet_id" ]
  target_group_arn = module.elb.tg_arn
}

module "rds" {
  source       = "C:/Users/Long Vippro Luxury/Desktop/cloud/rds"
  db_vpc_id    = [ "module.vpc1.vpc_id" ]
  db_sub_group = module.cluster.sub_gr_name
}