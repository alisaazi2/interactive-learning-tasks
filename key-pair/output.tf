

output "SomeOutput" {
  value = <<EOF

        region         us-east-2
        key name        ${aws_key_pair.ilearning-wordpress.key_name}
        key_id         ${aws_key_pair.ilearning-wordpress.key_pair_id}
       


    EOF
}