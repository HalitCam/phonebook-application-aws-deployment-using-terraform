data "aws_db_subnet_group" "my_db_subnet_group" {
vpc_id = aws_vpc.my_vpc.id
  name = "${var.project_name}-db-subnet-group"
subnet_ids = aws_subnet.my_subnet_private[*].id
}