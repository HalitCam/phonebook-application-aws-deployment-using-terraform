resource "aws_db_instance" "my_db_instance" {
  allocated_storage = 20
  engine            = "mysql"
  engine_version    = "8.4"
  instance_class    = "db.t3.micro"

  db_name  = "phonebook"
  username = "admin"
  password = "halit1234"

  skip_final_snapshot     = true
  publicly_accessible     = false
  backup_retention_period = 0
  multi_az                = false

  vpc_security_group_ids = [aws_security_group.my_rds_sg.id]

  db_subnet_group_name = aws_db_subnet_group.my_subnet_private.name
  tags = {
    Name = "${var.project_name}-rds-instance"
  }
}


