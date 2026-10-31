resource "aws_route53_record" "my_record" {
  zone_id = var.hosted_zone_name.id
  name    = "phonebook.${var.hosted_zone_name}"
  type    = "A"

  alias {
    name                   = aws_alb.my_alb.dns_name
    zone_id                = aws_alb.my_alb.zone_id
    evaluate_target_health = true
  }
}