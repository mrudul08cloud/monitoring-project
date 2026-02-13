resource "aws_db_subnet_group" "todo_rds_subnet" {
  name       = "todo-rds-subnet-group"
  subnet_ids = var.public_subnet_ids

  tags = {
    Name = "todo-rds-subnet-group"
  }
}

resource "aws_security_group" "todo_rds_sg" {
  name        = "todo-rds-sg"
  description = "Allow postgres access"
  vpc_id      = var.vpc_id

  ingress {
    description = "PostgreSQL access"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # open for now (later restrict)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "todo-rds-sg"
  }
}

resource "aws_db_instance" "todo_postgres" {
  identifier             = "todo-postgres"
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"

  db_name                = "tododb"
  username               = "postgres"
  password               = "Devops12345"

  publicly_accessible    = true
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.todo_rds_subnet.name
  vpc_security_group_ids = [aws_security_group.todo_rds_sg.id]

  tags = {
    Name = "todo-postgres"
  }
}
