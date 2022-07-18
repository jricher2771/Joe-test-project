resource "aws_vpc" "test-env" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}


resource "aws_eip" "joe-ip-test-env" {
  instance = "${aws_instance.Joes-web-server.id}"
  vpc      = true
}