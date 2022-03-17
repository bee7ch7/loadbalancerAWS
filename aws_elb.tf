resource "aws_elb" "main-elb" {
    name = "main-elb"
    subnets = [aws_subnet.subnet1.id,aws_subnet.subnet2.id]

    security_groups = [aws_security_group.sec-group.id]

    listener {
      instance_port = 80
      instance_protocol = "http"
      lb_port = 80
      lb_protocol = "http"
    }

    listener {
      instance_port = 80
      instance_protocol = "http"
      lb_port = 443
      lb_protocol = "https"
      ssl_certificate_id = aws_acm_certificate.cert.id
    }

    health_check {
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 3
      target = "HTTP:80/"
      interval = 30
    }

    instances = [aws_instance.win-instance-1.id, aws_instance.win-instance-2.id]
    # cross_zone_load_balancing = true
    # idle_timeout = 400
    # connection_draining = true
    # connection_draining_timeout = 400

    tags = {
        Name = "Main ELB"
    }
  
}

# resource "aws_lb_listener_certificate" "meldmcert" {
#   listener_arn    = aws_elb.main-elb.arn
#   certificate_arn = aws_acm_certificate.cert.arn
# }
