provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}
resource "aws_security_group" "google-keep" {
  name = "google-keep"
  description = "Security Group"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_eip" "gk_ip" {
  instance = "${aws_instance.web_server.id}"
  vpc      = true
}
resource "tls_private_key" "RSA" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.key_name}"
  public_key = "${tls_private_key.RSA.public_key_openssh}"
}
resource "aws_instance" "web_server" {
  ami = "ami-03b6f27628a4569c8"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  security_groups = ["${aws_security_group.google-keep.name}"]
  key_name      = "google-keep"
  tags = {
    Name = "Google-Keep"
  }
}