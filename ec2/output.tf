output "SomeOutput" {
  value = <<EOF
  IP_address  =   ${aws_instance.web.public_ip}
    ID  =         ${aws_instance.web.id}
    AZ    =        ${aws_instance.web.availability_zone}
   

 EOF 
}