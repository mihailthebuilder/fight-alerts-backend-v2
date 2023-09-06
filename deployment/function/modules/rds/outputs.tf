output "rds_database_endpoint_rw" {
  value = aws_rds_cluster.rds_cluster.endpoint
}