output "public_ip" {
  value = [aws_instance.myinst.public_ip]
}

output "security_groups" {
  value = [aws_instance.myinst.security_groups]
}

output "private_ip" {
  value = [aws_instance.myinst.private_ip]
}