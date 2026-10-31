output "alb_dns_name_address" {
  value = "http://${aws_alb.my_alb.dns_name}"
}