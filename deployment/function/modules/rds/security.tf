resource "aws_security_group" "rds_cluster_security_group" {
  name   = "${var.product}-${var.environment}-rds-cluster-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "allow_ip_to_rds_cluster" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["${var.ip_address}/32"]
  security_group_id = aws_security_group.rds_cluster_security_group.id
}

resource "aws_security_group_rule" "allow_sg_to_rds_cluster" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = var.allow_access_from_security_group_id
  security_group_id        = aws_security_group.rds_cluster_security_group.id
}

resource "aws_security_group_rule" "allow_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_cluster_security_group.id
}