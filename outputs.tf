output "load_balancer_dns" {
  description = "Public URL for ALB"
  value       = aws_lb.nginx-alb.dns_name
}

output "db_name" {
  description = "Database Name"
  value       = aws_db_instance.wordpress_rds_instance.db_name
}