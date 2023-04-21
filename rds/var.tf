variable "rds" {
  type = object({
    allocated_storage      = number
    db_name                = string
    engine                 = string
    engine_version         = string
    instance_class         = string
    username               = string
    password               = string
    skip_final_snapshot    = bool
    storage_type           = string
    max_allocated_storage  = number
    network_type           = string
    publicly_accessible    = bool
    availability_zone      = string
    backup_window          = string
  })
}