resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  count = "${length(var.pub_sub_cidr)}"
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${element(var.pub_sub_cidr,count.index)}"
  map_public_ip_on_launch = true
  tags = {
    name = "${var.pub_sub_name}-${count.index+1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = "${length(var.pri_sub_cidr)}"
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${element(var.pri_sub_cidr,count.index)}"
  map_public_ip_on_launch = false
  tags = {
    name = "${var.pri_sub_name}-${count.index+1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    name = var.igw_name
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "subnet_associate" {
  subnet_id = aws_subnet.public_subnet.0.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.elasticIP.id
  subnet_id = aws_subnet.public_subnet.0.id 
}

resource "aws_eip" "elasticIP" {
  vpc = true 
}

resource "aws_route_table" "route_table_nat" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "subnet_associate_nat" {
  subnet_id = aws_subnet.private_subnet.0.id
  route_table_id = aws_route_table.route_table_nat.id
}

resource "aws_route" "route_nat" {
  route_table_id = aws_route_table.route_table_nat.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.ngw.id
}

resource "aws_route" "route_inside_vpc" {
  route_table_id = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}
