output "DnsValidationStrings" {
  value = aws_acm_certificate.cert.domain_validation_options
}

output "PublicElbDns" {
    value = aws_elb.main-elb.dns_name
  }