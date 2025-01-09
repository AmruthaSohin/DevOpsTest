provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "terraformproject1ec2" {
    ami = "ami-01816d07b1128cd2d"
    instance_type = "t2.micro"
    key_name = "terraform25"
  
}