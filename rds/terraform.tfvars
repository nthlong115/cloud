rds = {
  allocated_storage     = 10
  availability_zone     = "us-east-1"
  backup_window         = "09:46-10:16"
  db_name               = "mydb"
  engine                = "mysql"
  engine_version        = "5.7.33"
  instance_class        = "db.t3.micro"
  max_allocated_storage = 1
  network_type          = "IPV4"
  password              = "admin"
  publicly_accessible   = false
  skip_final_snapshot   = true
  storage_type          = "gp2"
  username              = "admin"
}