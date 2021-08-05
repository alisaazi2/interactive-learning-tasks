

data "aws_vpc" "selected" {
  
}


data "aws_subnet_ids" "example" {
  vpc_id = data.aws_vpc.selected.id
}

data "aws_subnet" "example" {
  for_each = data.aws_subnet_ids.example.ids
  id       = each.value
}
resource "aws_db_subnet_group" "default" {
  name = "main"
  subnet_ids = data.aws_subnet_ids.example.ids
  
}