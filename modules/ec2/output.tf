output "instance_ids" {
  value = {
    a = aws_instance.instance_A.id
    b = aws_instance.instance_B.id
    c = aws_instance.instance_C.id
  }
}