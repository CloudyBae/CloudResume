output "load_balancer_dns" {
    value = aws_lb.nginx-alb.dns_name
}