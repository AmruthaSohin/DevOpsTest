provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "v2-ec2" {
    ami = "ami-01816d07b1128cd2d"
    instance_type = "t2.micro"
    key_name = "terraform25"
    security_groups = [ "demo_sg" ]
  
}

resource "aws_security_group" "demo_sg" {
  name        = "demo_sg"
  description = "SSH access"

  # Ingress rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your allowed IP range
  }

  # Egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }

  tags = {
    Name = "demo-sg"
  }
}

resource "aws_vpc" "demovpc"{
  cidr_blocks = "10.1.0.0/16"
  tags = {
    Name = "demovpc"
  }
}

resource "aws_subnet" "dpw-public_subent_01" {
  vpc_id = aws_vpc.demovpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
  tags = {
    Name = "dpw-public_subent_01"
  }
}

resource "aws_internet_gateway" "dpw-igw" {
  vpc_id = aws_vpc.demovpc.id
  tags = {
    Name = "dpw-igw"
  }
}

resource "aws_route_table" "dpw-public-rt" {
  vpc_id = aws_vpc.demovpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.dpw-igw.id
  }
  tags = {
    Name = "dpw-public-rt"
  }
}

resource "aws_route_table_association" "dpw-rta-public-subent-1" {
  subnet_id = aws_subnet.dpw-public_subent_01.id
  route_table_id = aws_route_table.dpw-public-rt.id
}
