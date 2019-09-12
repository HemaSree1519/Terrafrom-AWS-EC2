provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

resource "aws_instance" "web_server" {
  ami = "ami-03b6f27628a4569c8"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  tags = {
    Name = "Terraform_EC2"
  }
}