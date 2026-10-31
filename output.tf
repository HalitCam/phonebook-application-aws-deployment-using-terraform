output "alb_dns_name_address" {
  value = "http://${aws_alb.my_alb.dns_name}"
}
output "rds_endpoint_address" {
  value = "${aws_db_instance.my_db_instance.address}"
}