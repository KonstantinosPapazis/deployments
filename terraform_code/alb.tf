resource "aws_alb" "test" {
  name            = "test-alb"
  internal        = true
  security_groups = [aws_security_group.test.id]
  subnets         = data.aws_subnets.vpc_subnets.ids

  #access_logs {
  #  bucket  = var.alb_log_bucket.id
  #  prefix  = "alb-ckan"
  #  enabled = true
  #}

  idle_timeout = 60
 # tags         = merge(local.common_tags, { "Name" = "lowcode_alb_sg" }, { "Purpose" = "security" }, { "Version" = "v1_0_0" })
}

resource "aws_alb_listener" "test-http" {
  load_balancer_arn = aws_alb.test.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.test-http.arn
  }

  #tags = merge(local.common_tags, { "Name" = "lowcode_alb_sg" }, { "Purpose" = "security" }, { "Version" = "v1_0_0" })
}

resource "aws_alb_target_group" "test-http" {
  name     = "test-http"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected.id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  #tags = merge(local.common_tags, { "Name" = "lowcode_alb_sg" }, { "Purpose" = "security" }, { "Version" = "v1_0_0" })
}



#resource "aws_alb_listener" "lowcode-http" {
#  load_balancer_arn = aws_alb.test.arn
#  port              = 80
#  protocol          = "HTTP"
#
#  #  default_action {
#  #    type             = "forward"
#  #    target_group_arn = aws_alb_target_group.ckan-http.arn
#  #  }
#
#  default_action {
#    type = "redirect"
#
#    redirect {
#      port        = 443
#      protocol    = "HTTPS"
#      status_code = "HTTP_301"
#    }
#  }
#
#  #tags = merge(local.common_tags, { "Name" = "lowcode_alb_sg" }, { "Purpose" = "security" }, { "Version" = "v1_0_0" })
#}


#resource "aws_alb_listener" "lowcode-https" {
#  load_balancer_arn = aws_alb.lowcode.id
#  port              = "443"
#  protocol          = "HTTPS"
#
#  certificate_arn = data.aws_acm_certificate.aws_pictet_cloud.arn
#
#  default_action {
#    type             = "forward"
#    target_group_arn = aws_alb_target_group.lowcode-http.id
#  }
#
#  tags = merge(local.common_tags, { "Name" = "lowcode_alb_sg" }, { "Purpose" = "security" }, { "Version" = "v1_0_0" })
#}
#
#resource "aws_alb_target_group" "lowcode-http" {
#  name                 = "lowcode-target"
#  protocol             = "HTTP"
#  vpc_id               = data.aws_vpc.selected.id
#  target_type          = "ip"
#  port                 = var.lowcode_port
#  deregistration_delay = 30
#  health_check {
#    interval            = 61
#    path                = "/api/checkHealth"
#    protocol            = "HTTP"
#    timeout             = 60
#    healthy_threshold   = 3
#    unhealthy_threshold = 2
#  }
#
#  tags = merge(local.common_tags, { "Name" = "lowcode_alb_sg" }, { "Purpose" = "security" }, { "Version" = "v1_0_0" })
#}
