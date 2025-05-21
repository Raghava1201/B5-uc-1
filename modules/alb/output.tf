output "alb_dns_name" {
  value = aws_lb.application.dns_name
}

output "target_group_a_arn" {
  value = aws_lb_target_group.a.arn
}

output "target_group_b_arn" {
  value = aws_lb_target_group.b.arn
}

output "target_group_c_arn" {
  value = aws_lb_target_group.c.arn
}