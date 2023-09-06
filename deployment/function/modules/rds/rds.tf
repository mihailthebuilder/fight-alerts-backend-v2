resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier          = "${var.product}-${var.environment}-cluster"
  engine                      = "aurora-postgresql"
  apply_immediately           = true
  master_username             = var.db_username
  master_password             = var.db_password
  skip_final_snapshot         = true
  engine_version              = "14.6"
  allow_major_version_upgrade = true
  publicly_accessible         = true
  # vpc_security_group_ids      = [aws_security_group.rds_cluster_security_group.id]
}

resource "aws_rds_cluster_instance" "single_instance" {
  count               = 1
  identifier          = "${var.product}-${var.environment}-instance-${count.index}"
  cluster_identifier  = aws_rds_cluster.rds_cluster.cluster_identifier
  apply_immediately   = true
  engine              = aws_rds_cluster.rds_cluster.engine
  instance_class      = "db.t3.medium"
  engine_version      = aws_rds_cluster.rds_cluster.engine_version
  publicly_accessible = true
  ca_cert_identifier  = "rds-ca-rsa2048-g1"
}