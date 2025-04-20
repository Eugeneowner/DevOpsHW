data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ami" "amazon-linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

module "ec2" {
  source            = "./modules/compute"
  instance_type     = var.instance_type
  ami               = data.aws_ami.amazon-linux.id
  vpc_id            = data.aws_vpc.default.id
  subnet_ids        = data.aws_subnets.default_vpc_subnets.ids
  allowed_ports     = var.allowed_ports
  ssh_key_pair_name      = var.ssh_key_pair_name
  instance_count    = var.instance_count
}

resource "local_file" "ssh-key" {
  content         = module.ec2.ssh_private_key
  filename        = "${path.module}/ansible/private.key"
  file_permission = "0400"
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    instance_ips = module.ec2.instance_public_ips
  })
  filename = "${path.module}/ansible/inventory"
}
