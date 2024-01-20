resource "aws_security_group" "allow-all" {
  name        = "allow-all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.default.id
  #-1 in protocol means "all protocols are allowed"
  #In this case, 0.0.0.0/0 allows traffic from any IP address
  ingress {
    description = "allow all inbound-traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all"
  }


}
