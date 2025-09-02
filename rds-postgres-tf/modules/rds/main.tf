resource "aws_db_parameter_group" "postgresql" {
  family = "postgres15"
  name   = "${var.identifier}-parameter-group"

  parameter {
    name  = "max_connections"
    value = "100"
  }

  parameter {
    name  = "shared_buffers"
    value = "{DBInstanceClassMemory/4096}"
  }

  tags = var.tags
}

resource "aws_db_instance" "postgresql" {
  identifier = var.identifier

  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  storage_type         = "gp3"
  storage_encrypted    = true
  
  db_name  = var.db_name
  username = var.username
  password = var.password

  multi_az               = var.multi_az
  publicly_accessible    = false
  parameter_group_name   = aws_db_parameter_group.postgresql.name

  backup_retention_period = var.backup_retention_period
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  monitoring_interval                   = 60
  monitoring_role_arn                  = aws_iam_role.rds_monitoring_role.arn

  skip_final_snapshot = true

  tags = var.tags
}

resource "aws_iam_role" "rds_monitoring_role" {
  name = "rds-monitoring-role-${var.identifier}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_policy" {
  role       = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}