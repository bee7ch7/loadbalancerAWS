resource "aws_acm_certificate" "cert" {
  domain_name       = "meldm.ml"
  subject_alternative_names = ["www.meldm.ml", "meldm.ml"]
  validation_method = "DNS"

  tags = {
    Environment = "prod"
  }

    lifecycle {
    ignore_changes = all
  }

#   lifecycle {
#     create_before_destroy = true
#   }
}


