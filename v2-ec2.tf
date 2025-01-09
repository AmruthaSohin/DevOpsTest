provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "terraformproject1ec2" {
    ami = "ami-01816d07b1128cd2d"
    instance_type = "t2.micro"
    key_name = "terraform25"
    security_groups = [ "demo-sg" ]
  
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
