resource "aws_route_table_association" "public01" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public01.id
}

resource "aws_route_table_association" "public02" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public02.id
}

resource "aws_route_table_association" "private01" {
  route_table_id = aws_route_table.private01.id
  subnet_id      = aws_subnet.private01.id
}

resource "aws_route_table_association" "private02" {
  route_table_id = aws_route_table.private02.id
  subnet_id      = aws_subnet.private02.id
}