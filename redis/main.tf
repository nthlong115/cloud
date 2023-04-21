resource "aws_elasticache_cluster" "example" {
  cluster_id           = var.my_cluster.cluster_id 
  engine               = var.my_cluster.engine
  node_type            = var.my_cluster.node_type
  num_cache_nodes      = var.my_cluster.num_cache_nodes
  parameter_group_name = aws_elasticache_parameter_group.default.name
  engine_version       = var.my_cluster.engine_version
  port                 = var.my_cluster.port
  security_group_ids   = var.eks_sg_ig
  subnet_group_name    = aws_elasticache_subnet_group.redis_sub.name
  preferred_availability_zones = [ "us-east-1", "us-east-2" ]
}

resource "aws_elasticache_parameter_group" "default" {
  name   = "cache-params"
  family = "redis3.2"
}

resource "aws_elasticache_subnet_group" "redis_sub" {
  name = var.esg_name
  subnet_ids = var.esg_sub_ids
}
