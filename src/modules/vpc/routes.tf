#########################################
#   Route tables
#########################################

# Public RT → IGW
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = { Name = "${var.vpc_name}-public-rt" }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private RT → NAT GW  (по одной RT на каждую AZ, все через ОДИН NAT GW)
resource "aws_route_table" "private" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.this.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id # ⬅ без индексов!
  }
  tags = { Name = "${var.vpc_name}-private-rt-${count.index + 1}" }
}

resource "aws_route_table_association" "private" {
  count     = length(aws_subnet.private)
  subnet_id = aws_subnet.private[count.index].id
  # равномерно распределяем подсети по RT
  route_table_id = element(aws_route_table.private[*].id, count.index % length(aws_route_table.private))
}
