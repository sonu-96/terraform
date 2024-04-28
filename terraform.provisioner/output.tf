output "public_ip" {
  value = [aws_instance.provisioning.public_ip]
}

output "private_ip" {
  value = [aws_instance.provisioning.private_ip]
}