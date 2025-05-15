output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}
output "public_ec2_ip" {
  value = module.compute.public_ec2_public_ip
}


output "private_ec2_ip" {
  value = module.compute.private_ec2_private_ip
}