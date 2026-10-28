resource "aws_rds_instance" "my_rds_instance" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.19"
  instance_class       = "db.t3.micro"
  name                 = "${var.project_name}_db"
  username             = "admin"
  password             = "halit1234"
  skip_final_snapshot  = true
  publicly_accessible  = false
  
  vpc_security_group_ids = [aws_security_group.my_rds_sg.id]

  db_subnet_group_name   = data.aws_db_subnet_group.my_db_subnet_group.name

  tags = {
    Name = "${var.project_name}-rds-instance"
  }
}