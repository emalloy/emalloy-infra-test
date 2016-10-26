
resource "aws_vpc" "emalloy-ro-test" {
  cidr_block = "10.19.0.0/16"

  tags {
    Name = "emalloy-ro-test"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.emalloy-ro-test.id}"
}


# Public subnets

resource "aws_subnet" "eu-central-1-public" {
  vpc_id = "${aws_vpc.emalloy-ro-test.id}"

  cidr_block = "10.19.20.0/24"
  availability_zone = "eu-central-1a"
}

resource "aws_subnet" "eu-central-1a-public" {
  vpc_id = "${aws_vpc.emalloy-ro-test.id}"

  cidr_block = "10.19.21.0/24"
  availability_zone = "eu-central-1a"
}

# Routing table for public subnets

resource "aws_route_table" "eu-central-1-public" {
  vpc_id = "${aws_vpc.emalloy-ro-test.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
}

//resource "aws_route_table_association" "us-east-1b-public" {
//  subnet_id = "${aws_subnet.eu-central-1a-public.id}"
//  route_table_id = "${aws_route_table.eu-central-1-public.id}"
//}

resource "aws_route_table_association" "eu-central-1a-public" {
  subnet_id = "${aws_subnet.eu-central-1a-public.id}"
  route_table_id = "${aws_route_table.eu-central-1-public.id}"
}


resource "aws_security_group" "emalloy-ro-test" {
  name        = "emalloy-ro-test"
  description = "Allow traffic to pass from the public subnet to the internet"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["96.81.77.212/27"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound unfettered
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.emalloy-ro-test.id}"

  tags {
    Name = "emalloy-ro-test-sg"
  }
}


//resource "null_resource" "module_dependency" {
//  depends_on = [
//    "aws_vpc.emalloy-ro-test",
//    "aws_internet_gateway.default",
//    "aws_route_table.eu-central-1-public",
//    "aws_route_table_association.eu-central-1a-public",
//    "aws_security_group.emalloy-ro-test",
//  ]
//}
