
output "region" {
  value = "us-east-1"
}

output "az" {
  value = aws_instance.web.availability_zone
}
output "public_ip" {
  value = aws_instance.web.public_ip
}
output "instance_id" {
  value = aws_instance.web.id
}



