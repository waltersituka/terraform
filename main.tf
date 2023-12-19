resource "aws_db_instance" "default" {
  allocated_storage    = var.db_storage
  storage_type         = var.storage_type
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot

}

##############################################
resource "aws_instance" "web" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  key_name          = var.key_name

  tags = {
    Name = "dev"
  }
}
#################################################################
resource "aws_vpc" "aws_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "rds_vpc"
  }
}
######################################################
resource "aws_subnet" "priv_subnet" {
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "priv_subnet"
  }
}
##########
resource "aws_subnet" "pub_subnet" {
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "pub_subnet"
  }
}
#########################################################
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.aws_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "pub_rt"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.aws_vpc.id

  tags = {
    Name = "igw"
  }
}
################################################################
resource "aws_route_table_association" "pub-rt-ass" {
  subnet_id      = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_eip" "eip" {
  instance = aws_instance.web.id
}
##################################################
resource "aws_nat_gateway" "nat_gateway" {
  subnet_id = aws_subnet.pub_subnet.id
  allocation_id = aws_eip.eip.id

  tags = {
    Name = "nat_gateway"
  }
}
#########################################################
resource "aws_route_table" "priv_rt" {
  vpc_id = aws_vpc.aws_vpc.id

  route {
    cidr_block = "10.0.1.0/24"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }


  tags = {
    Name = "pub_rt"
  }
}

################################################################
resource "aws_route_table_association" "priv-rt-ass" {
  subnet_id      = aws_subnet.priv_subnet.id
  route_table_id = aws_route_table.priv_rt.id
}