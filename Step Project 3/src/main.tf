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


module "vpc" {
  source              = "./modules/network"
  owner               = var.owner
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  az1                 = var.az1
}


module "compute" {
  source            = "./modules/compute"
  public_ssh_key    = var.public_ssh_key
  owner             = var.owner
  vpc_id            = module.vpc.vpc_id
  ami               = data.aws_ami.amazon-linux.id
  instance_type     = var.instance_type
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  allowed_ports     = var.allowed_ports
}


resource "local_file" "ssh-key" {
  content         = module.compute.private_ssh_key
  filename        = "${path.module}/ansible/${var.private_ssh_key}"
  file_permission = "0400"
}


resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/tpls/inventory.tpl", {
    public_instance_ip  = module.compute.public_ec2_public_ip,
    private_instance_ip = module.compute.private_ec2_private_ip,
    ssh_key_name        = var.private_ssh_key
  })
  filename = "${path.module}/ansible/inventory"
}


resource "local_file" "nginx_default_conf" {
  content = templatefile("${path.module}/tpls/nginx-default-conf.tpl", {
    public_instance_ip = module.compute.public_ec2_public_ip
  })
  filename = "${path.module}/ansible/nginx-default.conf"
}