output "public_ec2_public_ip" {
  value = aws_instance.jenkins_master.public_ip
}

output "private_ec2_private_ip" {
  value = aws_instance.jenkins_worker.private_ip
}

output "private_ssh_key" {
  value     = tls_private_key.generated.private_key_pem
  sensitive = true
}