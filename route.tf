resource "aws_route_table" "public" {
    vpc_id = aws_vpc.q2-vpc.id
    tags = {
      "Name" = "public"
    }
}

resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.q2-vpc.id
  tags = {
    "Name" = "private1"
  }     
}
resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.q2-vpc.id
  tags = {
    "Name" = "private2"
  }
}

resource "aws_route" "private1" {

  route_table_id         = aws_route_table.private1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat1.id
}


resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.q2-gw.id
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.privet-subnet1.id
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.privet-subnet2.id
  route_table_id = aws_route_table.private2.id
}