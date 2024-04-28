output "public_ip" {
  value = [aws_instance.myinst1.public_ip]
}

output "security_groups" {
  value = [aws_instance.myinst1.security_groups]
}

output "private_ip" {
  value = [aws_instance.myinst1.private_ip]
}

output "public_ip2" {
  value = [aws_instance.myinst2.public_ip]
}

output "security_groups2" {
  value = [aws_instance.myinst2.security_groups]
}

output "private_ip2" {
  value = [aws_instance.myinst2.private_ip]
}