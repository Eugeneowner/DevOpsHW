output "instance_public_ips" {
  value = [for instance in aws_instance.ec2_instance : instance.public_ip]
}

output "ssh_private_key" {
  value     = tls_private_key.ssh.private_key_openssh
  sensitive = true
}
