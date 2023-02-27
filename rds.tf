resource "aws_security_group" "database_security_group" {
  name        = "database-security-group"
  description = "Default security group"
  vpc_id      = aws_vpc.q2-vpc.id

  tags = {
    Name                 = "sg-database"
  }

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    cidr_blocks = [
      "10.0.200.0/24","10.0.100.0/24"
    ]
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}
module "rds" {
  source                          = "./Module/rds"
  vpc_id                          = aws_vpc.q2-vpc.id
  subnets                         = [aws_subnet.privet-subnet1.id, aws_subnet.privet-subnet1.id]
  project                         = "database"
  environment                     = "production"
  size                            = "db.t2.small"
  security_groups                 = [aws_security_group.database_security_group.id]
  enabled_cloudwatch_logs_exports = ["audit", "error", "slowquery"]
  security_groups_count           = 1
  rds_password                    = "supersecurepassword"
  multi_az                        = "false"
}

