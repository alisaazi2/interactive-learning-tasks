module "key-pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "1.0.0"
  key_name   ="created_by_terraform"
  public_key = file("~/.ssh/id_rsa.pub")
  tags = {
    Team        = "DevOps"
    Environment = "Dev"
  }
}
