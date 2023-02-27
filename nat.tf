resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.public-subnet1.id
  depends_on    = [aws_internet_gateway.q2-gw]
}


resource "aws_eip" "nat1" {
  vpc = true
}

