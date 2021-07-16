data "aws_region" "current" {}

output "region" {
  value = data.aws_region.current.name
}
output "key_name" {
  value = aws_key_pair.ilearning-wordpress.key_name
}
output "key_id" {
  value = aws_key_pair.ilearning-wordpress.key_pair_id
}
