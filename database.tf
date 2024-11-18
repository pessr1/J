
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my_db_subnet_group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id, aws_subnet.private_subnet_3.id]
  tags = {
    Name = "My DB Subnet Group"
  }
}

resource "aws_db_instance" "my_db_instance" {
  allocated_storage      = 20  # Consider increasing if needed
  max_allocated_storage  = 100 # Enable storage autoscaling
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  identifier             = var.db_name
  db_name                = var.db_name
  username               = var.db_user
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  tags = {
    Name = "My DB"
  }
}

output "rds_endpoint" {
  value = aws_db_instance.my_db_instance.endpoint
}