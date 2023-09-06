output "rds_database_endpoint_rw" {
  value = module.rds.aws_rds_cluster.endpoint
}