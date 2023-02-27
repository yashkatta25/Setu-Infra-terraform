resource "aws_key_pair" "bastion_host" {


  key_name   = "bastionHost"
  public_key = "bastion_key"

}

resource "aws_security_group" "bastion_host" {
  name   = "SgBsHost"
  vpc_id = aws_vpc.q2-vpc.id

  description = "Security group for bastion Host"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  }





resource "aws_instance" "bastion_host" {
  ami           = "ami-0aedf6b1cb669b4c7"
  instance_type = "t3.micro"

  key_name = aws_key_pair.bastion_host.key_name

  subnet_id              = aws_subnet.public-subnet1.id
  vpc_security_group_ids = [aws_security_group.bastion_host.id]

  associate_public_ip_address = true

   tags = {
    Name = "BastionHost"
  }
}