resource "aws_route53_record" "www" {
  zone_id = "Z0648901DS0OL2QVJM4W"
  name    = "wordpress.alisavevops.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.web.public_ip]

}