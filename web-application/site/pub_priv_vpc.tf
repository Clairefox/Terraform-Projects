resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}
output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

#
# NAT Instance
#
resource "aws_instance" "nat" {
  ami = "ami-75ae8245" # this is a special ami preconfigured to do NAT
  availability_zone = "${element(var.availability_zones, 0)}"
  instance_type = "t2.small"
  key_name = "${var.key_name}"
  security_groups = ["${aws_security_group.nat.id}"]
  subnet_id = "${aws_subnet.demo_public.id}"
  associate_public_ip_address = true
  source_dest_check = false
}

resource "aws_eip" "nat" {
  instance = "${aws_instance.nat.id}"
  vpc = true
}

#
# Public Subnet
#
resource "aws_subnet" "demo_public" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "${element(var.availability_zones, 0)}"
}
output "public_subnet_id" {
  value = "${aws_subnet.demo_public.id}"
}

resource "aws_route_table" "demo_public" {
  vpc_id = "${aws_vpc.default.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.default.id}"
  }

}

resource "aws_route_table_association" "demo_public" {
  subnet_id = "${aws_subnet.demo_public.id}"
  route_table_id = "${aws_route_table.demo_public.id}"
}

#
# Private Subnet
#
resource "aws_subnet" "demo_private" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "${element(var.availability_zones, 0)}"

}
output "private_subnet_id" {
  value = "${aws_subnet.demo_private.id}"
}

resource "aws_route_table" "demo_private" {
  vpc_id = "${aws_vpc.default.id}"
  route {
      cidr_block = "0.0.0.0/0"
      instance_id = "${aws_instance.nat.id}"
  }

}

resource "aws_route_table_association" "demo_private" {
  subnet_id = "${aws_subnet.demo_private.id}"
  route_table_id = "${aws_route_table.demo_private.id}"
}
