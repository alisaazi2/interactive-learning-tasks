resource "aws_route53_record" "www" {
  zone_id = "Z0648901DS0OL2QVJM4W"
  name    = "blog.alisavevops.com"
  type    = "A"
  ttl     = "300"
  records = ["127.0.0.1"]

}