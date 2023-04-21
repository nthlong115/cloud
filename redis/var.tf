variable "my_cluster" {
  type = object({
   cluster_id           = string
   engine               = string
   node_type            = string
   num_cache_nodes      = number
   parameter_group_name = string
   engine_version       = string
   port                 = number
   security_group_ids   = string
   subnet_group_name    = string
   az_mode              = string 
  }) 
}

variable "eks_sg_ig" {
  type = string
}

variable "eks_sub_name" {
  type = string
}

variable "esg_sub_ids" {
  type = string
}