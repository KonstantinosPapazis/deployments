##########SG for external communication to ALB####
resource "aws_security_group" "test" {
  name   = "test"
  vpc_id = data.aws_vpc.selected.id
}


resource "aws_security_group_rule" "ig_lowcode_from_external_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.test.id
}

resource "aws_security_group_rule" "ig_lowcode_from_external_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.test.id
}

resource "aws_security_group_rule" "eg_lowcode_from_external" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.test.id
}
