resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 20
  allow_users_to_change_password = true
  password_reuse_prevention = 10
  require_numbers = true
  max_password_age = 90
  require_symbols = true
  allow_users_to_change_password = true
  
}