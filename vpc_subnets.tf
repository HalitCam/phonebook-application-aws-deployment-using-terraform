resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_subnet" "my_subnet_public" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1${count.index}.0/24"
  availability_zone       = var.availability_zones[count.index]
  count                   = var.subnet_count
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-publicsubnet-${count.index + 1}"
  }
}

resource "aws_subnet" "my_subnet_private" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2${count.index}.0/24"
  availability_zone = var.availability_zones[count.index]
  count             = var.subnet_count

  tags = {
    Name = "${var.project_name}-privatesubnet-${count.index + 1}"
  }
}

resource "aws_db_subnet_group" "my_subnet_private" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = aws_subnet.my_subnet_private[*].id

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}