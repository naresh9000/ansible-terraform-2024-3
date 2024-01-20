resource "aws_route_table" "terrform-public-rtb" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
  tags = {
    Name = "${var.vpc_name}-public-rt"
  }


}

resource "aws_route_table_association" "terrform-public-rtb-1" {
  subnet_id      = aws_subnet.subnet1-public.id
  route_table_id = aws_route_table.terrform-public-rtb.id

}

resource "aws_route_table_association" "terrform-public-rtb-2" {
  subnet_id      = aws_subnet.subnet2-public.id
  route_table_id = aws_route_table.terrform-public-rtb.id

}

resource "aws_route_table_association" "terrform-public-rtb-3" {
  subnet_id      = aws_subnet.subnet3-public.id
  route_table_id = aws_route_table.terrform-public-rtb.id

}
