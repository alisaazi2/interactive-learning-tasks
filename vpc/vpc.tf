resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags             = {
    Team      = "DevOps"
    Environment = "Dev"
  }

}

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.101.0/24"
  map_public_ip_on_launch = true             
  availability_zone       = "eu-west-1a" 
  tags                    =  {
    Team      = "DevOps"
    Environment = "Dev"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.102.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1b"
  tags                    = {
    Team      = "DevOps"
    Environment = "Dev"
  }
}


resource "aws_subnet" "public3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.103.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1c"
  tags                    = {
    Team      = "DevOps"
    Environment = "Dev"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = {
    Team      = "DevOps"
    Environment = "Dev"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = var.tags
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public3" {
  subnet_id      = aws_subnet.public3.id
  route_table_id = aws_route_table.public.id
}
resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a" 
  tags              = {
    Team      = "DevOps"
    Environment = "Dev"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-1b"
  tags              = {
    Team      = "DevOps"
    Environment = "Dev"
  }
}


resource "aws_subnet" "private3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-1c"
  tags              = {
    Team      = "DevOps"
    Environment = "Dev"
  }
}

resource "aws_eip" "main" {
  vpc  = true
  tags = {
    Team      = "DevOps"
    Environment = "Dev"
  }
}


resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public1.id
  tags          = {
    Team      = "DevOps"
    Environment = "Dev"
  }
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.example.id
  }
  tags = {
    Team      = "DevOps"
    Environment = "Dev"
  }
}



resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private3" {
  subnet_id      = aws_subnet.private3.id
  route_table_id = aws_route_table.private.id
}