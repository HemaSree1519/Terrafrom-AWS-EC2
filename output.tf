output "eip" {
  value = "${aws_eip.gk_ip.public_ip}"
}