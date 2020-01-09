# RDS
resource "aws_db_parameter_group" "workout11" {
  name   = "${var.app_name}-db-parameter-group"
  family = "postgres11"
  
  parameter {
		name  = "timezone"
		value = "Asia/Tokyo"
	}
}

resource "aws_db_subnet_group" "workout11" {
  name       = "${var.app_name}-db-subnet-group"
  subnet_ids = [aws_subnet.private_0.id, aws_subnet.private_1.id]
}

resource "aws_db_instance" "workout11" {
  identifier                 = "${var.app_name}-postgres"
  engine                     = "postgres"
  engine_version             = "11.5"
  instance_class             = "db.t2.micro"
  allocated_storage          = 20
  storage_type               = "gp2"
  storage_encrypted          = false
  name                       = "workout_production"
  username                   = "workout"
  password                   = "password" # 初回apply後に手作業で変更すること
  multi_az                   = true
  publicly_accessible        = false
  backup_window              = "09:10-09:40"
  backup_retention_period    = 30
  maintenance_window         = "mon:10:10-mon:10:40"
  auto_minor_version_upgrade = false
  deletion_protection        = true
  skip_final_snapshot        = false
  port                       = 5432
  apply_immediately          = false
  vpc_security_group_ids     = [module.postgres_sg.security_group_id]
  parameter_group_name       = aws_db_parameter_group.workout11.name
  db_subnet_group_name       = aws_db_subnet_group.workout11.name

  lifecycle {
    ignore_changes = [password]
  }
}

module "postgres_sg" {
  source      = "./security_group"
  name        = "postgres-sg"
  tag_name    = "postgres-sg"
  vpc_id      = aws_vpc.workout11.id
  port        = 5432
  cidr_blocks = [aws_vpc.workout11.cidr_block]
}