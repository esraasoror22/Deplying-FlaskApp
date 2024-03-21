
#create subnet subnetGroup
resource "aws_db_subnet_group" "terra" {
  name       = "main"
  subnet_ids = var.subnet_id

  tags = {

    Name = "Flask subnet group"

  }
}

#create RDS instance aws_db_instance.default
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  #parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name   = aws_db_subnet_group.terra.name
  publicly_accessible    = false
}

