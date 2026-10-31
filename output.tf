output "alb_dns_name_address" {
  value = "http://${aws_alb.my_alb.dns_name}"
}

output "my_website_url" {
  value = "http://phonebook.${var.hosted_zone_name}"
}