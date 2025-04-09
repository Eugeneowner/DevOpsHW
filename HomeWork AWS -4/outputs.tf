output "public_instance_ip" {
  value = aws_instance.hw-instance-public.public_ip
}

output "private_instance_ip" {
  value = aws_instance.hw-instance-private.private_ip
}

output "vpc_id" {
  value = aws_vpc.hw-vpc.id
}

output "tls_private_key" {
  value     = tls_private_key.ssh-key.private_key_pem
  sensitive = true
}