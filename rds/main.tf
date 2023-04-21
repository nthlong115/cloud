resource "aws_db_instance" "rds" {
  allocated_storage      = var.rds.allocated_storage
  db_name                = var.rds.db_name
  engine                 = vra.rds.engine
  engine_version         = var.rds.engine_version
  instance_class         = var.rds.instance_class
  username               = var.rds.username
  password               = var.rds.password
  parameter_group_name   = aws_db_parameter_group.default.name
  skip_final_snapshot    = var.rds.skip_final_snapshot
  storage_type           = var.rds.storage_type
  max_allocated_storage  = var.rds.max_allocated_storage
  network_type           = var.rds.network_type
  vpc_security_group_ids = var.db_vpc_id
  db_subnet_group_name   = var.db_sub_group
  publicly_accessible    = var.rds.publicly_accessible
  availability_zone      = var.rds.availability_zone
  backup_window          = var.rds.backup_window
  enabled_cloudwatch_logs_exports = [ "audit", "error", "general", "slowquery" ]
}

resource "aws_db_instance_automated_backups_replication" "rds_back" {
  source_db_instance_arn = aws_db_instance.rds.arn
  retention_period       = 14
}

resource "aws_db_parameter_group" "default" {
  name   = "rds-pg"
  family = "mysql5.7"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}